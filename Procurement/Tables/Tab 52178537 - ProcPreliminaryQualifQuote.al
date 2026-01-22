table 52178537 "Proc-Preliminary Qualif.Quote"
{
    DrillDownPageId = "Proc-Preliminary Qualif.Quote";
    LookupPageId = "Proc-Preliminary Qualif.quote";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            // AutoIncrement = true;
        }
        field(2; "No."; Code[30])
        {

        }
        field(3; "Description"; Text[500])
        {

        }

        field(4; "Scored"; Option)
        {
            Caption = 'Score';
            OptionMembers = " ","Requirement Met","Requirement Not Met";
            trigger OnValidate()
            var
                pheader: Record "Purchase Header";
            begin
                pheader.Reset();
                pheader.SetRange("No.", Rec."Quote No.");
                if pheader.Find('-') then begin

                end;
                /* if Scored = Scored::" " then begin
                    "Requirement Met" := 0;
                    "Requirement Not Met" := 0;
                end else
                    if Scored = Scored::"Requirement Met" then
                        "Requirement Met" := 1
                    else
                        if Scored = Scored::"Requirement Not Met" then "Requirement Not Met" := 50; */
                Rec.Evaluated := true;
                rec."date Evaluated" := System.CurrentDateTime;
            end;
        }
        field(5; "Quote No."; Code[30])
        {



        }
        field(6; "Staff No"; code[30])
        {

        }
        field(7; "Staff Name"; Text[100])
        {

        }
        field(8; "Evaluated"; Boolean)
        {

        }
        field(9; "date Evaluated"; DateTime)
        {

        }
        field(10; Reason; Text[2048])
        {

        }
        field(11; Mandatory; Boolean)
        {

        }
        field(12; Evaluators; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Proc-Committee Membership" where("Committee Type" = filter("Evaluation Committee"), "No." = field("No.")));
        }
        field(13; "Requirement Met"; Integer)
        {


        }
        field(14; "Requirement Not Met"; Integer)
        {


        }
        field(15; "Quote Status"; Option)
        {
            OptionMembers = Pending,Submitted,Preliminary,Technical,Demonstration,Financials,Failed;
        }

    }


    keys
    {
        key(pk; "Entry No.", "No.", "Quote No.", "Staff No")
        {

        }
    }
}