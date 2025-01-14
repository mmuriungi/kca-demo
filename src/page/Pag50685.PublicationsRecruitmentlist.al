page 50685 "Publications Recruitment list"
{
    Caption = 'Publications Recruitment list';
    PageType = List;
    SourceTable = "Publications Recruitment";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Publication Code"; Rec."Publication Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Publication Code field.', Comment = '%';
                }
                field("Publication Category"; Rec."Publication Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Publication Category field.', Comment = '%';
                }
                field("Number of Books"; Rec."Number of Books")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Books field.', Comment = '%';
                }
                field("Number of Chapters"; Rec."Number of Chapters")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Chapters field.', Comment = '%';
                }
                field("Publication Title"; Rec."Publication Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Publication Title field.', Comment = '%';
                }
            }
        }
    }
}
