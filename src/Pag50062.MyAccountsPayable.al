page 50062 "My Accounts Payable"
{
    Caption = 'My Accounts Payable';
    PageType = CardPart;
    SourceTable = "Vendor Ledger Entry";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Amounts Due")
            {
                Caption = 'Amounts Due';
                field(OverdueAmount; OverdueAmount)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Overdue';
                    ToolTip = 'Specifies the sum of overdue payments to vendors.';
                    
                    trigger OnDrillDown()
                    begin
                        FilterVendorLedgerEntries(true);
                    end;
                }
                field(AmountDueToday; AmountDueToday)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Due Today';
                    ToolTip = 'Specifies the sum of payments to vendors that are due today.';
                    
                    trigger OnDrillDown()
                    begin
                        FilterVendorLedgerEntries(false);
                    end;
                }
                field(AmountDueThisWeek; AmountDueThisWeek)
                {
                    ApplicationArea = Basic, Suite;
                    AutoFormatType = 1;
                    Caption = 'Due This Week';
                    ToolTip = 'Specifies the sum of payments to vendors that are due this week.';
                    
                    trigger OnDrillDown()
                    begin
                        FilterVendorLedgerEntries(false);
                    end;
                }
            }
            cuegroup("Purchase Documents")
            {
                Caption = 'Purchase Documents';
                field(PurchaseInvoices; PurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    DrillDownPageId = "Purchase Invoices";
                    ToolTip = 'Specifies the number of ongoing purchase invoices.';
                }
                field(PurchaseOrders; PurchaseOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Orders';
                    DrillDownPageId = "Purchase Order List";
                    ToolTip = 'Specifies the number of ongoing purchase orders.';
                }
                field(PendingApprovals; PendingApprovals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Approvals';
                    ToolTip = 'Specifies the number of purchase documents pending approval.';
                    
                    trigger OnDrillDown()
                    var
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                        Page.Run(Page::"Approval Entries", ApprovalEntry);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CalculateAmounts();
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateAmounts();
    end;

    local procedure CalculateAmounts()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PurchaseHeader: Record "Purchase Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        // Calculate overdue amount
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetFilter("Due Date", '<%1', WorkDate());
        if VendorLedgerEntry.FindSet() then begin
            OverdueAmount := 0;
            repeat
                VendorLedgerEntry.CalcFields("Remaining Amount");
                OverdueAmount += VendorLedgerEntry."Remaining Amount";
            until VendorLedgerEntry.Next() = 0;
        end else
            OverdueAmount := 0;

        // Calculate amount due today
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetRange("Due Date", WorkDate());
        if VendorLedgerEntry.FindSet() then begin
            AmountDueToday := 0;
            repeat
                VendorLedgerEntry.CalcFields("Remaining Amount");
                AmountDueToday += VendorLedgerEntry."Remaining Amount";
            until VendorLedgerEntry.Next() = 0;
        end else
            AmountDueToday := 0;

        // Calculate amount due this week
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetFilter("Due Date", '>%1&<=%2', WorkDate(), CalcDate('<CW>', WorkDate()));
        if VendorLedgerEntry.FindSet() then begin
            AmountDueThisWeek := 0;
            repeat
                VendorLedgerEntry.CalcFields("Remaining Amount");
                AmountDueThisWeek += VendorLedgerEntry."Remaining Amount";
            until VendorLedgerEntry.Next() = 0;
        end else
            AmountDueThisWeek := 0;

        // Count purchase invoices
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Invoice);
        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Open);
        PurchaseInvoices := PurchaseHeader.Count;

        // Count purchase orders
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Open);
        PurchaseOrders := PurchaseHeader.Count;

        // Count pending approvals
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        PendingApprovals := ApprovalEntry.Count;
    end;

    local procedure FilterVendorLedgerEntries(Overdue: Boolean)
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange(Open, true);
        
        if Overdue then
            VendorLedgerEntry.SetFilter("Due Date", '<%1', WorkDate())
        else
            VendorLedgerEntry.SetFilter("Due Date", '>=%1&<=%2', WorkDate(), CalcDate('<CW>', WorkDate()));
            
        Page.Run(Page::"Vendor Ledger Entries", VendorLedgerEntry);
    end;

    var
        OverdueAmount: Decimal;
        AmountDueToday: Decimal;
        AmountDueThisWeek: Decimal;
        PurchaseInvoices: Integer;
        PurchaseOrders: Integer;
        PendingApprovals: Integer;
}