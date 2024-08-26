page 51294 "Meal-Proc. Central Setup"
{
    PageType = List;
    SourceTable = "Meal-Proc. Central Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Processing Batch Serial"; Rec."Processing Batch Serial")
                {
                }
            }
        }
    }

    actions
    {
    }
}

