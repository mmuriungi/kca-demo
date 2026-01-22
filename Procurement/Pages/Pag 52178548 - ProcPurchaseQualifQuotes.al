page 52178548 "Proc-Purchase Qualif.Quotes"
{

    Caption = 'Qualified Quotes';
    CardPageID = "Proc-Purchase Quote.Card";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = filter(Quote), DocApprovalType = const(Quote), "Document Type 2" = const(Quote),
    "Quote Status" = filter("Prelim qualif" | "Tech Qualf" | "Demo Qualif" | "Fin Qualif"));


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Quote Status"; Rec."Quote Status")
                {
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
