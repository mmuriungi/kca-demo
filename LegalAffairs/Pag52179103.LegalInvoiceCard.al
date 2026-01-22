page 52179103 "Legal Invoice Card"
{
    PageType = Card;
    SourceTable = "Legal Invoice";
    Caption = 'Legal Invoice Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the invoice number.';
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the invoice date.';
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the service type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                    MultiLine = true;
                }
            }
            
            group("Vendor Information")
            {
                Caption = 'Vendor Information';
                
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor name.';
                }
                field("External Counsel"; Rec."External Counsel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the external counsel.';
                }
            }
            
            group("Service Details")
            {
                Caption = 'Service Details';
                
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hours worked.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hourly rate.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
            }
            
            group("Financial Details")
            {
                Caption = 'Financial Details';
                
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount in local currency.';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT amount.';
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount.';
                    Editable = false;
                    StyleExpr = 'Strong';
                }
            }
            
            group("Payment Information")
            {
                Caption = 'Payment Information';
                
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment status.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date.';
                }
                field("Posted"; Rec."Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the invoice has been posted.';
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posted date.';
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who posted the invoice.';
                    Editable = false;
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Budget Code"; Rec."Budget Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budget code.';
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expense code.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Approve Invoice")
            {
                ApplicationArea = All;
                Caption = 'Approve Invoice';
                Image = Approve;
                ToolTip = 'Approve this invoice for payment.';
                
                trigger OnAction()
                begin
                    if Rec."Payment Status" = Rec."Payment Status"::Pending then begin
                        Rec."Payment Status" := Rec."Payment Status"::Approved;
                        Rec.Modify(true);
                        CurrPage.Update();
                        Message('Invoice %1 has been approved.', Rec."Invoice No.");
                    end;
                end;
            }
            action("Post Invoice")
            {
                ApplicationArea = All;
                Caption = 'Post Invoice';
                Image = Post;
                ToolTip = 'Post this invoice to the general ledger.';
                
                trigger OnAction()
                begin
                    PostInvoice();
                end;
            }
        }
    }
    
    local procedure PostInvoice()
    begin
        if Rec."Payment Status" = Rec."Payment Status"::Approved then begin
            Rec."Payment Status" := Rec."Payment Status"::Posted;
            Rec."Posted" := true;
            Rec."Posted Date" := Today;
            Rec."Posted By" := UserId;
            Rec.Modify(true);
            Message('Invoice %1 has been posted.', Rec."Invoice No.");
            CurrPage.Update();
        end else
            Error('Invoice must be approved before posting.');
    end;
}