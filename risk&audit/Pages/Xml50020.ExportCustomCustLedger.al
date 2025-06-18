xmlport 50020 "Export Custom Cust Ledger"
{
    Caption = 'Export CustomDetailed Customer Ledgers';
    Direction = Export;
    Format = VariableText;
    UseRequestPage = true;

    schema
    {
        textelement(CustomerLedgerEntries)
        {
            tableelement(DetailedCustLedgerCustom; "Detailed Cust ledger Custom")
            {
                SourceTableView = sorting("Posting Date", "Customer No.", "Document No.")
                                where("Entry Type" = const("Initial Entry"));

                // Consolidated field elements with proper naming
                fieldelement(DocumentNo; DetailedCustLedgerCustom."Document No.") { }
                fieldelement(CustomerNo; DetailedCustLedgerCustom."Customer No.") { }
                fieldelement(PostingDate; DetailedCustLedgerCustom."Posting Date") { }
                fieldelement(Amount; DetailedCustLedgerCustom.Amount) { }
                //fieldelement(TotalAmount; DetailedCustLedgerCustom."Total Amount") { }
                // fieldelement(EntryAmount; DetailedCustLedgerCustom."Entry Amount") { }
                // fieldelement(EntryType; DetailedCustLedgerCustom."Entry Type") { }
                fieldelement(Description; DetailedCustLedgerCustom.Description) { }
                fieldelement(Posted; DetailedCustLedgerCustom.Posted) { }
                fieldelement(Custom_Amount; DetailedCustLedgerCustom."Custom Amount") { }
                fieldelement(ledger_Amount; DetailedCustLedgerCustom."Ledger Amount") { }


                trigger OnPreXMLItem()
                begin
                    // Apply date filter if specified
                    if StartDate <> 0D then
                        DetailedCustLedgerCustom.SetRange("Posting Date", StartDate, EndDate);
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilter)
                {
                    Caption = 'Date Filter';

                    field(StartDateField; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Start date for the posting date filter.';
                    }
                    field(EndDateField; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'End date for the posting date filter.';
                    }
                }
                group(Options)
                {
                    Caption = 'Export Options';

                    field(IncludeHeaderField; IncludeHeader)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Header';
                        ToolTip = 'Include column headers in the export.';
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        IncludeHeader: Boolean;

    trigger OnInitXMLport()
    begin
        StartDate := CalcDate('-1M', Today);
        EndDate := Today;
        IncludeHeader := true;
    end;

    trigger OnPreXMLport()
    begin
        // Validate date range
        if StartDate = 0D then
            Error('Start Date must be specified.');
        if EndDate = 0D then
            Error('End Date must be specified.');
        if StartDate > EndDate then
            Error('Start Date cannot be later than End Date.');
    end;
}