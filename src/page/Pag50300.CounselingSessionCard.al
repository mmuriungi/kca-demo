page 50300 "Counseling Session Card"
{
    PageType = Card;
    SourceTable = "Counseling Session";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Session No."; Rec."Session No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Counselor No."; Rec."Counselor No.")
                {
                    ApplicationArea = All;
                }
                field("Counsellor Name"; Rec."Counsellor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Session Date"; Rec."Session Date")
                {
                    ApplicationArea = All;
                }
                field("Issue Description"; Rec."Issue Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Recommendations; Rec.Recommendations)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Follow-up Required"; Rec."Follow-up Required")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}