page 51942 "Displinary Cases Card"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Type" = filter(Minor));
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
                    Editable = false;
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

                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(showCause)
            {
                Caption = 'Show Cause';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::"Show Cause";
                    Rec."Show Cause Letter" := true;
                end;
            }
        }
    }
}