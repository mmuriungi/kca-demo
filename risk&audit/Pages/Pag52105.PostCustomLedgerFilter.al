page 52105 "Post Custom Ledger Filter"
{

    PageType = StandardDialog;
    Caption = 'Filter Date Range';

    layout
    {
        area(Content)
        {
            group(Instructions)
            {
                Caption = 'Instructions';
                InstructionalText = 'Select the date range for processing unposted entries. Records from 2019 are in the system.';
            }
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

    var
        StartDate: Date;
        EndDate: Date;

    trigger OnOpenPage()
    begin
        // Set default range to include 2019 dates
        StartDate := DMY2Date(1, 1, 2019);
        EndDate := DMY2Date(31, 12, 2019);
    end;

    procedure GetDateFilter(var FromDate: Date; var ToDate: Date)
    begin
        FromDate := StartDate;
        ToDate := EndDate;
    end;

    procedure ProcessRecords()
    var
        PostCustLedger: Codeunit "Post Custom Cust Ledger";
    begin
        // Call the codeunit with the date range
        PostCustLedger.ProcessEntriesByDateRange(StartDate, EndDate);
    end;
}