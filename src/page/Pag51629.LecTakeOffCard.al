page 51629 "Lec Take Off Card"
{
    Caption = 'Lecturer Take Card';
    PageType = Card;
    SourceTable = "Lec Take Off";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
            part("Take off Details"; "Lec Take Off Details")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No."), Semester = field(Semester), "Date Submitted" = field("Date Created");
            }
        }
    }
}
