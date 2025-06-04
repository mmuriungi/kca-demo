xmlport 50020 "Export Custom Cust Ledger"
{
 
    Caption = 'Export Custom Customer Ledger';
    Direction = Export;
    Format = VariableText;
    FormatEvaluate = Legacy;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(DetailedCustLedgerCustom; "Detailed Cust ledger Custom")
            {
                RequestFilterFields = "Posting Date", "Entry Type", Posted;
                SourceTableView = sorting("Posting Date") where("Entry Type" = const("Initial Entry"), Posted = const(false));

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
                group(Options)
                {
                    Caption = 'Export Options';
                    
                    field(IncludeHeaders; IncludeHeaders)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Column Headers';
                        ToolTip = 'Include column headers in the export file.';
                    }
                }
                group(Filters)
                {
                    Caption = 'Filters';
                    
                    field(PostingDateFilter; PostingDateFilterText)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date Filter';
                        ToolTip = 'Specify date range for posting date (e.g., 01/01/2024..12/31/2024)';
                        
                        trigger OnValidate()
                        begin
                            if PostingDateFilterText <> '' then
                                DetailedCustLedgerCustom.SetFilter("Posting Date", PostingDateFilterText);
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        // Set default filters
        DetailedCustLedgerCustom.SetRange("Entry Type", DetailedCustLedgerCustom."Entry Type"::"Initial Entry");
        DetailedCustLedgerCustom.SetRange(Posted, false);
        
        // Apply posting date filter if specified
        if PostingDateFilterText <> '' then
            DetailedCustLedgerCustom.SetFilter("Posting Date", PostingDateFilterText);
            
        // Add headers if requested
        if IncludeHeaders then
            WriteHeaders();
    end;

    trigger OnPostXmlPort()
    begin
        Message('Export completed successfully.');
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
        IncludeHeaders: Boolean;
        PostingDateFilterText: Text[50];
}