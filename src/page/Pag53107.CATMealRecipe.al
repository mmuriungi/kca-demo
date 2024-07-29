page 53107 "CAT-Meal Recipe"
{
    PageType = List;
    SourceTable = "Meals Recipe";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Meal Description"; Rec."Meal Description")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("Resource Type"; Rec."Resource Type")
                {
                }
                field(Resource; Rec.Resource)
                {
                }
                field("Resource Name"; Rec."Resource Name")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Markup %"; Rec."Markup %")
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                }
                field("Final Cost"; Rec."Final Cost")
                {
                    Editable = false;
                }
                field("Final Price"; Rec."Final Price")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

