table 52178536 "Proc-Committee Membership"
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
            TableRelation = "Proc-Committee Members"."Member No" where("Ref No" = field("No."));
            trigger OnValidate()
            var
                hrm: Record "HRM-Employee C";
            begin
                hrm.Reset();
                hrm.SetRange("No.", rec."Staff No.");
                if hrm.Find('-') then begin
                    Name := hrm."First Name" + ' ' + hrm."Middle Name" + ' ' + hrm."Last Name";
                    Email := hrm."Company E-Mail";
                    "Telephone No." := hrm."Work Phone Number";
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
                rfq: Record "PROC-Purchase Quote Header";
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
                    rec."Date Opened" := rfq."Expected Opening Date";
                    rec."Opening Confirmed" := true;
                    rec."Opening Done" := rec."Opening Done"::Done;
                    rec."Date openned" := System.Today;
                    rec."Opening Time" := System.Time;
                    rec.Modify();
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
        field(15; Role; Option)
        {
            OptionMembers = " ",Chairperson,Member,Secretary;
        }
        field(16; "Opening Done"; Option)
        {
            OptionMembers = No,Initiated,Done;
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