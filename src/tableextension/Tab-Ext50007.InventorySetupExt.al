tableextension 50007 "Inventory Setup Ext" extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Item Issue Batch"; code[20])
        {

        }
        field(56602; "Item Issue Template"; code[20])
        {

        }
    }

    var
        myInt: Integer;
}