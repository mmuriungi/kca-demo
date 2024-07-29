page 53079 "CAT-Catering Transfer Order"
{
    Caption = 'Transfer Order';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Transfer Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = true;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = true;
                }
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    Editable = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = true;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(TransferLines; "Transfer Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No."),
                              "Derived From Line No." = CONST(0);
            }
            group("Transfer-from")
            {
                Caption = 'Transfer-from';
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    Editable = false;
                }
                field("Transfer-from Name 2"; Rec."Transfer-from Name 2")
                {
                    Editable = false;
                }
                field("Transfer-from Address"; Rec."Transfer-from Address")
                {
                    Editable = false;
                }
                field("Transfer-from Address 2"; Rec."Transfer-from Address 2")
                {
                    Editable = false;
                }
                field("Transfer-from Post Code"; Rec."Transfer-from Post Code")
                {
                    Caption = 'Transfer-from Post Code/City';
                    Editable = false;
                }
                field("Transfer-from City"; Rec."Transfer-from City")
                {
                    Editable = false;
                }
                field("Transfer-from Contact"; Rec."Transfer-from Contact")
                {
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {

                    trigger OnValidate()
                    begin
                        ShipmentDateOnAfterValidate;
                    end;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
            }
            group("Transfer-to")
            {
                Caption = 'Transfer-to';
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    Editable = false;
                }
                field("Transfer-to Name 2"; Rec."Transfer-to Name 2")
                {
                    Editable = false;
                }
                field("Transfer-to Address"; Rec."Transfer-to Address")
                {
                    Editable = false;
                }
                field("Transfer-to Address 2"; Rec."Transfer-to Address 2")
                {
                    Editable = false;
                }
                field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
                {
                    Caption = 'Transfer-to Post Code/City';
                    Editable = false;
                }
                field("Transfer-to City"; Rec."Transfer-to City")
                {
                    Editable = false;
                }
                field("Transfer-to Contact"; Rec."Transfer-to Contact")
                {
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {

                    trigger OnValidate()
                    begin
                        ReceiptDateOnAfterValidate;
                    end;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Area"; Rec."Area")
                {
                }
                field("Entry/Exit Point"; Rec."Entry/Exit Point")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Transfer Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Inventory Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Transfer Order"),
                                  "No." = FIELD("No.");
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page "Posted Transfer Shipments";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                }
                action("Re&ceipts")
                {
                    Caption = 'Re&ceipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Transfer Receipts";
                    RunPageLink = "Transfer Order No." = FIELD("No.");
                }
                // action(Dimensions)
                // {
                //     Caption = 'Dimensions';
                //     Image = Dimensions;
                //     RunObject = Page 546;
                // }
                // action("Whse. Shi&pments")
                // {
                //     Caption = 'Whse. Shi&pments';
                //     RunObject = Page 7341;
                //     RunPageLink = Source Type=CONST(5741),
                //                   Source Subtype=CONST(0),
                //                   Source No.=FIELD(No.);
                //     RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                // }
                // action("&Whse. Receipts")
                // {
                //     Caption = '&Whse. Receipts';
                //     RunObject = Page 7342;
                //     RunPageLink = Source Type=CONST(5741),
                //                   Source Subtype=CONST(1),
                //                   Source No.=FIELD(No.);
                //     RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
                // }
                // action("In&vt. Put-away/Pick Lines")
                // {
                //     Caption = 'In&vt. Put-away/Pick Lines';
                //     RunObject = Page 5774;
                //     RunPageLink = Source Document=FILTER(Inbound Transfer|Outbound Transfer),
                //                   Source No.=FIELD(No.);
                //     RunPageView = SORTING(Source Document,Source No.,Location Code);
                // }
            }
            group("&Line")
            {
                Caption = '&Line';
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit 5708;
                    ShortCutKey = 'Ctrl+F9';
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                // action("P&ost")
                // {
                //     Caption = 'P&ost';
                //     Ellipsis = true;
                //     Image = Post;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     PromotedIsBig = true;
                //     RunObject = Codeunit 51101;
                //     ShortCutKey = 'F9';
                // }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "TransferOrder-Post + Print";
                    ShortCutKey = 'Shift+F9';
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DocPrint: Codeunit "Document-Print";
                begin
                    DocPrint.PrintTransferHeader(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TESTFIELD(Status, Rec.Status::Open);
    end;

    local procedure PostingDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentServiceCodeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingAgentCodeOnAfterValida()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShippingTimeOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure OutboundWhseHandlingTimeOnAfte()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ReceiptDateOnAfterValidate()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure InboundWhseHandlingTimeOnAfter()
    begin
        CurrPage.TransferLines.PAGE.UpdateForm(TRUE);
    end;
}

