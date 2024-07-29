page 55735 "Displinary Show Cause Card"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Type" = filter(Minor), "Show Cause Letter" = filter(true));

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
                    MultiLine = true;
                }
                field("Show Cause Letter"; Rec."Show Cause Letter")
                {
                    ToolTip = 'Specifies the value of the Show Cause Letter field.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Date Reported"; Rec."Date Reported")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Show Cause Response"; Rec."Show Cause Response")
                {
                    ToolTip = 'Specifies the value of the Show Cause Response field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowCauseR)
            {
                ApplicationArea = All;
                Caption = 'Show Cause Letter';
                Promoted = true;
                PromotedCategory = Process;
                Image = Report;
                trigger OnAction()
                begin
                end;
            }
            action(ResponseN)
            {
                ApplicationArea = All;
                Caption = 'Response Not Satisfactory';
                Promoted = true;
                PromotedCategory = Process;
                Image = Report;
                trigger OnAction()
                begin
                    Rec."Not Satisfactory" := true;
                end;
            }
        }
    }
}