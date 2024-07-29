page 53074 "CAT-Menu Sales Line Staff"
{
    PageType = List;
    SourceTable = "CAT-Menu Sales Line";

    layout
    {
        area(content)
        {
            repeater(wqr)
            {
                field(Menu; Rec.Menu)
                {
                    LookupPageID = "CAT-Daily menu List";

                    trigger OnValidate()
                    begin
                        DailyMenu.SETRANGE(DailyMenu.Menu, Rec.Menu);
                        DailyMenu.SETRANGE(DailyMenu."Menu Date", TODAY);
                        IF DailyMenu.FIND('-') THEN BEGIN
                            Rec."Unit Cost" := DailyMenu."Unit Cost"
                        END;
                    end;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Amount; Rec.Amount)
                {
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

