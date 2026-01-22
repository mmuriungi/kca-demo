page 52070 "Project Milestones"
{
    ApplicationArea = All;
    Caption = 'Project Milestones';
    PageType = List;
    SourceTable = "Project Milestone";
    CardPageID = "Project Milestone Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Task No"; Rec."Task No")
                {
                    ApplicationArea = All;
                    Caption = 'Milestone No.';
                }
                field(Descriprion; Rec.Descriprion)
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Importance; Rec.Importance)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                    ApplicationArea = All;
                }
                field("Task Budget"; Rec."Task Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Milestone Budget';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
        }
    }
}

