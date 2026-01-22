page 52178535 "Proc-Purchase Quotes.LPart"
{

    Caption = 'Purchase Quotes';
    CardPageID = "Proc-Purchase Quote.Card";
    DataCaptionFields = "Buy-from Vendor No.";
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = filter(Quote), DocApprovalType = const(Quote), "Document Type 2" = const(Quote));


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Bidder No."; Rec."Bidder No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bidder No. field.';
                }

                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    Caption = 'Vendor Name';
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Quote Status"; Rec."Quote Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote Status field.';
                }

            }
        }

    }

    actions
    {

    }
    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter;

        Rec.CopyBuyFromVendorFilter;
    end;

    var
        DocPrint: Codeunit "Document-Print";

}
