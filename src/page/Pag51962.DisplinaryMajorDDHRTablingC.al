page 51962 "Displinary Major DDHR TablingC"
{
    PageType = Card;
    SourceTable = "Displinary Cases";
    SourceTableView = where("Case Status" = filter("Fowarded to DDHR_T"));

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
            action(Recommendations)
            {
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                Image = Reconcile;
                RunObject = Page "Displinary Committess REC";
                RunPageLink = "Case No." = field("No."), Committe = field("1st Committee Identified");
            }
            action(FowatoHRMO)
            {
                Caption = 'HRMO/SHRMO Implementation';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Process;

                trigger OnAction()
                begin
                    Rec."Case Status" := Rec."Case Status"::HRMOImplement;
                end;
            }
        }


    }
}