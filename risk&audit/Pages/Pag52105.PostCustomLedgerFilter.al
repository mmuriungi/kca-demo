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
                InstructionalText = 'Select the date range for processing entries. The default range covers the last month, but you can adjust it as needed.';
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
        // Set default range to cover the last month
        EndDate := WorkDate();
        StartDate := CalcDate('<-1M>', EndDate);
    end;

    procedure GetDateFilter(var FromDate: Date; var ToDate: Date)
    begin
        FromDate := StartDate;
        ToDate := EndDate;
    end;
}