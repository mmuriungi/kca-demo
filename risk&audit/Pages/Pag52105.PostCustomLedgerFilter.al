page 52105 "Post Custom Ledger Filter"
{
    PageType = StandardDialog;
    Caption = 'Filter Date Range';

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
}