page 52102 "PartTime Invoice Subform"
{
    ApplicationArea = All;
    Caption = 'Purchase Invoices';
    PageType = ListPart;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Invoice));
    CardPageID = "Purchase Invoice";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the invoice.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of the invoice.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the document.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(EditInvoice)
            {
                ApplicationArea = All;
                Caption = 'Edit Invoice';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Edit the selected invoice';

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Purchase Invoice", Rec);
                end;
            }
        }
    }
}
