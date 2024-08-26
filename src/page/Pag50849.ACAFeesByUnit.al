page 50849 "ACA-Fees By Unit"
{
    PageType = CardPart;
    SourceTable = "ACA-Fee By Unit";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Student Type"; Rec."Student Type")
                {
                    ApplicationArea = All;
                }
                field("Settlemet Type"; Rec."Settlemet Type")
                {
                    ApplicationArea = All;
                }
                field("Seq."; Rec."Seq.")
                {
                    ApplicationArea = All;
                }
                field("Break Down"; Rec."Break Down")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

