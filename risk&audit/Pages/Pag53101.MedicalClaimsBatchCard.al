page 53101 "Medical Claims Batch Card"
{
    ApplicationArea = All;
    Caption = 'Medical Claims Batch Card';
    PageType = Card;
    SourceTable = "Medical Claims Batch";
    
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
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the batch';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number';
                    ShowMandatory = true;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Global Dimension 1 Code';
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Global Dimension 2 Code';
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shortcut Dimension 3 Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the responsibility center code';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the batch was created';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the batch';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount of claims in this batch';
                }
                field("No. of Claims"; Rec."No. of Claims")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of claims in this batch';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the batch';
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the invoice number';
                }
                field("Posted Invoice No."; Rec."Posted Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted invoice number';
                }
            }
            part(MedicalClaims; "Medical Claims Subform")
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
                Enabled = Rec."Invoice Generated";
                
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
            action(ImportClaims)
            {
                ApplicationArea = All;
                Caption = 'Import Claims from CSV';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import medical claims from a CSV file';
                Enabled = (Rec.Status = Rec.Status::Open);
                
                trigger OnAction()
                var
                begin
                    if not Confirm('Do you want to import claims for batch %1?', false, Rec."Batch No.") then
                        exit;
                end;
            }
            
            action(GenerateInvoice)
            {
                ApplicationArea = All;
                Caption = 'Generate Invoice';
                Image = NewPurchaseInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate a purchase invoice for this batch';
                Enabled = (Rec.Status = Rec.Status::Open) and (not Rec."Invoice Generated") and (Rec."Vendor No." <> '');
                
                trigger OnAction()
                var
                begin
                    if not Confirm('Do you want to generate an invoice for batch %1?', false, Rec."Batch No.") then
                        exit;
                end;
            }
            
            action(PostInvoice)
            {
                ApplicationArea = All;
                Caption = 'Post Invoice';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Post the purchase invoice for this batch';
                Enabled = Rec."Invoice Generated" and (Rec.Status = Rec.Status::Open);
                
                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    PurchPost: Codeunit "Purch.-Post";
                begin
                    if not Confirm('Do you want to post invoice %1?', false, Rec."Invoice No.") then
                        exit;
                    
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
            }
            
            action(ApproveBatch)
            {
                ApplicationArea = All;
                Caption = 'Approve Batch';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Approve this medical claims batch';
                Enabled = Rec.Status = Rec.Status::Open;
                
                trigger OnAction()
                begin
                    if Confirm('Do you want to approve batch %1?', false, Rec."Batch No.") then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                        Message('Batch %1 has been approved.', Rec."Batch No.");
                    end;
                end;
            }
        }
    }
}
