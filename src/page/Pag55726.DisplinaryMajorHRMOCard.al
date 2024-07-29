page 55726 "Displinary Major HRMO Card"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Case Status" = filter("Fowarded to HRMO"));

    layout
    {
        area(Content)
        {
            group(general)
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
                    MultiLine = true;
                    Editable = false;
                }

                field("1st Committee Identified"; Rec."1st Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 1st Committee Identified field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CommitteeMembers)
            {
                Caption = 'Committe Members';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Displinary Commitee Members";
                RunPageLink = "Case No." = field("No."), "Committee Type" = field("1st Committee Identified");
            }
            action(ShowCause)
            {
                Caption = 'Show Cause Letter';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
            }
            action(sendtoDDHR)
            {
                Caption = 'Send to DDHR for Tabling';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::"Fowarded to DDHR_T";
                end;
            }
        }
    }
}