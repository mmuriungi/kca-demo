// Page: Headline RC Sports Equipment
page 52018 "Headline RC Sports Equipment"
{
    PageType = HeadlinePart;

    layout
    {
        area(content)
        {
            field(Headline1; HeadlineText1)
            {
                ApplicationArea = All;
            }
            field(Headline2; HeadlineText2)
            {
                ApplicationArea = All;
            }
        }
    }

    var
        HeadlineText1: Text;
        HeadlineText2: Text;

    trigger OnOpenPage()
    begin
        HeadlineText1 := GetHeadline1();
        HeadlineText2 := GetHeadline2();
    end;

    local procedure GetHeadline1(): Text
    var
        EquipmentIssuance: Record "Equipment Issuance";
    begin
        EquipmentIssuance.SetRange(Status, EquipmentIssuance.Status::Issued);
        if EquipmentIssuance.Count = 1 then
            exit('1 piece of equipment is currently issued.')
        else
            exit(Format(EquipmentIssuance.Count) + ' pieces of equipment are currently issued.');
    end;

    local procedure GetHeadline2(): Text
    var
        Item: Record Item;
    begin
        Item.SetRange("Item Category", Item."Item Category"::"Sporting Equipment");
        Item.SetFilter(Inventory, '<=%1', 0);
        if Item.Count = 1 then
            exit('1 sports equipment item is out of stock.')
        else
            exit(Format(Item.Count) + ' sports equipment items are out of stock.');
    end;
}
