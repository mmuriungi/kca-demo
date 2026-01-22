page 52179102 "Legal Invoice List"
{
    PageType = List;
    SourceTable = "Legal Invoice";
    Caption = 'Legal Invoice List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Invoice Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor number.';
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
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the service type.';
                }
                field("Hours Worked"; Rec."Hours Worked")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hours worked.';
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hourly rate.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment status.';
                    StyleExpr = PaymentStatusStyle;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the due date.';
                    StyleExpr = DueDateStyle;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("New Invoice")
            {
                ApplicationArea = All;
                Caption = 'New Invoice';
                Image = New;
                ToolTip = 'Create a new legal invoice.';
                RunPageMode = Create;
                RunObject = page "Legal Invoice Card";
            }
            action("Approve Invoice")
            {
                ApplicationArea = All;
                Caption = 'Approve Invoice';
                Image = Approve;
                ToolTip = 'Approve the selected invoice.';
                
                trigger OnAction()
                begin
                    if Rec."Payment Status" = Rec."Payment Status"::Pending then begin
                        Rec."Payment Status" := Rec."Payment Status"::Approved;
                        Rec.Modify(true);
                        CurrPage.Update();
                    end;
                end;
            }
            action("Post Invoice")
            {
                ApplicationArea = All;
                Caption = 'Post Invoice';
                Image = Post;
                ToolTip = 'Post the invoice to the general ledger.';
                
                trigger OnAction()
                begin
                    PostInvoice();
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;
    
    local procedure SetStyles()
    begin
        PaymentStatusStyle := 'Standard';
        DueDateStyle := 'Standard';
        
        case Rec."Payment Status" of
            Rec."Payment Status"::Paid:
                PaymentStatusStyle := 'Favorable';
            Rec."Payment Status"::Pending:
                PaymentStatusStyle := 'Attention';
            Rec."Payment Status"::Cancelled:
                PaymentStatusStyle := 'Subordinate';
        end;
        
        if (Rec."Due Date" <> 0D) and (Rec."Due Date" <= Today) and (Rec."Payment Status" <> Rec."Payment Status"::Paid) then
            DueDateStyle := 'Unfavorable'
        else if (Rec."Due Date" <> 0D) and (Rec."Due Date" <= Today + 7) then
            DueDateStyle := 'Attention';
    end;
    
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
    
    var
        PaymentStatusStyle: Text;
        DueDateStyle: Text;
}