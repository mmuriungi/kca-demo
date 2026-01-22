page 52038 "Project Task Components"
{
    Caption = 'Contract Milestone Components';
    ApplicationArea = All;
    PageType = List;

    SourceTable = "Project Task Components";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Component; Rec.Component)
                {
                }
                field("Component Budget"; Rec."Component Budget")
                {
                }
                field("Progress Level"; Rec."Progress Level")
                {
                }
            }
        }
    }

    actions
    {
    }
}

