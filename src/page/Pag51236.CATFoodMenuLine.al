page 51236 "CAT-Food Menu Line"
{
    Editable = true;
    PageType = CardPart;
    SourceTable = "CAT-Food Menu Line";

    layout
    {
        area(content)
        {
            repeater(eqwr)
            {
                field("Item No"; Rec."Item No")
                {

                    trigger OnValidate()
                    begin
                        Item.SETRANGE(Item."No.", Rec."Item No");
                        IF Item.FIND('-') THEN BEGIN
                            Rec.Description := Item.Description;
                            Rec.Units := Item."Base Unit of Measure";
                            Rec."Unit Cost" := Item."Last Direct Cost";
                            Rec.Location := 'kitchen';
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(Quantity; Rec.Quantity)
                {

                    trigger OnValidate()
                    begin
                        Rec."Total Cost" := Rec."Unit Cost" * Rec.Quantity;
                    end;
                }
                field(Units; Rec.Units)
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {

                    trigger OnValidate()
                    begin
                        Rec."Total Cost" := Rec."Unit Cost" * Rec.Quantity;
                    end;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                }
                field(Menu; Rec.Menu)
                {
                }
                field(Type; Rec.Type)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Item: Record "Item";
}

