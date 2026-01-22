/// <summary>
/// Table Annual Workplan Header (ID 50037).
/// </summary>
table 50469 "Annual Workplan Header"
{
    Caption = 'Annual Workplan Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Financial Period"; Code[50])
        {
            Caption = 'Financial Period';
            DataClassification = ToBeClassified;
        }


        field(2; "Created By"; code[50])
        {
            Editable = false;

        }
        field(3; Closed; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Financial Period")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;

    /// <summary>
    /// SendKras.
    /// </summary>
    procedure SendKras()
    begin
        Wpheader.Reset();
        Wpheader.SetRange("Financial Period", rec."Financial Period");
        Wpheader.SetRange(Closed, false);
        if Wpheader.Find('-') then begin
            Wplist.SetRange("Financial Period", Wpheader."Financial Period");
            Wplist.SetRange(Transferred, false);
            if Wplist.Find('-') then begin
                Targets.Period := Wplist."Financial Period";
                Targets.Reset();
                Targets.SetRange(Period, Wplist."Financial Period");
                if Targets.Find('-') then begin
                    repeat
                        Targets.Init();
                        Targets."No." := Wplist."S/N";

                        Targets."Global Dimension 2 Code" := Wplist."Global Dimension 2 Code";
                        Targets.KRA := Wplist."Key Result Area";
                        Targets."Strategic Objectives" := Wplist."Strategic Objective";
                        Targets.Activity := Wplist.Activities;
                        Targets.Insert();
                    until Wplist.Next() = 0;
                end;
                Wplist.Transferred := true;
                Wplist.Modify();
            end;
            Message('Targets Updated Successfully');
        end;




    end;

    var
        Employee: record "HRM-Employee C";
        fieldeditable: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Dimension: record "Dimension Value";
        Usersetup: record "User Setup";
        Appsetup: record "Appraisal Setups";
        Targets: record "Targets kra kpi";
        Wpheader: record "Annual Workplan Header";
        Wplist: record "Annual Workplan List";
        Perfomancerev: record "Perfomance Review";
        Appraisal: Record Appraisal;
}
