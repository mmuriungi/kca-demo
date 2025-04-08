table 50008 "Auditors List"
{
    Caption = 'Auditors List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Auditors No"; Code[90])
        {
            Caption = 'Auditors No';
        }
        field(2; "Auditor No"; Code[90])
        {
            Caption = 'Auditor No';
            TableRelation = "HRM-Employee C";
            trigger OnValidate()
            var
                ObjEmp: Record "HRM-Employee C";
            begin
                ObjEmp.Reset();
                ObjEmp.SetRange(ObjEmp."No.", "Auditor No");
                if ObjEmp.FindFirst() then begin
                    "Auditor Name" := ObjEmp."First Name" + ObjEmp."Middle Name" + ObjEmp."Last Name";
                    "Auditor Email" := ObjEmp."E-Mail";
                end;
            end;
        }
        field(3; "Auditor Name"; Text[250])
        {
            Caption = 'Auditor Name';
        }
        field(4; "Auditor Email"; Text[100])
        {
            Caption = 'Auditor Email';
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(6; "Communication No"; Code[90])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Communication Header";
        }
        field(7; Role; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Team Leader",Member;
        }
    }
    keys
    {
        key(PK; "Auditors No", "Communication No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        AuditSetup: Record "Audit Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        AuditSetup.Get;

        if "Auditors No" = '' then begin
            begin
                AuditSetup.TestField("Auditors No");
                if "Auditors No" = '' then
                    NoSeriesMgt.InitSeries(AuditSetup."Auditors No", xRec."No. Series", 0D, "Auditors No", "No. Series");
            end;
        end;
    end;

}
