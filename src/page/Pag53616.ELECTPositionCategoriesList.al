page 53616 "ELECT-Position Categories List"
{
    PageType = List;
    SourceTable = "ELECT-Position Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                }
                field(Order; Rec.Order)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Elective Positions")
            {
                Caption = 'Elective Positions';
                Image = Aging;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ELECT-Positions List";
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Position Category" = FIELD("Category Code");
                ApplicationArea = All;
            }
        }
    }

    var
}

