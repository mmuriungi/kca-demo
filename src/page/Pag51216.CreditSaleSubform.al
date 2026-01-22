page 51216 "Credit Sale Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    DeleteAllowed = true;
    LinksAllowed = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(wete)
            {
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of a general ledger account, item, resource, additional cost, or fixed asset, depending on the contents of the Type field.';

                    // trigger OnValidate()
                    // begin
                    //     NoOnAfterValidate;
                    //     UpdateEditableOnRow;
                    //     ShowShortcutDimCode(ShortcutDimCode);

                    //     QuantityOnAfterValidate;
                    //     IF xRec."No." <> '' THEN
                    //       RedistributeTotalsOnAfterValidate;
                    //     //Quantity:=1;
                    //     //VALIDATE(Quantity);
                    // end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = RowIsNotText;
                    Enabled = RowIsNotText;
                    ShowMandatory = Rec."No." <> '';
                    ToolTip = 'Specifies how many units are being sold.';

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = RowIsNotText;
                    Enabled = RowIsNotText;
                    ShowMandatory = Rec."No." <> '';
                    ToolTip = 'Specifies the price for one unit on the sales line.';

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = RowIsNotText;
                    Enabled = RowIsNotText;
                    ToolTip = 'Specifies the net amount (before subtracting the invoice discount amount) that must be paid for the items on the line.';

                    trigger OnValidate()
                    begin
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of the amounts in the Amount Including Tax fields on the associated sales lines.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    QuickEntry = false;
                    ToolTip = 'Specifies the unit of measure that is used to determine the value in the Unit Price field on the sales line.';

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                        // RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the unit of measure for the item or resource on the sales line.';
                    Visible = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the entry, which is based on the contents of the Type and No. fields.';

                    trigger OnValidate()
                    begin
                        // UpdateEditableOnRow;

                        IF Rec."No." = xRec."No." THEN
                            EXIT;

                        // NoOnAfterValidate;
                        // ShowShortcutDimCode(ShortcutDimCode);
                        // IF xRec."No." <> '' THEN
                        //   RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    QuickEntry = false;
                    ShowMandatory = LocationCodeMandatory;
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
                    Visible = LocationCodeVisible;

                    trigger OnValidate()
                    begin
                        LocationCodeOnAfterValidate;
                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the line number.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
            }
            // group(rty)
            // {
            //     group(erye)
            // {
            //     field(TotalSalesLine."Line Amount";TotalSalesLine."Line Amount")
            //     {
            //         ApplicationArea = Basic,Suite;
            //         AutoFormatExpression = Currency.Code;
            //         AutoFormatType = 1;
            //         CaptionClass = DocumentTotals.GetTotalLineAmountWithVATAndCurrencyCaption(Currency.Code,TotalSalesHeader."Prices Including VAT");
            //         Caption = 'Subtotal Excl. Tax';
            //         Editable = false;
            //         ToolTip = 'Specifies the sum of the value in the Line Amount Excl. Tax field on all lines in the document.';
            //         Visible = false;
            //     }
            //     field("Invoice Discount Amount";InvoiceDiscountAmount)
            //     {
            //         ApplicationArea = Basic,Suite;
            //         AutoFormatExpression = Currency.Code;
            //         AutoFormatType = 1;
            //         CaptionClass = DocumentTotals.GetInvoiceDiscAmountWithVATAndCurrencyCaption(FIELDCAPTION("Inv. Discount Amount"),Currency.Code);
            //         Caption = 'Invoice Discount Amount';
            //         Editable = InvDiscAmountEditable;
            //         ToolTip = 'Specifies a discount amount that is deducted from the value in the Total Incl. Tax field. You can enter or change the amount manually.';
            //         Visible = false;

            //         trigger OnValidate()
            //         begin
            //             ValidateInvoiceDiscountAmount;
            //         end;
            //     }
            //     field("Invoice Disc. Pct.";InvoiceDiscountPct)
            //     {
            //         ApplicationArea = Basic,Suite;
            //         Caption = 'Invoice Discount %';
            //         DecimalPlaces = 0:2;
            //         Editable = InvDiscAmountEditable;
            //         ToolTip = 'Specifies a discount percentage that is granted if criteria that you have set up for the customer are met.';
            //         Visible = false;

            //         trigger OnValidate()
            //         begin
            //             InvoiceDiscountAmount := ROUND(TotalSalesLine."Line Amount" * InvoiceDiscountPct / 100,Currency."Amount Rounding Precision");
            //             ValidateInvoiceDiscountAmount;
            //         end;
            //     }
            // }
            // group()
            // {
            //     field("Total Amount Excl. VAT";TotalSalesLine.Amount)
            //     {
            //         ApplicationArea = Basic,Suite;
            //         AutoFormatExpression = Currency.Code;
            //         AutoFormatType = 1;
            //         CaptionClass = DocumentTotals.GetTotalExclVATCaption(Currency.Code);
            //         Caption = 'Total Amount Excl. Tax';
            //         DrillDown = false;
            //         Editable = false;
            //         ToolTip = 'Specifies the sum of the value in the Line Amount Excl. Tax field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
            //         Visible = false;
            //     }
            //     field("Total VAT Amount";VATAmount)
            //     {
            //         ApplicationArea = Basic,Suite;
            //         AutoFormatExpression = Currency.Code;
            //         AutoFormatType = 1;
            //         CaptionClass = DocumentTotals.GetTotalVATCaption(Currency.Code);
            //         Caption = 'Total Tax';
            //         Editable = false;
            //         ToolTip = 'Specifies the sum of tax amounts on all lines in the document.';
            //         Visible = false;
            //     }
            //     field("Total Amount Incl. VAT";TotalSalesLine."Amount Including VAT")
            //     {
            //         ApplicationArea = Basic,Suite;
            //         AutoFormatExpression = Currency.Code;
            //         AutoFormatType = 1;
            //         CaptionClass = DocumentTotals.GetTotalInclVATCaption(Currency.Code);
            //         Caption = 'Total Amount Incl. Tax';
            //         Editable = false;
            //         ToolTip = 'Specifies the sum of the value in the Line Amount Incl. Tax field on all lines in the document minus any discount amount in the Invoice Discount Amount field.';
            //         Visible = false;
            //     }
            // }
            // }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("F&unctions")
                {
                    Caption = 'F&unctions';
                    Image = "Action";
                    action(GetPrice)
                    {
                        AccessByPermission = TableData 7002 = R;
                        Caption = 'Get Price';
                        Ellipsis = true;
                        Image = Price;

                        trigger OnAction()
                        begin
                            //  ShowPrices;
                        end;
                    }
                    action("Get Li&ne Discount")
                    {
                        AccessByPermission = TableData 7004 = R;
                        Caption = 'Get Li&ne Discount';
                        Ellipsis = true;
                        Image = LineDiscount;

                        trigger OnAction()
                        begin
                            // ShowLineDisc
                        end;
                    }
                    action(ExplodeBOM_Functions)
                    {
                        AccessByPermission = TableData 90 = R;
                        Caption = 'E&xplode BOM';
                        Image = ExplodeBOM;

                        trigger OnAction()
                        begin
                            //  ExplodeBOM;
                        end;
                    }
                    action("Insert Ext. Texts")
                    {
                        AccessByPermission = TableData 279 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insert &Ext. Text';
                        Image = Text;
                        ToolTip = 'Insert the extended item description that is set up for the item on the sales document line.';

                        trigger OnAction()
                        begin
                            //   InsertExtendedText(TRUE);
                        end;
                    }
                    action(Reserve)
                    {
                        Caption = '&Reserve';
                        Ellipsis = true;
                        Image = Reserve;

                        trigger OnAction()
                        begin
                            Rec.FIND;
                            Rec.ShowReservation;
                        end;
                    }
                    action(OrderTracking)
                    {
                        Caption = 'Order &Tracking';
                        Image = OrderTracking;

                        trigger OnAction()
                        begin
                            // ShowTracking;
                        end;
                    }
                    action("Nonstoc&k Items")
                    {
                        AccessByPermission = TableData 5718 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Nonstoc&k Items';
                        Image = NonStockItem;

                        trigger OnAction()
                        begin
                            ShowNonstockItems;
                        end;
                    }
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("<Action3>")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            //  ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            //  ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            //  ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            //  ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                group("Related Information")
                {
                    Caption = 'Related Information';
                    action("Reservation Entries")
                    {
                        AccessByPermission = TableData 27 = R;
                        Caption = 'Reservation Entries';
                        Image = ReservationLedger;

                        trigger OnAction()
                        begin
                            Rec.ShowReservationEntries(TRUE);
                        end;
                    }
                    action(ItemTrackingLines)
                    {
                        Caption = 'Item &Tracking Lines';
                        Image = ItemTrackingLines;
                        ShortCutKey = 'Shift+Ctrl+I';

                        trigger OnAction()
                        begin
                            Rec.OpenItemTrackingLines;
                        end;
                    }
                    action("Select Item Substitution")
                    {
                        AccessByPermission = TableData 5715 = R;
                        ApplicationArea = Suite;
                        Caption = 'Select Item Substitution';
                        Image = SelectItemSubstitution;
                        ToolTip = 'Select another item that has been set up to be sold instead of the original item if it is unavailable.';

                        trigger OnAction()
                        begin
                            Rec.ShowItemSub;
                        end;
                    }
                    action(Dimensions)
                    {
                        AccessByPermission = TableData 348 = R;
                        Caption = 'Dimensions';
                        Image = Dimensions;
                        ShortCutKey = 'Shift+Ctrl+D';

                        trigger OnAction()
                        begin
                            Rec.ShowDimensions;
                        end;
                    }
                    action("Co&mments")
                    {
                        Caption = 'Co&mments';
                        Image = ViewComments;

                        trigger OnAction()
                        begin
                            Rec.ShowLineComments;
                        end;
                    }
                    action("Item Charge &Assignment")
                    {
                        AccessByPermission = TableData 5800 = R;
                        Caption = 'Item Charge &Assignment';
                        Image = ItemCosts;

                        trigger OnAction()
                        begin
                            ItemChargeAssgnt;
                        end;
                    }
                    action(OrderPromising)
                    {
                        AccessByPermission = TableData 99000880 = R;
                        Caption = 'Order &Promising';
                        Image = OrderPromising;

                        trigger OnAction()
                        begin
                            //   OrderPromisingLine;
                        end;
                    }
                    group("Assemble to Order")
                    {
                        Caption = 'Assemble to Order';
                        Image = AssemblyBOM;
                        action(AssembleToOrderLines)
                        {
                            AccessByPermission = TableData 90 = R;
                            Caption = 'Assemble-to-Order Lines';

                            trigger OnAction()
                            begin
                                Rec.ShowAsmToOrderLines;
                            end;
                        }
                        action("Roll Up &Price")
                        {
                            AccessByPermission = TableData 90 = R;
                            Caption = 'Roll Up &Price';
                            Ellipsis = true;

                            trigger OnAction()
                            begin
                                Rec.RollupAsmPrice;
                            end;
                        }
                        action("Roll Up &Cost")
                        {
                            AccessByPermission = TableData 90 = R;
                            Caption = 'Roll Up &Cost';
                            Ellipsis = true;

                            trigger OnAction()
                            begin
                                Rec.RollUpAsmCost;
                            end;
                        }
                    }
                    action(DeferralSchedule)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Schedule';
                        Enabled = Rec."Deferral Code" <> '';
                        Image = PaymentPeriod;
                        ToolTip = 'View or edit the deferral schedule that governs how revenue made with this sales document is deferred to different accounting periods when the document is posted.';

                        trigger OnAction()
                        begin
                            // SalesHeader.GET("Document Type","Document No.");
                            // ShowDeferrals(SalesHeader."Posting Date",SalesHeader."Currency Code");
                        end;
                    }
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Purchase &Order")
                    {
                        AccessByPermission = TableData 120 = R;
                        ApplicationArea = Suite;
                        Caption = 'Purchase &Order';
                        Image = Document;
                        ToolTip = 'View the purchase order that is linked to the Credit Sale Header, for drop shipment.';

                        trigger OnAction()
                        begin
                            // OpenPurchOrderForm;
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(OpenSpecialPurchaseOrder)
                    {
                        AccessByPermission = TableData 120 = R;
                        Caption = 'Purchase &Order';
                        Image = Document;

                        trigger OnAction()
                        begin
                            //OpenSpecialPurchOrderForm;
                        end;
                    }
                }
                // action(BlanketOrder)
                // {
                //     Caption = 'Blanket Order';
                //     Image = BlanketOrder;
                //     ToolTip = 'View the blanket Credit Sale Header.';

                //     trigger OnAction()
                //     var
                //         SalesHeader: Record "36";
                //         BlanketSalesOrder: Page "507";
                //     begin
                //         TESTFIELD("Blanket Order No.");
                //         SalesHeader.SETRANGE("No.","Blanket Order No.");
                //         IF NOT SalesHeader.ISEMPTY THEN BEGIN
                //           BlanketSalesOrder.SETTABLEVIEW(SalesHeader);
                //           BlanketSalesOrder.EDITABLE := FALSE;
                //           BlanketSalesOrder.RUN;
                //         END;
                //     end;
                // }
            }
        }
    }

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CalculateTotals;
    //     // SetLocationCodeMandatory;
    //     // UpdateEditableOnRow;
    // end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    // trigger OnDeleteRecord(): Boolean
    // var
    //     ReserveSalesLine: Codeunit "99000832";
    // begin
    //     IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
    //       COMMIT;
    //       IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
    //         EXIT(FALSE);
    //       ReserveSalesLine.DeleteLine(Rec);
    //     END;
    // end;

    trigger OnInit()
    begin
        // SalesSetup.GET;
        // Currency.InitRoundingPrecision;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //IF ApplicationAreaSetup.IsFoundationEnabled THEN
        Rec.Type := Rec.Type::Item;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //IF ApplicationAreaSetup.IsFoundationEnabled THEN
        Rec.Type := Rec.Type::Item
        //ELSE
        // InitType;
        //CLEAR(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        Location: Record "Location";
        TaxGroup: Record "Tax Group";
    begin
        IF Location.READPERMISSION THEN
            LocationCodeVisible := NOT Location.ISEMPTY;
        TaxGroupCodeVisible := NOT TaxGroup.ISEMPTY;
    end;

    var
        // Currency: Record "4";
        // TotalSalesHeader: Record "36";
        // TotalSalesLine: Record "37";
        // SalesHeader: Record "36";
        // ApplicationAreaSetup: Record "9178";
        // SalesSetup: Record "311";
        // SalesPriceCalcMgt: Codeunit "7000";
        // TransferExtendedText: Codeunit "378";
        // ItemAvailFormsMgt: Codeunit "353";
        // SalesCalcDiscountByType: Codeunit "56";
        // DocumentTotals: Codeunit "57";
        VATAmount: Decimal;
        ShortcutDimCode: array[8] of Code[20];
        Text001: Label 'You cannot use the Explode BOM function because a prepayment of the Credit Sale Header has been invoiced.';
        LocationCodeMandatory: Boolean;
        InvDiscAmountEditable: Boolean;
        RowIsNotText: Boolean;
        UnitofMeasureCodeIsChangeable: Boolean;
        LocationCodeVisible: Boolean;
        TaxGroupCodeVisible: Boolean;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    // local procedure ValidateInvoiceDiscountAmount()
    // var
    //     SalesHeader: Record "Sales Header";
    // begin
    //     SalesHeader.GET("Document Type","Document No.");
    //     SalesCalcDiscountByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount,SalesHeader);
    //     CurrPage.UPDATE(FALSE);
    // end;

    // procedure CalcInvDisc()
    // begin
    //     CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
    // end;

    // procedure ExplodeBOM()
    // begin
    //     IF "Prepmt. Amt. Inv." <> 0 THEN
    //       ERROR(Text001);
    //     CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
    // end;

    // procedure OpenPurchOrderForm()
    // var
    //     PurchHeader: Record "38";
    //     PurchOrder: Page "50";
    // begin
    //     TESTFIELD("Purchase Order No.");
    //     PurchHeader.SETRANGE("No.","Purchase Order No.");
    //     PurchOrder.SETTABLEVIEW(PurchHeader);
    //     PurchOrder.EDITABLE := FALSE;
    //     PurchOrder.RUN;
    // end;

    // procedure OpenSpecialPurchOrderForm()
    // var
    //     PurchHeader: Record "38";
    //     PurchRcptHeader: Record "120";
    //     PurchOrder: Page "50";
    // begin
    //     TESTFIELD("Special Order Purchase No.");
    //     PurchHeader.SETRANGE("No.","Special Order Purchase No.");
    //     IF NOT PurchHeader.ISEMPTY THEN BEGIN
    //       PurchOrder.SETTABLEVIEW(PurchHeader);
    //       PurchOrder.EDITABLE := FALSE;
    //       PurchOrder.RUN;
    //     END ELSE BEGIN
    //       PurchRcptHeader.SETRANGE("Order No.","Special Order Purchase No.");
    //       IF PurchRcptHeader.COUNT = 1 THEN
    //         PAGE.RUN(PAGE::"Posted Purchase Receipt",PurchRcptHeader)
    //       ELSE
    //         PAGE.RUN(PAGE::"Posted Purchase Receipts",PurchRcptHeader);
    //     END;
    // end;

    // procedure InsertExtendedText(Unconditionally: Boolean)
    // begin
    //     IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
    //       CurrPage.SAVERECORD;
    //       COMMIT;
    //       TransferExtendedText.InsertSalesExtText(Rec);
    //     END;
    //     IF TransferExtendedText.MakeUpdate THEN
    //       UpdateForm(TRUE);
    // end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock;
    end;

    // procedure ShowTracking()
    // var
    //     TrackingForm: Page "99000822";
    // begin
    //     TrackingForm.SetSalesLine(Rec);
    //     TrackingForm.RUNMODAL;
    // end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    // procedure UpdateForm(SetSaveRecord: Boolean)
    // begin
    //     CurrPage.UPDATE(SetSaveRecord);
    // end;

    // procedure ShowPrices()
    // begin
    //     SalesHeader.GET("Document Type","Document No.");
    //     CLEAR(SalesPriceCalcMgt);
    //     SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader,Rec);
    // end;

    // procedure ShowLineDisc()
    // begin
    //     SalesHeader.GET("Document Type","Document No.");
    //     CLEAR(SalesPriceCalcMgt);
    //     SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader,Rec);
    // end;

    // procedure OrderPromisingLine()
    // var
    //     OrderPromisingLine: Record "99000880" temporary;
    //     OrderPromisingLines: Page "99000959";
    // begin
    //     OrderPromisingLine.SETRANGE("Source Type","Document Type");
    //     OrderPromisingLine.SETRANGE("Source ID","Document No.");
    //     OrderPromisingLine.SETRANGE("Source Line No.","Line No.");

    //     OrderPromisingLines.SetSourceType(OrderPromisingLine."Source Type"::Sales);
    //     OrderPromisingLines.SETTABLEVIEW(OrderPromisingLine);
    //     OrderPromisingLines.RUNMODAL;
    // end;

    // local procedure NoOnAfterValidate()
    // begin
    //     IF ApplicationAreaSetup.IsFoundationEnabled THEN
    //       TESTFIELD(Type,Type::Item);

    //     InsertExtendedText(FALSE);
    //     IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
    //        (xRec."No." <> '')
    //     THEN
    //       CurrPage.SAVERECORD;

    //     SaveAndAutoAsmToOrder;

    //     IF Reserve = Reserve::Always THEN BEGIN
    //       CurrPage.SAVERECORD;
    //       IF ("Outstanding Qty. (Base)" <> 0) AND ("No." <> xRec."No.") THEN BEGIN
    //         AutoReserve;
    //         CurrPage.UPDATE(FALSE);
    //       END;
    //     END;
    // end;

    local procedure VariantCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;

        IF (Rec.Reserve = Rec.Reserve::Always) AND
           (Rec."Outstanding Qty. (Base)" <> 0) AND
           (Rec."Location Code" <> xRec."Location Code")
        THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        IF Rec.Type = Rec.Type::Item THEN
            CASE Rec.Reserve OF
                Rec.Reserve::Always:
                    BEGIN
                        CurrPage.SAVERECORD;
                        Rec.AutoReserve;
                        CurrPage.UPDATE(FALSE);
                        UpdateIsDone := TRUE;
                    END;
                Rec.Reserve::Optional:
                    IF (Rec.Quantity < xRec.Quantity) AND (xRec.Quantity > 0) THEN BEGIN
                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(FALSE);
                        UpdateIsDone := TRUE;
                    END;
            END;

        IF (Rec.Type = Rec.Type::Item) AND
           (Rec.Quantity <> xRec.Quantity) AND
           NOT UpdateIsDone
        THEN
            CurrPage.UPDATE(TRUE);
    end;

    local procedure QtyToAsmToOrderOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        IF Rec.Reserve = Rec.Reserve::Always THEN
            Rec.AutoReserve;
        CurrPage.UPDATE(TRUE);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND
           (Rec."Outstanding Qty. (Base)" <> 0) AND
           (Rec."Shipment Date" <> xRec."Shipment Date")
        THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END ELSE
            CurrPage.UPDATE(TRUE);
    end;

    local procedure SaveAndAutoAsmToOrder()
    begin
        IF (Rec.Type = Rec.Type::Item) AND Rec.IsAsmToOrderRequired THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoAsmToOrder;
            CurrPage.UPDATE(FALSE);
        END;
    end;

    // local procedure SetLocationCodeMandatory()
    // var
    //     InventorySetup: Record "313";
    // begin
    //     InventorySetup.GET;
    //     LocationCodeMandatory := InventorySetup."Location Mandatory" AND (Type = Type::Item);
    // end;

    // local procedure GetTotalSalesHeader()
    // begin
    //     IF NOT TotalSalesHeader.GET("Document Type","Document No.") THEN
    //       CLEAR(TotalSalesHeader);
    //     IF Currency.Code <> TotalSalesHeader."Currency Code" THEN
    //       IF NOT Currency.GET(TotalSalesHeader."Currency Code") THEN
    //         Currency.InitRoundingPrecision;
    // end;

    // local procedure CalculateTotals()
    // begin
    //     GetTotalSalesHeader;
    //     TotalSalesHeader.CALCFIELDS("Recalculate Invoice Disc.");

    //     IF SalesSetup."Calc. Inv. Discount" AND ("Document No." <> '') AND (TotalSalesHeader."Customer Posting Group" <> '') AND
    //        TotalSalesHeader."Recalculate Invoice Disc."
    //     THEN
    //       CalcInvDisc;

    //     DocumentTotals.CalculateSalesTotals(TotalSalesLine,VATAmount,Rec);
    //     InvoiceDiscountAmount := TotalSalesLine."Inv. Discount Amount";
    //     InvoiceDiscountPct := SalesCalcDiscountByType.GetCustInvoiceDiscountPct(Rec);
    // end;

    // local procedure RedistributeTotalsOnAfterValidate()
    // begin
    //     CurrPage.SAVERECORD;

    //     SalesHeader.GET("Document Type","Document No.");
    //     DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
    //     CurrPage.UPDATE;
    // end;

    local procedure ValidateSaveShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        Rec.ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
        CurrPage.SAVERECORD;
    end;

    // local procedure UpdateEditableOnRow()
    // var
    //     SalesLine: Record "37";
    // begin
    //     RowIsNotText := NOT (("No." = '') AND (Description <> ''));
    //     IF RowIsNotText THEN
    //       UnitofMeasureCodeIsChangeable := CanEditUnitOfMeasureCode
    //     ELSE
    //       UnitofMeasureCodeIsChangeable := FALSE;

    //     IF TotalSalesHeader."No." <> '' THEN BEGIN
    //       SalesLine.SETRANGE("Document No.",TotalSalesHeader."No.");
    //       SalesLine.SETRANGE("Document Type",TotalSalesHeader."Document Type");
    //       IF NOT SalesLine.ISEMPTY THEN
    //         InvDiscAmountEditable :=
    //           SalesCalcDiscountByType.InvoiceDiscIsAllowed(TotalSalesHeader."Invoice Disc. Code") AND CurrPage.EDITABLE;
    //     END;
    // end;
}

