xmlport 50217 "BC Vendor Ledger"
{
    Caption = 'BC Vendor Ledger Import/Export';
    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF8;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(BCVendorLedger; "BC Vendor Ledger")
            {
                AutoSave = true;
                XmlName = 'BCVendorLedger';
                RequestFilterFields = "Posting Date", "Document No.";

                fieldelement(EntryNo; BCVendorLedger."Entry No.")
                {
                }
                fieldelement(PostingDate; BCVendorLedger."Posting Date")
                {
                }
                fieldelement(DocumentNo; BCVendorLedger."Document No.")
                {
                }
                fieldelement(VendorNo; BCVendorLedger."Vendor No.")
                {
                }
                fieldelement(Amount; BCVendorLedger."Amount")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    if BCVendorLedger."Entry No." = 0 then
                        BCVendorLedger."Entry No." := GetNextEntryNo();
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
        BCVendorLedgerRec: Record "BC Vendor Ledger";
    begin
        if BCVendorLedgerRec.FindLast() then
            exit(BCVendorLedgerRec."Entry No." + 1)
        else
            exit(1);
    end;
}