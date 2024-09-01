page 50945 "ACA-Exam Irregularities Card"
{
    PageType = Card;
    SourceTable = "ACA-Irregularities Register";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Irregularity Type"; Rec."Irregularity Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date/Time"; Rec."Transaction Date/Time")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Captured By"; Rec."Captured By")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Essay; Rec.Essay)
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

