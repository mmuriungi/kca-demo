xmlport 50020 "Export Custom Cust Ledger"

{
    Caption = 'Export Custom Detailed Customer Ledgers';
    Direction = Export;
    Format = Xml;
    UseRequestPage = true;

    schema
    {
        textelement(CustomerLedgerEntries)
        {
            tableelement(DetailedCustLedgerCustom; "Detailed Cust ledger Custom")
            {
                SourceTableView = sorting("Posting Date") where("Entry Type" = const("Initial Entry"));

                fieldelement(DocumentNo; DetailedCustLedgerCustom."Document No.")
                {
                }
                fieldelement(CustomerNo; DetailedCustLedgerCustom."Customer No.")
                {
                }
                fieldelement(PostingDate; DetailedCustLedgerCustom."Posting Date")
                {
                }
                fieldelement(Amount; DetailedCustLedgerCustom.Amount)
                {
                }
                fieldelement(EntryType; DetailedCustLedgerCustom."Entry Type")
                {
                }
                fieldelement(Description; DetailedCustLedgerCustom.Description)
                {
                }
                fieldelement(Posted; DetailedCustLedgerCustom.Posted)
                {
                }
                fieldelement(EntryAmount; DetailedCustLedgerCustom."Entry Amount")
                {
                }

                trigger OnPreXMLItem()
                begin
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
                        ToolTip = 'Specifies the start date for the posting date filter.';
                    }
                    field(EndDateField; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the end date for the posting date filter.';
                    }
                }
                group(Options)
                {
                    Caption = 'Export Options';
                    field(IncludeHeaderField; IncludeHeader)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Header';
                        ToolTip = 'Specifies whether to include column headers in the export.';
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
        if StartDate = 0D then
            Error('Start Date must be specified.');
        if EndDate = 0D then
            Error('End Date must be specified.');
        if StartDate > EndDate then
            Error('Start Date cannot be later than End Date.');
    end;
}