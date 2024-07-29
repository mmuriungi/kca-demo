page 52111 "Exam Ver Card"
{
    Caption = 'Exam Ver Card';
    PageType = Card;
    SourceTable = "Buffer Exam Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Verified By"; Rec."Verified By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Verified"; Rec."Date Verified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part("Exam Lines"; "ACA-Exam Results Buffer 2")
            {
                ApplicationArea = All;
                SubPageLink = Semester = field(Semester), Programme = field(Programme);
            }
        }
    }
}
