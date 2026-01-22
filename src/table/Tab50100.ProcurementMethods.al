table 50100 "Procurement Methods"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Invite/Advertise date"; Date)
        {
        }
        field(4; "Invite/Advertise period"; DateFormula)
        {
        }
        field(5; "Open tender period"; Integer)
        {
        }
        field(6; "Evaluate tender period"; Integer)
        {
        }
        field(7; "Committee period"; Integer)
        {
        }
        field(8; "Notification period"; Integer)
        {
        }
        field(9; "Contract period"; Integer)
        {
        }
        field(11; "Planned Date"; Date)
        {
        }
        field(12; "Planned Days"; DateFormula)
        {
        }
        field(13; "Actual Days"; DateFormula)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        WorkplanActivities.RESET;
        WorkplanActivities.SETRANGE("Workplan Code", Code);
        IF WorkplanActivities.FIND('-') THEN BEGIN
            ERROR('You cannot delete this Workplan [ %1 ] because it is in use in Workplan [ %2 ]', Code, WorkplanActivities."Workplan Code");
        END;

        TenderPlanHeader.RESET;
        TenderPlanHeader.SETRANGE(TenderPlanHeader."Workplan Code", Code);
        IF TenderPlanHeader.FIND('-') THEN BEGIN
            ERROR('You cannot delete this Workplan [ %1 ] because it is in use in Tender Card [ %2 ]', Code, TenderPlanHeader."No.");
        END;
    end;

    var
        ProcMethodStageDuration: Record "Procurement Method Stages";
        WorkplanActivities: Record "Workplan Activities";
        TenderPlanHeader: Record "Tender Plan Header";
}

