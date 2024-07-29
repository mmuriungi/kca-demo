table 50126 "Proc-Committee Membership"
{
    DrillDownPageId = "Proc-Committee Membership";
    LookupPageId = "Proc-Committee Membership";
    fields
    {

        field(1; "No."; Code[50])
        {

        }
        field(2; "Staff No."; code[30])
        {
            TableRelation = "Proc-Committee Members"."Member No" where(Committee = field("Committee Type"), "Ref No" = field("No."));
            trigger OnValidate()
            var
                hrm: Record "Proc-Committee Members";
            begin
                hrm.Reset();
                hrm.SetRange("Member No", rec."Staff No.");
                if hrm.Find('-') then begin
                    Name := hrm.Name;
                    Email := hrm.Email;
                    "Telephone No." := hrm."Phone No";
                end;

            end;
        }
        field(3; "Name"; Text[100])
        {
            Editable = false;

        }

        field(4; "Entry No."; Integer)
        {

        }
        field(5; "Telephone No."; Text[20])
        {

        }
        field(6; "Committee Type"; Option)
        {
            OptionMembers = "","Opening Commitee","Evaluation Committee";
        }
        field(7; "Initiate Opening"; Option)
        {
            OptionMembers = "","Initiate Opening";
            trigger OnValidate()
            var
                rfq: Record "PROC-Purchase Quote Header1";
            begin
                if Confirm('Confirm Opening ? ', true) = false then Error('Cancelled');
                if (Rec."Initiate Opening" = Rec."Initiate Opening"::"Initiate Opening") then begin
                    rfq.Reset();
                    rfq.SetRange("No.", rec."No.");
                    if rfq.Find('-') then begin
                        if rfq."Expected Opening Date" > System.CurrentDateTime then Error('Opening date is %1', rfq."Expected Opening Date");
                        if rfq."Expected Closing Date" > System.CurrentDateTime then Error('Cannot Initiate opening before %1', rfq."Expected Closing Date");
                        "Date Opened" := rfq."Expected Opening Date";
                    end;
                    rec."Opening Confirmed" := true;

                    "Date openned" := System.Today;
                    "Opening Time" := System.Time;
                end;

            end;
        }
        field(8; "Opening Confirmed"; Boolean)
        {

        }
        field(9; "Date openned"; date)
        {
            Caption = 'Date Opened';
        }
        field(10; "Opening Time"; time)
        {

        }
        field(11; "Email"; Text[50])
        {

        }
        field(12; Comments; Text[2048])
        {

        }
        field(13; "Member Type"; Option)
        {
            OptionMembers = Staff,"Non Staff";
        }
        field(14; "Date Opened"; dateTime)
        {

        }
    }

    keys
    {
        key(pk; "No.", "Committee Type", "Entry No.")
        {

        }
    }
    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetLastEntryNo() + 1;

    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;
}