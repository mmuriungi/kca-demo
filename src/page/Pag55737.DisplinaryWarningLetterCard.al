page 55737 "Displinary Warning Letter Card"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Type" = filter(Minor), "Not Satisfactory" = filter(true), "Case Closed" = filter(false));
    layout
    {
        area(Content)
        {
            group(general)
            {

                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Offence Identified"; Rec."Offence Identified")
                {
                    ToolTip = 'Specifies the value of the Offence Identified field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Offence Description"; Rec."Offence Description")
                {
                    ToolTip = 'Specifies the value of the Offence Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Show Cause Response"; Rec."Show Cause Response")
                {
                    ToolTip = 'Specifies the value of the Show Cause Response field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Not Satisfactory"; Rec."Not Satisfactory")
                {
                    ToolTip = 'Specifies the value of the Not Satisfactory field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Show Cause Letter"; Rec."Show Cause Letter")
                {
                    ToolTip = 'Specifies the value of the Show Cause Letter field.';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(WarningLetter)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Report2;

                trigger OnAction()
                begin

                end;
            }
            action(CloseCase)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Report2;

                trigger OnAction()
                begin
                    Rec."Case Closed" := true;
                end;
            }
        }
    }
}