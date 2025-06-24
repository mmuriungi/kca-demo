xmlport 50219 "BC GL Ledger"
{
    Caption = 'BC GL Ledger Import/Export';
    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF8;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(BCGLLedger; "BC GL Ledger")
            {
                AutoSave = true;
                XmlName = 'BCGLLedger';
                RequestFilterFields = "Posting Date", "Document No.";
                
                fieldelement(EntryNo; BCGLLedger."Entry No.")
                {
                }
                fieldelement(PostingDate; BCGLLedger."Posting Date")
                {
                }
                fieldelement(DocumentNo; BCGLLedger."Document No.")
                {
                }
                fieldelement(AccountNo; BCGLLedger."Account No.")
                {
                }
                fieldelement(Amount; BCGLLedger."Amount")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    if BCGLLedger."Entry No." = 0 then
                        BCGLLedger."Entry No." := GetNextEntryNo();
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
        BCGLLedgerRec: Record "BC GL Ledger";
    begin
        if BCGLLedgerRec.FindLast() then
            exit(BCGLLedgerRec."Entry No." + 1)
        else
            exit(1);
    end;
}