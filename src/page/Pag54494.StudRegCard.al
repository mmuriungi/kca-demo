page 54494 "Stud Reg Card"
{
    Caption = 'Stud Reg Card';
    PageType = Card;
    SourceTable = "Stud Reg Form";

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
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Degree Program"; Rec."Degree Program")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Degree Program field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
                field("Acdemic Year"; Rec."Acdemic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acdemic Year field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
            }
            part("Processes"; "Stud Reg Form Line")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No."), Semester = field(Semester);
            }
        }
    }
}
