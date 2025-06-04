xmlport 50020 "Export Custom Cust Ledger"
{

    Caption = 'Export Custom Customer Ledger';
    Direction = Export;
    Format = VariableText;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(DetailedCustLedgerCustom; "Detailed Cust ledger Custom")
            {
                textelement(DocumentNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DocumentNo := DetailedCustLedgerCustom."Document No.";
                    end;
                }

                textelement(CustomerNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerNo := DetailedCustLedgerCustom."Customer No.";
                    end;
                }

                textelement(PostingDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PostingDate := Format(DetailedCustLedgerCustom."Posting Date");
                    end;
                }

                textelement(Amount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Amount := Format(DetailedCustLedgerCustom.Amount);
                    end;
                }

                textelement(EntryType)
                {
                    trigger OnBeforePassVariable()
                    begin
                        EntryType := Format(DetailedCustLedgerCustom."Entry Type");
                    end;
                }

                textelement(Description)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Description := DetailedCustLedgerCustom.Description;
                    end;
                }

                textelement(Posted)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Posted := Format(DetailedCustLedgerCustom.Posted);
                    end;
                }

                textelement(EntryAmount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        EntryAmount := Format(DetailedCustLedgerCustom."Entry Amount");
                    end;
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(DateFilters)
                {
                    Caption = 'Date Filters';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Enter the start date for the posting date filter';
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Enter the end date for the posting date filter';
                    }
                }

                group(Options)
                {
                    Caption = 'Options';

                    field(IncludeHeaders; IncludeHeaders)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Headers';
                        ToolTip = 'Include column headers in the export';
                    }

                    field(OnlyUnposted; OnlyUnposted)
                    {
                        ApplicationArea = All;
                        Caption = 'Only Unposted';
                        ToolTip = 'Export only unposted entries (Posted = No)';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            // Set default dates
            if StartDate = 0D then
                StartDate := CalcDate('<-1M>', Today());
            if EndDate = 0D then
                EndDate := Today();
        end;
    }

    trigger OnPreXmlPort()
    begin
        // Always filter for Initial Entry (same as your page)
        DetailedCustLedgerCustom.SetRange("Entry Type", DetailedCustLedgerCustom."Entry Type"::"Initial Entry");

        // Apply date filters
        if (StartDate <> 0D) and (EndDate <> 0D) then
            DetailedCustLedgerCustom.SetRange("Posting Date", StartDate, EndDate)
        else if StartDate <> 0D then
            DetailedCustLedgerCustom.SetFilter("Posting Date", '>=%1', StartDate)
        else if EndDate <> 0D then
            DetailedCustLedgerCustom.SetFilter("Posting Date", '<=%1', EndDate);

        // Apply Posted filter if requested
        if OnlyUnposted then
            DetailedCustLedgerCustom.SetRange(Posted, false);

        // Write headers if requested and this is the first record
        if IncludeHeaders then begin
            WriteHeaders();
            FirstRecord := false;
        end;
    end;

    local procedure WriteHeaders()
    begin
        DocumentNo := 'Document No.';
        CustomerNo := 'Customer No.';
        PostingDate := 'Posting Date';
        Amount := 'Amount';
        EntryType := 'Entry Type';
        Description := 'Description';
        Posted := 'Posted';
        EntryAmount := 'Entry Amount';
    end;

    var
        StartDate: Date;
        EndDate: Date;
        IncludeHeaders: Boolean;
        OnlyUnposted: Boolean;
        FirstRecord: Boolean;
}