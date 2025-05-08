page 52101 "PartTime Invoice Batch Card"
{
    ApplicationArea = All;
    Caption = 'PartTime Invoice Batch Card';
    PageType = Card;
    SourceTable = "PartTime Invoice Batch";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the batch number';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the invoice amount';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the invoice was created';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the invoice';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the invoice';
                }
            }
            part(PurchaseInvoices; "PartTime Invoice Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Batch No." = field("Batch No.");
                UpdatePropagation = Both;
            }
        }
    }
    
    actions
    {
        area(Navigation)
        {
            action(ViewInvoice)
            {
                ApplicationArea = All;
                Caption = 'View Invoice';
                Image = Invoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View the purchase invoice';
                
                trigger OnAction()
                var
                    PurchInvHeader: Record "Purchase Header";
                begin
                  
                end;
            }
            
            action(ViewPostedInvoice)
            {
                ApplicationArea = All;
                Caption = 'View Posted Invoice';
                Image = PostedOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View the posted purchase invoice';
                Enabled = Rec.Status = Rec.Status::Posted;
                
                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                   
                end;
            }
        }
        
        area(Processing)
        {
            action(PostInvoice)
            {
                ApplicationArea = All;
                Caption = 'Post Invoice';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post the selected purchase invoice';
                Enabled = Rec.Status = Rec.Status::Open;
                
                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    PurchPost: Codeunit "Purch.-Post";
                begin
                   
                end;
            }
            
            action(PostAllInvoices)
            {
                ApplicationArea = All;
                Caption = 'Post All Invoices';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post all open invoices for this batch';
                
                trigger OnAction()
                var
                    PartTimeInvoiceBatch: Record "PartTime Invoice Batch";
                    PurchHeader: Record "Purchase Header";
                    PurchPost: Codeunit "Purch.-Post";
                    BatchNo: Code[20];
                    Count: Integer;
                    FailCount: Integer;
                begin
                    
                end;
            }
        }
    }
}
