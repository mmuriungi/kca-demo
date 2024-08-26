page 51263 "CAT-Cafe. Recpts Card"
{
    PageType = Document;
    RefreshOnActivate = false;
    SourceTable = "CAT-Cafeteria Receipts";
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            group(Receipts)
            {
                Caption = 'Please press enter for the system to generate a new receipt no.';
            }
            group(General)
            {
                Caption = 'Receipt Header';
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = true;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    Editable = false;
                }
                field("Cafeteria Section"; Rec."Cafeteria Section")
                {
                    Editable = false;
                }
            }
            group(Details1)
            {
                Caption = 'Receipt Details';
                part(Details; "CAT-Cafe. Recpts Line")
                {
                    Caption = 'Meal Items';
                    SubPageLink = "Receipt No." = FIELD("Receipt No.");
                }
            }
            group(Amounts)
            {
                Caption = 'Value of Receipts';
                field("Recept Total"; Rec."Recept Total")
                {
                    Caption = 'Recept Total';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    AutoFormatType = 12;
                    Caption = 'Amount Paid';
                    Importance = Additional;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post_Print)
            {
                Caption = 'Post & Print';
                Image = Post;
                Promoted = true;
                ShortCutKey = 'F12';

                trigger OnAction()
                begin

                    IF Rec.Sections = '' THEN ERROR('Select the CAFE` Section first!');
                    receiptDet.RESET;
                    receiptDet.SETRANGE(receiptDet."Receipt No.", Rec."Receipt No.");
                    sums := 0;
                    IF receiptDet.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            sums := sums + receiptDet."Total Amount";
                            IF receiptDet."Meal Code" <> '' THEN BEGIN
                                IF receiptDet.Quantity < 1 THEN
                                    ERROR('Lines should not have ''ZERO'' QUANTITIES.');
                            END;
                            IF receiptDet."Unit Price" = 0 THEN
                                ERROR('There is a Line with 0, ''ZERO'' SELLING PRICE..');
                        END;
                        UNTIL receiptDet.NEXT = 0;
                    END;

                    IF Rec."Transaction Type" = Rec."Transaction Type"::CREDIT THEN
                        IF Rec."Employee No" = '' THEN ERROR('Employee Number for a Credit Purchase Must be Populated.');

                    IF Rec.Amount < sums THEN
                        IF Rec."Transaction Type" = Rec."Transaction Type"::CASH THEN
                            ERROR('The Amount Paid can not be less than Bill Total!');

                    IF sums = 0.0 THEN
                        ERROR('There are no Items to Print!');

                    cafeReceipts.RESET;
                    cafeReceipts.SETRANGE(cafeReceipts."Receipt No.", Rec."Receipt No.");
                    IF cafeReceipts.FIND('-') THEN BEGIN
                        //REPORT.RUN(51808, TRUE, TRUE, cafeReceipts);
                    END;

                    // Create Ledger Entries
                    receiptLine.RESET;
                    receiptLine.SETRANGE(receiptLine."Receipt No.", Rec."Receipt No.");
                    IF receiptLine.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            MealInventory.RESET;
                            MealInventory.SETRANGE(MealInventory."Item No", receiptLine."Meal Code");
                            MealInventory.SETRANGE(MealInventory."Cafeteria Section", receiptLine."Cafeteria Section");
                            MealInventory.SETRANGE(MealInventory."Menu Date", receiptLine.Date);
                            IF MealInventory.FIND('-') THEN BEGIN
                                MealInventory.CALCFIELDS(MealInventory."Quantity in Store");
                                IF MealInventory."Quantity in Store" < receiptLine.Quantity THEN
                                    ERROR('ERROR: Less quantity on store!');
                            END;
                            mealJournEntries.INIT;
                            mealJournEntries.Template := 'CAFE_INVENTORY';
                            mealJournEntries.Batch := 'ADJUSTMENT';
                            mealJournEntries."Meal Code" := receiptLine."Meal Code";
                            mealJournEntries."Posting Date" := receiptLine.Date;
                            mealJournEntries."Line No." := receiptLine."Line No.";
                            mealJournEntries."Cafeteria Section" := receiptLine."Cafeteria Section";
                            mealJournEntries."Transaction Type" := mealJournEntries."Transaction Type"::"Negative Adjustment";
                            mealJournEntries.Quantity := receiptLine.Quantity * (-1);
                            mealJournEntries."User Id" := receiptLine.User;
                            mealJournEntries."Unit Price" := receiptLine."Unit Price";
                            mealJournEntries."Line Amount" := receiptLine."Total Amount";
                            mealJournEntries."Meal Description" := receiptLine."Meal Descption";
                            mealJournEntries."Receipt No." := Rec."Receipt No.";
                            IF Rec."Transaction Type" = Rec."Transaction Type"::CASH THEN
                                mealJournEntries."Sale Tyle" := mealJournEntries."Sale Tyle"::"Cash Sale"
                            ELSE
                                IF Rec."Transaction Type" = Rec."Transaction Type"::CREDIT THEN
                                    mealJournEntries."Sale Tyle" := mealJournEntries."Sale Tyle"::"Credit Sale"
                                ELSE
                                    IF Rec."Transaction Type" = Rec."Transaction Type"::"ADVANCE PAYMENT" THEN
                                        mealJournEntries."Sale Tyle" := mealJournEntries."Sale Tyle"::"Advance Payment";
                            mealJournEntries.INSERT;
                        END;
                        UNTIL receiptLine.NEXT = 0;
                    END;
                    Rec.Status := Rec.Status::Printed;
                    Rec."Cafeteria Section" := Rec."Cafeteria Section";
                    Rec.MODIFY;
                    MESSAGE('Printed Successfully!');
                    sums := 0.0;
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(IsGrpVisible);

        IF Rec."Transaction Type" = Rec."Transaction Type"::CASH THEN BEGIN

            IsGrpVisible := FALSE;
        END ELSE BEGIN
            IsGrpVisible := TRUE;
            // CurrPage."Employee No".VISIBLE:=TRUE;
            // CurrPage."Employee Name".VISIBLE:=TRUE;
            // CurrPage.lblAmount.EDITABLE:=FALSE;
        END;


        //currpage.EmployeeDet visible=IsGrpVisible;
    end;

    var
        [InDataSet]
        IsGrpVisible: Boolean;
        "User Setup": Record "User Setup";
        cafeReceipts: Record "CAT-Cafeteria Receipts";
        receiptDet: Record "CAT-Cafeteria Receipts Line";
        sums: Decimal;
        sections: Code[10];
        mealJournEntries: Record "CAT-Cafe_Meal Ledger Entries";
        receiptLine: Record "CAT-Cafeteria Receipts Line";
        MealInventory: Record "CAT-Cafeteria Item Inventory";
}

