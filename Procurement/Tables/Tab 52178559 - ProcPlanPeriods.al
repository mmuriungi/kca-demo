table 52178559 "Proc Plan Periods"
{
    Caption = 'Proc Plan Periods';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Fy; Code[50])
        {
            Caption = 'Fy';
            tablerelation = "G/L Budget Name".Name;
            trigger OnValidate()
            begin
                CheckCurrentPeriod();
                Cashofficesetup.Reset();
                Cashofficesetup.SetRange("Current Budget", Fy);
                if Cashofficesetup.Find('-') then
                    "Start Date" := Cashofficesetup."Current Budget Start Date";
                "End Date" := Cashofficesetup."Current Budget End Date";
            end;
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(4; Current; Boolean)
        {
            Editable = false;
            Caption = 'Current';
        }
        field(5; Closed; Boolean)
        {
            Editable = false;
            Caption = 'Closed';
        }
    }
    keys
    {
        key(PK; Fy)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CheckCurrentPeriod;
        Current := true;
    end;

    procedure CheckCurrentPeriod()
    begin
        rec.Reset();
        rec.SetRange(Current, true);
        if rec.Count > 1 then
            error('Current period cannot be more than 1')
    end;

    procedure ClosedPeriod()
    begin
        Reset();
        SetRange(Current, true);
        SetRange(Closed, false);
        if Find('-') then begin
            Closed := true;
            Current := false;
            Modify();
            PlanHeader.Reset();
            PlanHeader.SetRange("Budget Name", rec.Fy);
            if PlanHeader.Find('-') then begin
                repeat
                    PlanHeader.Active := false;
                    PlanHeader.Modify();
                until PlanHeader.Next() = 0;
            end;
            ConsoHeader.Reset();
            ConsoHeader.SetRange(Fy, rec.Fy);
            ConsoHeader.SetRange(Active, true);
            if ConsoHeader.Find('-') then begin
                ConsoHeader.Active := false;
                ConsoHeader.Modify();
            end;
            Message('%1 Closed', Fy);
        end;
    end;

    var
        Cashofficesetup: Record "Cash Office Setup";
        PlanHeader: Record "PROC-Procurement Plan Header";
        ConsoHeader: Record "Proc Consolidated Header";
}
