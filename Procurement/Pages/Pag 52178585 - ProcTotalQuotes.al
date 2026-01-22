page 52178585 "Proc-Total Quotes"
{
    CardPageID = "Proc-Purchase Quote.Card";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
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
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }

                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Name';
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
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sum of amounts, including VAT, on all the lines in the document. This will include invoice discounts.';
                }
                field("Technical Evaluation"; Rec."Technical Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Technical Evaluation field.';
                }
                field("Demo Evaluation"; Rec."Demo Evaluation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Demo Evaluation field.';
                }
                field("Financial Score"; Rec."Financial Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Score field.';
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
