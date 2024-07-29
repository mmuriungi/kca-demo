page 55708 "Displinary Major BoardSus"
{
    PageType = List;
    SourceTable = "Displinary Cases";
    CardPageId = "Displinary Major BoardSusC";
    SourceTableView = where("Case Status" = filter(Suspension));

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
                    Editable = false;
                }
                field("1st Committee Identified"; Rec."1st Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 1st Committee Identified field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("2nd Committee Identified"; Rec."2nd Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 2nd Committee Identified field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("3rd Committee Identified"; Rec."3rd Committee Identified")
                {
                    ToolTip = 'Specifies the value of the 3rd Committee Identified field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Summary Defense1"; Rec."Summary Defense1")
                {
                    ToolTip = 'Specifies the value of the Summary Defense1 field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Summary Defense2"; Rec."Summary Defense2")
                {
                    ToolTip = 'Specifies the value of the Summary Defense2 field.';
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
            action(Recommendations)
            {
                Caption = 'JSAC Recommendations';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Reconcile;
                RunObject = Page "Displinary Committess REC";
                RunPageLink = "Case No." = field("No."), Committe = field("1st Committee Identified");
            }

            action(CommitteeMembers)
            {
                Caption = 'JSAC Committe Members';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Displinary Commitee Members";
                RunPageLink = "Case No." = field("No."), "Committee Type" = field("2nd Committee Identified");
            }

            action(Recommendations2)
            {
                Caption = 'HRC Recommendations';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Reconcile;
                RunObject = Page "Displinary Committess REC";
                RunPageLink = "Case No." = field("No."), Committe = field("2nd Committee Identified");
            }

            action(CommitteeMembers2)
            {
                Caption = 'HRC Committee Members';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Displinary Commitee Members";
                RunPageLink = "Case No." = field("No."), "Committee Type" = field("2nd Committee Identified");
            }

            action(Investigation)
            {
                Caption = 'Initiate Investigation';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::Investigation;
                    Rec.Investigation := true;
                end;
            }
        }


    }
}