/// <summary>
/// Page ELECT-Electral Districts List (ID 60004).
/// </summary>
page 51317 "ELECT-Electral Districts List"
{
    PageType = List;
    SourceTable = "ELECT-Electoral Districts";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Electral District Doce"; Rec."Electral District Doce")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No. of Registered Voters"; Rec."No. of Registered Voters")
                {
                    ApplicationArea = All;
                }
                field("No. of Votes Cast"; Rec."No. of Votes Cast")
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
            action("Polling Centers")
            {
                Caption = 'Polling Centers';
                Image = DistributionGroup;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "ELECT-Polling Centers List";
                RunPageLink = "Election Code" = FIELD("Election Code"),
                              "Electral District" = FIELD("Electral District Doce");
                ApplicationArea = All;
            }
        }
    }
}

