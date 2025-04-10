page 50267 "Risk Impact Domains"
{
    PageType = List;
    SourceTable = "Risk Domain";

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
                }
                field(Description; rec.Description)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Domain Descriptors")
            {
                Image = Entries;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "Risk Impact Descriptors";
                RunPageLink = "Impact Code" = FIELD("Impact Code"), "Domain Code" = FIELD("Domain Code");
            }
        }
    }
}

