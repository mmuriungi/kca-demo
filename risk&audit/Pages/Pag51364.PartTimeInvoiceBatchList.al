page 52100 "PartTime Invoice Batch List"
{
    ApplicationArea = All;
    Caption = 'PartTime Invoice Batch List';
    PageType = List;
    SourceTable = "PartTime Invoice Batch";
    UsageCategory = Lists;
    Editable = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
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
                    PurchInvHeader.SetRange("Document Type", PurchInvHeader."Document Type"::Invoice);
                    PurchInvHeader.SetRange("Batch No.", Rec."Batch No.");
                    if PurchInvHeader.FindSet() then
                        Page.RunModal(Page::"Purchase Invoices", PurchInvHeader);
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
                    PurchInvHeader.Reset();
                    PurchInvHeader.SetRange("Batch No.", Rec."Batch No.");
                    if PurchInvHeader.FindSet() then
                        Page.RunModal(Page::"Posted Purchase Invoices", PurchInvHeader);
                end;
            }
        }
        
        area(Processing)
        {
            action(PostAllInvoices)
            {
                ApplicationArea = All;
                Caption = 'Post All Invoices';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post all open invoices for this batch';
                Enabled = Rec.Status = Rec.Status::Open;
                
                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                begin
                    if not confirm('Are you sure you want to post all invoices for this batch?') then exit;
                    PurchHeader.Reset();
                    PurchHeader.SetRange("Batch No.", Rec."Batch No.");
                    if PurchHeader.FindSet() then begin
                        repeat
                            if not PurchHeader.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)") then
                                exit;
                        until PurchHeader.Next() = 0;
                    end;
                    Rec.Status := Rec.Status::Posted;
                    Rec.Modify();
                end;
            }
        }
    }
}
