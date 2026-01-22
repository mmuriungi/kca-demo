page 51944 "Displinary Closed Minor"
{
    PageType = List;
    Editable = false;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Type" = filter(Minor), "Case Closed" = filter(true));

    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
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
                field("End"; Rec."End")
                {
                    ToolTip = 'Specifies the value of the End field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}