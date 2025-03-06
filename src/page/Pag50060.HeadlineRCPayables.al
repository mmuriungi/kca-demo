page 50060 "Headline RC Payables"
{
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    Caption = 'Payables Activities';

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                Visible = UserGreetingVisible;
                field(GreetingText; RCHeadlinesPageCommon.GetGreetingText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline';
                    Editable = false;
                }
            }
            group(Control2)
            {
                ShowCaption = false;
                Visible = PayablesHeadlineVisible;
                field(PayablesHeadlineText; PayablesHeadlineText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payables headline';
                    Editable = false;
                    
                    trigger OnDrillDown()
                    begin
                        if PayablesHeadlineVisible then
                            Page.Run(Page::"Vendor List");
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Payables");
        UpdateHeadlines();
    end;

    local procedure UpdateHeadlines()
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        AmountDue: Decimal;
    begin
        PayablesHeadlineVisible := false;
        
        // Check for overdue vendor payments
        VendorLedgerEntry.SetRange(Open, true);
        VendorLedgerEntry.SetFilter("Due Date", '<%1', WorkDate());
        if VendorLedgerEntry.FindSet() then begin
            repeat
                VendorLedgerEntry.CalcFields("Remaining Amount");
                AmountDue += VendorLedgerEntry."Remaining Amount";
            until VendorLedgerEntry.Next() = 0;
            
            if AmountDue > 0 then begin
                PayablesHeadlineText := StrSubstNo('You have %1 in overdue payments', Format(AmountDue, 0, '<Precision,2:2><Standard Format,0>'));
                PayablesHeadlineVisible := true;
            end;
        end;
        
        // If no overdue payments, show pending invoices
        if not PayablesHeadlineVisible then begin
            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange(Open, true);
            VendorLedgerEntry.SetFilter("Due Date", '>=%1', WorkDate());
            VendorLedgerEntry.SetFilter("Due Date", '<%1', CalcDate('<+7D>', WorkDate()));
            
            if VendorLedgerEntry.FindSet() then begin
                VendorLedgerEntry.CalcFields("Remaining Amount");
                PayablesHeadlineText := StrSubstNo('You have %1 in payments due this week', Format(VendorLedgerEntry.Count, 0, 0));
                PayablesHeadlineVisible := true;
            end else begin
                PayablesHeadlineText := 'No payments due this week';
                PayablesHeadlineVisible := true;
            end;
        end;
        
        UserGreetingVisible := not PayablesHeadlineVisible;
    end;

    var
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
        PayablesHeadlineText: Text;
        PayablesHeadlineVisible: Boolean;
        UserGreetingVisible: Boolean;
}