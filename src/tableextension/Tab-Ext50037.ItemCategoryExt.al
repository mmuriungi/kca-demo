tableextension 50037 "Item Category Ext" extends "Item Category"
{
    fields
    {
        field(50000; "Item Category Type"; Enum "Item Category")
        {
            Caption = 'Item Category Type';
            DataClassification = ToBeClassified;
        }
    }
}
