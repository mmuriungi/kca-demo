page 53089 "CAT-Cafe. Meal Journal Line"
{
    PageType = List;
    SourceTable = "CAT-Cafe Meal Journal Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Template; Rec.Template)
                {
                    Editable = false;
                }
                field(Batch; Rec.Batch)
                {
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                }
                field("Meal Code"; Rec."Meal Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Meal Description"; Rec."Meal Description")
                {
                    Editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Posting)
            {
                Caption = 'Journal posting';
                action(post)
                {
                    Caption = 'Post Inventory';
                    Image = PostBatch;
                    Promoted = true;

                    trigger OnAction()
                    var
                        progre: Dialog;
                        counts: Integer;
                        RecCount1: Text[120];
                        RecCount2: Text[120];
                        RecCount3: Text[120];
                        RecCount4: Text[120];
                        RecCount5: Text[120];
                        RecCount6: Text[120];
                        RecCount7: Text[120];
                        RecCount8: Text[120];
                        RecCount9: Text[120];
                        RecCount10: Text[120];
                        BufferString: Text[1024];
                        Var1: Code[10];
                    begin
                        IF CONFIRM('Post meals inventory Journal?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                        mealjournal.RESET;
                        IF mealjournal.FIND('-') THEN BEGIN
                            IF ((mealjournal."Unit Price" = 0) OR (mealjournal.Quantity = 0)) THEN
                                ERROR('The quantity and unit price should not be zero!');
                            CLEAR(RecCount1);
                            CLEAR(RecCount2);
                            CLEAR(RecCount3);
                            CLEAR(RecCount4);
                            CLEAR(RecCount5);
                            CLEAR(RecCount6);
                            CLEAR(RecCount7);
                            CLEAR(RecCount8);
                            CLEAR(RecCount9);
                            CLEAR(RecCount10);
                            CLEAR(counts);
                            progre.OPEN('Posting Please wait..............\#1###############################################################' +
                            '\#2###############################################################' +
                            '\#3###############################################################' +
                            '\#4###############################################################' +
                            '\#5###############################################################' +
                            '\#6###############################################################' +
                            '\#7###############################################################' +
                            '\#8###############################################################' +
                            '\#9###############################################################' +
                            '\#10###############################################################' +
                            '\#11###############################################################' +
                            '\#12###############################################################' +
                            '\#13###############################################################',
                                RecCount1,
                                RecCount2,
                                RecCount3,
                                RecCount4,
                                RecCount5,
                                RecCount6,
                                RecCount7,
                                RecCount8,
                                RecCount9,
                                RecCount10,
                                Var1,
                                Var1,
                                BufferString
                            );

                            REPEAT
                            BEGIN
                                mealjournal.CALCFIELDS(mealjournal."Meal Description");
                                CLEAR(Var1);
                                counts := counts + 1;
                                IF counts = 1 THEN
                                    RecCount1 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                ELSE
                                    IF counts = 2 THEN BEGIN
                                        RecCount2 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                    END
                                    ELSE
                                        IF counts = 3 THEN BEGIN
                                            RecCount3 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                        END
                                        ELSE
                                            IF counts = 4 THEN BEGIN
                                                RecCount4 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                            END
                                            ELSE
                                                IF counts = 5 THEN BEGIN
                                                    RecCount5 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                                END
                                                ELSE
                                                    IF counts = 6 THEN BEGIN
                                                        RecCount6 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                                    END
                                                    ELSE
                                                        IF counts = 7 THEN BEGIN
                                                            RecCount7 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                                        END
                                                        ELSE
                                                            IF counts = 8 THEN BEGIN
                                                                RecCount8 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                                            END
                                                            ELSE
                                                                IF counts = 9 THEN BEGIN
                                                                    RecCount9 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                                                END
                                                                ELSE
                                                                    IF counts = 10 THEN BEGIN
                                                                        RecCount10 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description"

                                                                    END ELSE
                                                                        IF counts > 10 THEN BEGIN
                                                                            RecCount1 := RecCount2;
                                                                            RecCount2 := RecCount3;
                                                                            RecCount3 := RecCount4;
                                                                            RecCount4 := RecCount5;
                                                                            RecCount5 := RecCount6;
                                                                            RecCount6 := RecCount7;
                                                                            RecCount7 := RecCount8;
                                                                            RecCount8 := RecCount9;
                                                                            RecCount9 := RecCount10;
                                                                            RecCount10 := FORMAT(counts) + '). ' + FORMAT(mealjournal."Meal Code") + ': ' + mealjournal."Meal Description";
                                                                        END;
                                CLEAR(BufferString);
                                BufferString := 'Total Records processed = ' + FORMAT(counts);

                                progre.UPDATE();
                                // Check if the Item Exists in the Inventory for the specified date
                                itemInventory.RESET;
                                itemInventory.SETRANGE(itemInventory."Item No", mealjournal."Meal Code");
                                itemInventory.SETRANGE(itemInventory."Cafeteria Section", mealjournal."Cafeteria Section");
                                itemInventory.SETRANGE(itemInventory."Menu Date", mealjournal."Posting Date");
                                IF NOT itemInventory.FIND('-') THEN BEGIN
                                    // Create the Item
                                    itemInventory.INIT;
                                    itemInventory."Item No" := mealjournal."Meal Code";
                                    itemInventory.Category := mealjournal.Category;
                                    itemInventory."Price Per Item" := mealjournal."Unit Price";
                                    itemInventory."Menu Date" := mealjournal."Posting Date";
                                    itemInventory."Cafeteria Section" := mealjournal."Cafeteria Section";
                                    itemInventory.INSERT;
                                END ELSE BEGIN
                                    itemInventory."Price Per Item" := mealjournal."Unit Price";
                                    itemInventory.MODIFY;
                                END;
                                CLEAR(lineNo);
                                MealJournEntrie.RESET;
                                MealJournEntrie.SETRANGE(MealJournEntrie."Posting Date", mealjournal."Posting Date");
                                IF MealJournEntrie.FIND('-') THEN BEGIN
                                    lineNo := MealJournEntrie.COUNT + 10;
                                END ELSE BEGIN
                                    lineNo := 10;
                                END;
                                // Create Ledger Entries for the Cafe Meal Items
                                MealJournEntrie.INIT;
                                MealJournEntrie.Template := mealjournal.Template;
                                MealJournEntrie.Batch := mealjournal.Batch;
                                MealJournEntrie."Meal Code" := mealjournal."Meal Code";
                                MealJournEntrie."Posting Date" := mealjournal."Posting Date";
                                MealJournEntrie."Line No." := lineNo;
                                MealJournEntrie."Cafeteria Section" := mealjournal."Cafeteria Section";
                                MealJournEntrie."Transaction Type" := mealjournal."Transaction Type";
                                IF mealjournal."Transaction Type" = mealjournal."Transaction Type"::"Negative Adjustment" THEN
                                    MealJournEntrie.Quantity := mealjournal.Quantity * (-1)
                                ELSE
                                    IF mealjournal."Transaction Type" = mealjournal."Transaction Type"::"Positive Adjustment" THEN
                                        MealJournEntrie.Quantity := mealjournal.Quantity
                                    ELSE
                                        ERROR('The Transaction type should be either ''POSITIVE'' or ''Negative''');
                                MealJournEntrie."User Id" := mealjournal."User Id";
                                MealJournEntrie."Unit Price" := mealjournal."Unit Price";
                                MealJournEntrie."Line Amount" := mealjournal.Quantity * mealjournal."Unit Price";
                                MealJournEntrie."Meal Description" := mealjournal."Meal Description";
                                MealJournEntrie.INSERT;


                                // Delete the journal for the specified date
                                mealjournal.DELETE;
                            END;
                            UNTIL mealjournal.NEXT = 0;
                            progre.CLOSE;
                        END;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.RESET;
        Rec.SETFILTER(Rec."Posting Date", '=%1', TODAY);
        Rec.SETFILTER(Rec.Template, '=%1', 'Cafe_Inventory');
        Rec.SETFILTER(Rec.Batch, '=%1', 'Adjustment');
        Rec.SETFILTER("User Id", '=%1', USERID);
    end;

    var
        mealjournal: Record "CAT-Cafe Meal Journal Line";
        MealJournEntrie: Record "CAT-Cafe_Meal Ledger Entries";
        itemInventory: Record "CAT-Cafeteria Item Inventory";
        lineNo: Integer;
}

