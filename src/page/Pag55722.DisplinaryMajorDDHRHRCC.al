page 55722 "Displinary Major DDHR_HRC_C"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Case Status" = filter(DDHR_HRC));

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
                    ToolTip = 'Specifies the value of the 1st Committee Identified field.';
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
            action(Recommendations)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Reconcile;
                RunObject = Page "Displinary Committess REC";
                RunPageLink = "Case No." = field("No."), Committe = field("1st Committee Identified");
            }

            action(CommitteeMembers)
            {
                Caption = 'Committe Members';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Displinary Commitee Members";
                RunPageLink = "Case No." = field("No."), "Committee Type" = field("2nd Committee Identified");
            }
            action(FowardDDRB)
            {
                Caption = 'DDHR Board Tabling';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::DDHR_Board_T;
                    Rec."Full Board" := true;
                end;
            }
        }


    }
}