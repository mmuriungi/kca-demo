page 51959 "Displinary Major DDHR Card"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Case Status" = filter("Fowarded to DDHR"));
    layout
    {
        area(Content)
        {
            Group(general)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
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
                field("Show Cause Letter"; Rec."Show Cause Letter")
                {
                    ToolTip = 'Specifies the value of the Show Cause Letter field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Show Cause Response"; Rec."Show Cause Response")
                {
                    ToolTip = 'Specifies the value of the Show Cause Response field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowCause)
            {
                Caption = 'Show Cause Letter';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
            }
            action(ForwadHRMO)
            {
                Caption = 'Forwad to HRMO';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::"Fowarded to HRMO";
                end;
            }
        }
    }
}