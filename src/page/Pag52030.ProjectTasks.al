page 52030 "Project Tasks"
{
    Caption = 'Contract Milestones';
    CardPageID = "Project Tasks Card";
    PageType = List;
    SourceTable = "Project Tasks";

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

