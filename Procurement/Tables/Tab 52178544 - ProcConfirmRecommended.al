table 52178544 "Proc-Confirm Recommended"
{

    fields
    {
        field(1; "No."; Code[30])
        {

        }
        field(2; "Staff No."; code[30])
        {
            TableRelation = "HRM-Employee C"."No." where(Status = filter(Active));
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
        field(3; "Bidder No"; code[50])
        {

        }
        field(4; "Name"; Text[100])
        {
            Editable = false;

        }

        field(11; "Email"; Text[50])
        {

        }
        field(5; "Telephone No."; Text[20])
        {

        }

        field(6; "Recommendation"; Option)
        {
            OptionMembers = "","Confirm Recommendation";
            trigger OnValidate()
            var
                rfq: Record "PROC-Purchase Quote Header";
            begin
                if Confirm('Recommend the suggested bid/ Quote ? ', true) = false then Error('Cancelled');
                if "Recommendation" = "Recommendation"::"Confirm Recommendation" then begin
                    "Confirmed" := true;
                    "Date" := System.Today;
                    "Time Confirmed" := System.Time;
                    Modify();
                end;


            end;
        }
        field(7; "Confirmed"; Boolean)
        {


        }
        field(8; "Date"; date)
        {

        }
        field(9; "Time Confirmed"; time)
        {

        }
        field(10; "View"; Code[30])
        {
            /* FieldClass = FlowField;
            CalcFormula = lookup("Proc Evaluation Report"."No." where("No." = field("No.")));
            Editable = false; */
        }


    }

    keys
    {
        key(pk; "No.", "Staff No.", "Bidder No")
        {

        }
    }
}