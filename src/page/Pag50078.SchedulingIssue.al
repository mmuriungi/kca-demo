page 50078 "Scheduling Issue"
{
    ApplicationArea = All;
    Caption = 'Scheduling Issue';
    PageType = List;
    SourceTable = "Scheduling Issue";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Specifies the value of the Course Code field.', Comment = '%';
                }
                field("Issue Description"; Rec."Issue Description")
                {
                    ToolTip = 'Specifies the value of the Issue Description field.', Comment = '%';
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ToolTip = 'Specifies the value of the Lecturer Code field.', Comment = '%';
                }
                field(Programme; Rec.Programme)
                {
                    ToolTip = 'Specifies the value of the Programme field.', Comment = '%';
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.', Comment = '%';
                }
            }
        }
    }
}
