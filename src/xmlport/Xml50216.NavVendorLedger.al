xmlport 50216 "Nav Vendor Ledger"
{
    Caption = 'Nav Vendor Ledger Import/Export';
    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(NavVendorLedger; "Nav Vendor Ledger")
            {
                AutoSave = true;
                XmlName = 'NavVendorLedger';
                RequestFilterFields = "Posting Date", "Document No.", "Vendor No.";
                
                fieldelement(EntryNo; NavVendorLedger."Entry No.")
                {
                }
                fieldelement(PostingDate; NavVendorLedger."Posting Date")
                {
                }
                fieldelement(DocumentNo; NavVendorLedger."Document No.")
                {
                }
                fieldelement(VendorNo; NavVendorLedger."Vendor No.")
                {
                }
                fieldelement(Amount; NavVendorLedger."Amount")
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    if NavVendorLedger."Entry No." = 0 then
                        NavVendorLedger."Entry No." := GetNextEntryNo();
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
        NavVendorLedgerRec: Record "Nav Vendor Ledger";
    begin
        if NavVendorLedgerRec.FindLast() then
            exit(NavVendorLedgerRec."Entry No." + 1)
        else
            exit(1);
    end;
}