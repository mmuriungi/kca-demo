table 52178539 "Proc-Demo Qualif.Quote"
{
    DrillDownPageId = "Proc-Demo Qualif.Quote";
    LookupPageId = "Proc-Demo Qualif.Quote";
    fields
    {
        field(1; "Entry No."; Integer)
        {

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
            Caption = 'Score';
            trigger OnValidate()
            var
                pheader: Record "Purchase Header";
                tHeader: Record "Tender Submission Header";
            begin
                /* pheader.Reset();
                pheader.SetRange("No.", Rec."Quote No.");
                if pheader.Find('-') then begin
                    if pheader."Quote Status" <> pheader."Quote Status"::"Tech Qualf" then
                        Error('You have not done Technical Evaluation');
                end;
                tHeader.Reset();
                tHeader.SetRange("No.", Rec."Quote No.");
                if tHeader.Find('-') then begin
                    if tHeader."Bid Status" <> tHeader."Bid Status"::"Tech Qualf" then
                        Error('You have not done Technical Evaluation');
                end; */
                if Scored > Rec."Maximum Score" then Error('Cannot score Beyond maximum');
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
            CalcFormula = sum("Proc-Demo Qualif.Quote"."Maximum Score" where("Quote No." = field("Quote No.")));
            Editable = false;
            BlankZero = false;
            DecimalPlaces = 1;
        }
        field(14; "Tech Evaluation Min.Qual"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Demo Qualif.Quote"."Satisfactory Score" where("Quote No." = field("Quote No.")));
            Editable = false;
            BlankZero = false;
            DecimalPlaces = 1;
        }
        field(15; "Tech Evaluation Scored"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Proc-Demo Qualif.Quote".Scored where("Quote No." = field("Quote No.")));
            Editable = false;
            BlankZero = false;
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
        key(pk; "Entry No.", "No.", "Staff No", "Quote No.")
        {

        }
    }
}