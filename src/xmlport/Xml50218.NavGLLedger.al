xmlport 50218 "Nav GL Ledger"
{
    Caption = 'Nav GL Ledger Import/Export';
    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF8;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(NavGLLedger; "Nav GL Ledger")
            {
                AutoSave = true;
                XmlName = 'NavGLLedger';
                RequestFilterFields = "Posting Date", "Document No.";
                
                fieldelement(EntryNo; NavGLLedger."Entry No.")
                {
                }
                fieldelement(PostingDate; NavGLLedger."Posting Date")
                {
                }
                fieldelement(DocumentNo; NavGLLedger."Document No.")
                {
                }
                fieldelement(AccountNo; NavGLLedger."Account No.")
                {
                }
                fieldelement(Amount; NavGLLedger."Amount")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    if NavGLLedger."Entry No." = 0 then
                        NavGLLedger."Entry No." := GetNextEntryNo();
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }
    }

    local procedure GetNextEntryNo(): Integer
    var
        NavGLLedgerRec: Record "Nav GL Ledger";
    begin
        if NavGLLedgerRec.FindLast() then
            exit(NavGLLedgerRec."Entry No." + 1)
        else
            exit(1);
    end;
}