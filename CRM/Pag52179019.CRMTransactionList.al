page 52179019 "CRM Transaction List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CRM Transaction";
    Caption = 'CRM Transactions';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Transactions)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            // Transaction analytics factbox will be created later
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewTransaction)
            {
                ApplicationArea = All;
                Caption = 'New Transaction';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                
                trigger OnAction()
                var
                    TransactionRec: Record "CRM Transaction";
                begin
                    TransactionRec.Init();
                    TransactionRec."Transaction Date" := WorkDate();
                    TransactionRec."Created By" := UserId;
                    TransactionRec."Created Date" := CurrentDateTime;
                    if TransactionRec.Insert() then
                        Message('New transaction created with Entry No. %1', TransactionRec."Entry No.");
                end;
            }
            
            action(MarkPaid)
            {
                ApplicationArea = All;
                Caption = 'Mark as Paid';
                Image = Completed;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Pending then begin
                        Rec.Status := Rec.Status::Completed;
                        Rec.Modify();
                        Message('Transaction %1 has been marked as paid.', Rec."Entry No.");
                    end else
                        Message('Only pending transactions can be marked as paid.');
                end;
            }
            
            action(Void)
            {
                ApplicationArea = All;
                Caption = 'Void Transaction';
                Image = Void;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    if Rec.Status in [Rec.Status::Pending, Rec.Status::Completed] then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify();
                        Message('Transaction %1 has been voided.', Rec."Entry No.");
                    end else
                        Message('This transaction cannot be voided.');
                end;
            }
        }
        
        area(Navigation)
        {
            action(CustomerCard)
            {
                ApplicationArea = All;
                Caption = 'Customer Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                begin
                    Message('Customer card for %1 would open here.', Rec."Customer No.");
                end;
            }
            
            action(CustomerTransactions)
            {
                ApplicationArea = All;
                Caption = 'All Customer Transactions';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    TransactionList: Page "CRM Transaction List";
                    TransactionRec: Record "CRM Transaction";
                begin
                    TransactionRec.SetRange("Customer No.", Rec."Customer No.");
                    TransactionList.SetTableView(TransactionRec);
                    TransactionList.Run();
                end;
            }
        }
        
        area(Reporting)
        {
            action(TransactionReport)
            {
                ApplicationArea = All;
                Caption = 'Transaction Report';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Transaction report would be generated here.');
                end;
            }
            
            action(PaymentReport)
            {
                ApplicationArea = All;
                Caption = 'Payment Analysis';
                Image = Report;
                
                trigger OnAction()
                begin
                    Message('Payment analysis report would be generated here.');
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        // Set default sorting by transaction date (newest first)
        Rec.SetCurrentKey("Transaction Date");
        Rec.Ascending(false);
    end;
}