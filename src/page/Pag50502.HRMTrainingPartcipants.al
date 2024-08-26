page 50502 "HRM-Training Partcipants"
{
    PageType = List;
    SourceTable = "HRM-Training Participants";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Training Code"; Rec."Training Code")
                {
                    ApplicationArea = all;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Employee name"; Rec."Employee name")
                {
                    ApplicationArea = all;
                }
                field(Objectives; Rec.Objectives)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

