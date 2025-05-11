page 52105 "Post Custom Ledger Filter"
{
    PageType = StandardDialog;
    Caption = 'Filter Date Range';
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            group(DateFilters)
            {
                Caption = 'Date Range';
                
                field(StartDateField; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the start date for filtering records.';
                }
                field(EndDateField; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ToolTip = 'Specifies the end date for filtering records.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ProcessRecords)
            {
                ApplicationArea = All;
                Caption = 'Process Records';
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Process the records within the selected date range.';
                
                trigger OnAction()
                begin
                    // Call the function to process records
                    CurrPage.Close();
                    ProcessCustomLedgerEntries(StartDate, EndDate);
                end;
            }
        }
    }
    
    var
        StartDate: Date;
        EndDate: Date;
        
    trigger OnOpenPage()
    begin
        StartDate := WorkDate();
        EndDate := WorkDate();
    end;
    
    procedure GetDateFilter(var FromDate: Date; var ToDate: Date)
    begin
        FromDate := StartDate;
        ToDate := EndDate;
    end;
    
    local procedure ProcessCustomLedgerEntries(FromDate: Date; ToDate: Date)
    var
        PostCustomCustLedger: Codeunit "Post Custom Cust Ledger";
    begin
        PostCustomCustLedger.ProcessEntriesByDateRange(FromDate, ToDate);
    end;
}