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
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the purchase invoice number';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name';
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
                field("Posted Invoice No."; Rec."Posted Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted invoice number';
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
                    PurchInvHeader.SetRange("No.", Rec."Invoice No.");
                    if PurchInvHeader.FindFirst() then
                        Page.RunModal(Page::"Purchase Invoice", PurchInvHeader);
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
                    PurchInvHeader.SetRange("No.", Rec."Posted Invoice No.");
                    if PurchInvHeader.FindFirst() then
                        Page.RunModal(Page::"Posted Purchase Invoice", PurchInvHeader);
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
                    if Confirm('Do you want to post invoice %1?', false, Rec."Invoice No.") then begin
                        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
                        PurchHeader.SetRange("No.", Rec."Invoice No.");
                        if PurchHeader.FindFirst() then begin
                            if PurchPost.Run(PurchHeader) then begin
                                Rec.Status := Rec.Status::Posted;
                                Rec."Posted Invoice No." := PurchHeader."Last Posting No.";
                                Rec.Modify();
                                Message('Invoice %1 posted successfully.', Rec."Invoice No.");
                            end;
                        end else
                            Error('Purchase invoice %1 not found.', Rec."Invoice No.");
                    end;
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
                    BatchNo := Rec."Batch No.";
                    
                    if not Confirm('Do you want to post all open invoices for batch %1?', false, BatchNo) then
                        exit;
                    
                    PartTimeInvoiceBatch.Reset();
                    PartTimeInvoiceBatch.SetRange("Batch No.", BatchNo);
                    PartTimeInvoiceBatch.SetRange(Status, PartTimeInvoiceBatch.Status::Open);
                    
                    if PartTimeInvoiceBatch.FindSet() then begin
                        repeat
                            PurchHeader.Reset();
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
                            PurchHeader.SetRange("No.", PartTimeInvoiceBatch."Invoice No.");
                            
                            if PurchHeader.FindFirst() then begin
                                if PurchPost.Run(PurchHeader) then begin
                                    PartTimeInvoiceBatch.Status := PartTimeInvoiceBatch.Status::Posted;
                                    PartTimeInvoiceBatch."Posted Invoice No." := PurchHeader."Last Posting No.";
                                    PartTimeInvoiceBatch.Modify();
                                    Count += 1;
                                end else
                                    FailCount += 1;
                            end else
                                FailCount += 1;
                        until PartTimeInvoiceBatch.Next() = 0;
                        
                        Message('%1 invoices posted successfully. %2 invoices failed.', Count, FailCount);
                    end else
                        Message('No open invoices found for batch %1.', BatchNo);
                end;
            }
        }
    }
}
