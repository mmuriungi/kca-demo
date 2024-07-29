page 53099 "CAT-Unprinted Cafeteria Recpts"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "CAT-Cafeteria Receipts";
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Recept Total"; Rec."Recept Total")
                {
                    Editable = false;
                }
                field("Cancel Reason"; Rec."Cancel Reason")
                {
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field(User; Rec.User)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Activity/Functions")
            {
                Caption = 'Activity/Functions';
                action(Mark_as_Printed)
                {
                    Caption = 'Mark as Printed';

                    trigger OnAction()
                    begin

                        Receipts.RESET;
                        Receipts.SETRANGE(Receipts.Status, Receipts.Status::New);
                        Receipts.SETRANGE(Receipts.Select, TRUE);

                        IF NOT Receipts.FIND('-') THEN
                            ERROR('No lines Selected!');

                        IF CONFIRM('Mark as Printed?', TRUE) = TRUE THEN BEGIN
                            IF Receipts.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    Receipts.Status := Receipts.Status::Printed;
                                    Receipts.Select := FALSE;
                                    Receipts.MODIFY;
                                END;
                                UNTIL Receipts.NEXT = 0;
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                action(Cancel_Selected)
                {
                    Caption = 'Cancel Selected';

                    trigger OnAction()
                    begin

                        Receipts.RESET;
                        Receipts.SETRANGE(Receipts.Status, Receipts.Status::New);
                        Receipts.SETRANGE(Receipts.Select, TRUE);

                        IF NOT Receipts.FIND('-') THEN
                            ERROR('No lines Selected!');

                        IF CONFIRM('Cancel Selected?', TRUE) = TRUE THEN BEGIN
                            IF Receipts.FIND('-') THEN BEGIN
                                REPEAT
                                BEGIN
                                    IF Receipts."Cancel Reason" = '' THEN ERROR('Provide the Cancel Reason for all Cancelled Receipts.');
                                    Receipts.Status := Receipts.Status::Canceled;
                                    Receipts.Select := FALSE;
                                    Receipts.MODIFY;
                                    receiptLines.RESET;
                                    receiptLines.SETRANGE(receiptLines."Receipt No.", Receipts."Receipt No.");
                                    IF receiptLines.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            mealJournEntries.RESET;
                                            mealJournEntries.SETRANGE(mealJournEntries."Meal Code", receiptLines."Meal Code");
                                            mealJournEntries.SETRANGE(mealJournEntries."Receipt No.", Receipts."Receipt No.");
                                            IF mealJournEntries.FIND('-') THEN BEGIN
                                                mealJournEntries.DELETE;
                                            END;
                                            //  mealJournEntries.Template:='CAFE_INVENTORY';
                                            //  mealJournEntries.Batch:='ADJUSTMENT';
                                            //  mealJournEntries."Meal Code":=receiptLines."Meal Code";
                                            //  mealJournEntries."Posting Date":=receiptLines.Date;
                                            //  mealJournEntries."Line No.":=receiptLines."Line No.";
                                            //  mealJournEntries."Cafeteria Section":=receiptLines."Cafeteria Section";
                                            //  mealJournEntries."Transaction Type":=mealJournEntries."Transaction Type"::"Positive Adjustment";
                                            //  mealJournEntries.Quantity:=receiptLines.Quantity;
                                            //  mealJournEntries."User Id":=receiptLines.User;
                                            //  mealJournEntries."Unit Price":=receiptLines."Unit Price";
                                            //  mealJournEntries."Line Amount":=receiptLines."Total Amount";
                                            //  mealJournEntries."Meal Description":=receiptLines."Meal Descption";
                                            //  mealJournEntries.Source:=mealJournEntries.Source::Cancellation;
                                            //mealJournEntries.INSERT;
                                        END;
                                        UNTIL receiptLines.NEXT = 0;
                                    END;

                                END;
                                UNTIL Receipts.NEXT = 0;
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
    }

    var
        Receipts: Record "CAT-Cafeteria Receipts";
        mealJournEntries: Record "CAT-Cafe_Meal Ledger Entries";
        receiptLines: Record "CAT-Cafeteria Receipts Line";
}

