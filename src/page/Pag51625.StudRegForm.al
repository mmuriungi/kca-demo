page 51625 "Stud Reg Form"
{
    Caption = 'Stud Reg Form';
    PageType = List;
    CardPageId = "Stud Reg Card";
    SourceTable = "Stud Reg Form";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Degree Program"; Rec."Degree Program")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Degree Program field.', Comment = '%';
                }
                field("Acdemic Year"; Rec."Acdemic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acdemic Year field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.', Comment = '%';
                }
            }
        }
    }
}
