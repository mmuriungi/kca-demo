page 51945 "Displinary Commitee Members"
{
    PageType = List;
    SourceTable = "Displinary Commitee Members";
    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Case No."; Rec."Case No.")
                {
                    ToolTip = 'Specifies the value of the Case No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Committee Type"; Rec."Committee Type")
                {
                    ToolTip = 'Specifies the value of the Committee Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    ApplicationArea = All;
                }
                field(Attended; Rec.Attended)
                {
                    ToolTip = 'Specifies the value of the Attended field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}