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
                    Caption = 'Milestone No.';
                }
                field(Descriprion; Rec.Descriprion)
                {
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Importance; Rec.Importance)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Progress Level %"; Rec."Progress Level %")
                {
                }
                field("Task Budget"; Rec."Task Budget")
                {
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

