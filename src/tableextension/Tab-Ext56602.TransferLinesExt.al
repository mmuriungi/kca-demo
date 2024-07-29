tableextension 56602 "Transfer Lines Ext" extends "Transfer Line"
{
    fields
    {
        field(56601; "Quantity In Store"; Decimal)
        {
            Caption = 'Quantity In Store';
        }

        modify("Item No.")
        {
            Caption = 'Item No';


            trigger OnAfterValidate()

            begin


                ItemLedgerEnty.RESET;
                ItemLedgerEnty.SETRANGE("Item No.", "Item No.");
                ItemLedgerEnty.SETRANGE("Location Code", "Transfer-from Code");
                IF ItemLedgerEnty.FIND('-') THEN BEGIN
                    ItemLedgerEnty.CalcSums(Quantity);
                    "Quantity In Store" := ItemLedgerEnty.Quantity;
                    Validate("Quantity In Store");
                END;
            end;
        }
    }
    var
        ItemLedgerEnty: Record "Item Ledger Entry";
}
