page 51251 "CAT-Left Over Dialog"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field("Menu Date"; "Menu Date")
            {
                Caption = 'Menu Date';
            }
            field(Lost; 'Lost Fields')
            {
                CaptionClass = Text19053507;
                Style = Standard;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Cancel)
            {
                Caption = 'Cancel';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
            action(Ok)
            {
                Caption = 'Ok';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DailyMenu.RESET;
                    DailyMenu.SETRANGE(DailyMenu."Menu Date", "Menu Date");
                    IF DailyMenu.FIND('-') THEN BEGIN
                        REPEAT
                            IF DailyMenu."Remaining Qty" > 0 THEN BEGIN
                                TodayMenu.SETRANGE(TodayMenu."Menu Date", TODAY);
                                IF TodayMenu.FIND('-') THEN BEGIN
                                    REPEAT
                                        IF TodayMenu.Menu = DailyMenu.Menu THEN BEGIN
                                            TodayMenu."Remaining Qty" := TodayMenu."Remaining Qty" + DailyMenu."Remaining Qty";
                                            TodayMenu.MODIFY;
                                        END;
                                    UNTIL TodayMenu.NEXT = 0;
                                END;
                                IF TodayMenu.FIND('-') THEN BEGIN
                                    REPEAT
                                        TodayMenu.RESET;
                                        TodayMenu.SETRANGE(TodayMenu.Menu, DailyMenu.Menu);
                                        IF TodayMenu.FIND('-') THEN BEGIN
                                        END
                                        ELSE BEGIN
                                            TodayMenu.INIT;
                                            TodayMenu.Menu := DailyMenu.Menu;
                                            TodayMenu."Menu Date" := TODAY;
                                            TodayMenu.Description := DailyMenu.Description;
                                            TodayMenu.Units := DailyMenu.Units;
                                            TodayMenu."Menu Qty" := DailyMenu."Menu Qty";
                                            TodayMenu."Prod Qty" := DailyMenu."Remaining Qty";
                                            TodayMenu."Remaining Qty" := DailyMenu."Remaining Qty";
                                            TodayMenu.Posted := FALSE;
                                            TodayMenu.INIT;
                                        END;
                                    UNTIL TodayMenu.NEXT = 0;
                                END;
                            END;
                        UNTIL DailyMenu.NEXT = 0;
                    END;
                    MESSAGE('Menu Updated Sussfully');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        "Menu Date" := TODAY;
        "Menu Date" := "Menu Date" - 1;
    end;

    var
        "Menu Date": Date;
        "Food Menu": Record "CAT-Food Menu";
        DailyMenu: Record "CAT-Daily Menu";
        TodayMenu: Record "CAT-Daily Menu";
        Text19053507: Label 'Enter The Left Over Date';
}

