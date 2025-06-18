xmlport 50021 "General Ledger Export"

{
    Caption = 'General Ledger Export';
    Direction = Export;
    Format = VariableText;
    FieldSeparator = '<TAB>';
    
    schema
    {
        textelement(Root)
        {
            tableelement(GLEntry; "G/L Entry custom")
            {
                XmlName = 'GLEntry';
                
                fieldelement(DocumentNo; GLEntry."Document No.")
                {
                }
                fieldelement(PostingDate; GLEntry."Posting Date")
                {
                }
                fieldelement(GLAccountNo; GLEntry."G/L Account No.")
                {
                }
                fieldelement(Description; GLEntry.Description)
                {
                }
                fieldelement(Amount; GLEntry.Amount)
                {
                }
                fieldelement(TotalAmount; GLEntry.Totalamount)
                {
                }
                fieldelement(Reversed; GLEntry.Reversed)
                {
                }
                fieldelement(LedgerAmount; GLEntry."Ledger Amount")
                {
                }
                fieldelement(SourceNo; GLEntry."Source No.")
                {
                }
                fieldelement(SourceType; GLEntry."Source Type")
                {
                }
                fieldelement(EntryCount; GLEntry.EntryCount)
                {
                }
                fieldelement(SystemCreatedEntry; GLEntry."System-Created Entry")
                {
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
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the start date for the posting date filter.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the end date for the posting date filter.';
                    }
                }
            }
        }
    }
    
    trigger OnPreXmlPort()
    begin
        if (StartDate <> 0D) or (EndDate <> 0D) then begin
            if StartDate <> 0D then
                GLEntry.SetFilter("Posting Date", '>=%1', StartDate);
            if EndDate <> 0D then
                GLEntry.SetFilter("Posting Date", '..%1', EndDate);
            if (StartDate <> 0D) and (EndDate <> 0D) then
                GLEntry.SetRange("Posting Date", StartDate, EndDate);
        end;
    end;
    
    var
        StartDate: Date;
        EndDate: Date;
}