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
                // fieldelement(TotalAmount; DetailedCustLedgerCustom."Total Amount") { }
                // fieldelement(EntryAmount; DetailedCustLedgerCustom."Entry Amount") { }
                //fieldelement(EntryType; DetailedCustLedgerCustom."Entry Type") { }
                fieldelement(Description; DetailedCustLedgerCustom.Description) { }
                // fieldelement(Posted; DetailedCustLedgerCustom.Posted) { }
                fieldelement(LedgerAmount; DetailedCustLedgerCustom."Total Amount") { }
                fieldelement(EntryAmount1; DetailedCustLedgerCustom."Entry Amount") { }

                trigger OnPreXMLItem()
                begin
                    // Apply date filter if specified
                    if StartDate <> 0D then
                        DetailedCustLedgerCustom.SetRange("Posting Date", StartDate, EndDate);

                    // Apply customer filter if specified
                    if CustomerNoFilter <> '' then
                        DetailedCustLedgerCustom.SetFilter("Customer No.", CustomerNoFilter);
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
                group(CustomerFilter)
                {
                    Caption = 'Customer Filter';

                    field(CustomerNoFilterField; CustomerNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No. Filter';
                        ToolTip = 'Filter for specific customer numbers. Use standard filter syntax (e.g., C001|C002 for multiple customers, C001..C010 for range).';
                        TableRelation = Customer."No.";

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Customer: Record Customer;
                            CustomerList: Page "Customer List";
                        begin
                            Customer.Reset();
                            CustomerList.SetTableView(Customer);
                            CustomerList.LookupMode(true);
                            if CustomerList.RunModal() = Action::OK then begin
                                CustomerList.GetRecord(Customer);
                                Text := Customer."No.";
                                exit(true);
                            end;
                            exit(false);
                        end;
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
        CustomerNoFilter: Text;

    trigger OnInitXMLport()
    begin
        StartDate := CalcDate('-1M', Today);
        EndDate := Today;
        IncludeHeader := true;
        CustomerNoFilter := '';
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