table 52178538 "Proc-Technical Qualif.Quote"
{
    DrillDownPageId = "Proc-Technical Qualif.Quote";
    LookupPageId = "Proc-Technical Qualif.Quote";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "No."; Code[30])
        {

        }
        field(3; "Description"; Text[500])
        {
        }
        field(4; "Can Exempt"; Boolean)
        {
        }
        field(5; "Maximum Score"; Decimal)
        {

        }
        field(6; "Satisfactory Score"; Decimal)
        {

        }

        field(7; "Staff No"; code[30])
        {

        }
        field(8; "Staff Name"; Text[100])
        {

        }
        field(9; "Quote No."; Code[30])
        {

        }
        field(10; "Scored"; Decimal)
        {
            trigger OnValidate()
            var
                pheader: Record "Purchase Header";
                tHeader: Record "Tender Submission Header";
            begin
                /* pheader.Reset();
                pheader.SetRange("No.", Rec."Quote No.");
                if pheader.Find('-') then begin
                    if pheader."Quote Status" <> pheader."Quote Status"::"Prelim Qualif" then
                        Error('You have not done preliminary Evaluation');
                end;
                tHeader.Reset();
                tHeader.SetRange("No.", Rec."Quote No.");
                if tHeader.Find('-') then begin
                    if tHeader."Bid Status" <> tHeader."Bid Status"::"Prelim Qualif" then
                        Error('You have not done preliminary Evaluation');
                end; */

                if Scored > "Maximum Score" then Error('Score must not exceed Maximum Score');
                Evaluated := true;
            end;

        }
        field(11; "Evaluated"; Boolean)
        {

        }
        field(12; "Evaluation Commitee Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Proc-Committee Membership" where("No." = field("No."), "Committee Type" = filter("Evaluation Committee")));
            Editable = false;
        }
        field(13; "Tech Evaluation Max"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Technical Qualif.Quote"."Maximum Score" where("Quote No." = field("Quote No."), "Entry No." = field("Entry No.")));
            Editable = false;
            DecimalPlaces = 1;
        }
        field(14; "Tech Evaluation Min.Qual"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Technical Qualif.Quote"."Satisfactory Score" where("Quote No." = field("Quote No."), "Entry No." = field("Entry No.")));
            Editable = false;
            DecimalPlaces = 1;
        }
        field(15; "Tech Evaluation Scored"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Technical Qualif.Quote".Scored where("Quote No." = field("Quote No.")));
            Editable = false;
            DecimalPlaces = 1;
        }
        field(16; "Average Score"; Decimal)
        {
            BlankZero = false;
            DecimalPlaces = 1;
        }
        field(17; "Quote Status"; Option)
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