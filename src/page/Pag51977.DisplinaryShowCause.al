page 51977 "Displinary Show Cause"
{
    PageType = List;
    SourceTable = "Displinary Cases";
    CardPageId = "Displinary Show Cause Card";
    SourceTableView = where("Type" = filter(Minor),
    "Show Cause Letter" = filter(true), "Not Satisfactory" = filter(false));

    layout
    {
        area(Content)
        {
            repeater(general)
            {

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
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("Offence Identified"; Rec."Offence Identified")
                {
                    ToolTip = 'Specifies the value of the Offence Identified field.';
                    ApplicationArea = All;
                }
                field("Offence Description"; Rec."Offence Description")
                {
                    ToolTip = 'Specifies the value of the Offence Description field.';
                    ApplicationArea = All;
                }
                field("Show Cause Letter"; Rec."Show Cause Letter")
                {
                    ToolTip = 'Specifies the value of the Show Cause Letter field.';
                    ApplicationArea = All;
                }
                field("Show Cause Response"; Rec."Show Cause Response")
                {
                    ToolTip = 'Specifies the value of the Show Cause Response field.';
                    ApplicationArea = All;
                }
                field(Satisfactory; Rec.Satisfactory)
                {
                    ToolTip = 'Specifies the value of the Satisfactory field.';
                    ApplicationArea = All;
                }
                field("Not Satisfactory"; Rec."Not Satisfactory")
                {
                    ToolTip = 'Specifies the value of the Not Satisfactory field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}