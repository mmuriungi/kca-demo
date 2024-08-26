page 51031 "Exam Buffer Ver"
{
    Caption = 'Exam Buffer Ver';
    PageType = List;
    CardPageId = "Exam Ver Card";
    SourceTable = "Buffer Exam Header";
    
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
                field(Programme; Rec.Programme)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Verified By field.', Comment = '%';
                }
                field("Date Verified"; Rec."Date Verified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Verified field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
