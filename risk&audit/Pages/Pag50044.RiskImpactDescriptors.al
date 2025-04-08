page 50272 "Risk Impact Descriptors"
{
    PageType = List;
    SourceTable = "Risk Impact Descriptors";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Impact Code"; rec."Impact Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Domain Code"; rec."Domain Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Impact Descriptior"; rec."Impact Descriptior")
                {
                }
            }
        }
    }

    actions
    {
    }
}

