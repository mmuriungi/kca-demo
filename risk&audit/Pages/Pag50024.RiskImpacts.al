page 50024 "Risk Impacts"
{
    PageType = List;
    SourceTable = "Risk Impacts";
    SourceTableView = SORTING("Impact Score") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Impact Score"; "Impact Score")
                {
                }
                field("Financial start"; "Financial start")
                {

                }
                field("Financial End"; "Financial End")
                {

                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Domains)
            {
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Risk Impact Domains";
                RunPageLink = "Impact Code" = FIELD(Code);
            }
        }
    }
}

