page 51242 "CAT-Menu Sales Line"
{
    PageType = ListPart;
    SourceTable = "CAT-Menu Sales Line";

    layout
    {
        area(content)
        {
            repeater(ewtw)
            {
                field(Menu; Rec.Menu)
                {
                    LookupPageID = "CAT-Daily menu List";

                    trigger OnValidate()
                    begin

                        DailyMenu.RESET;
                        DailyMenu.SETRANGE(DailyMenu.Menu, Rec.Menu);
                        //  DailyMenu.SETRANGE(DailyMenu."Menu Date",TODAY);
                        //DailyMenu.SETRANGE(DailyMenu.Type,DailyMenu.Type::Student);
                        IF DailyMenu.FIND('-') THEN BEGIN
                            IF DailyMenu."Remaining Qty" < 1 THEN BEGIN
                                // ERROR('The Selected Menu Item is Out Of Stock')
                            END
                            ELSE BEGIN
                                Rec."Unit Cost" := DailyMenu."Unit Cost";
                                Rec.Quantity := 1;
                                Rec.Amount := DailyMenu."Unit Cost";
                                Rec.Description := DailyMenu.Description;
                            END;
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {

                    trigger OnValidate()
                    begin
                        Rec.Amount := Rec.Quantity * Rec."Unit Cost";
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        DailyMenu: Record "CAT-Daily Menu";
}

