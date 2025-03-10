page 51817 "HMS-Setup Lab Test List"
{
    PageType = List;
    CardPageId = "HMS-Setup Lab Test Card";
    SourceTable = "HMS-Setup Lab Test";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Lab Test Items")
            {
                ApplicationArea=all;
                Promoted=true;
                PromotedCategory=Process;
                Image=Item;
                RunObject=page "Lab Test Items";
                RunPageLink=Code=field(Code);
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

