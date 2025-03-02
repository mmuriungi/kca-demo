tableextension 50039 "Inventory Setup Extension" extends "Inventory Setup"
{
    fields
    {
        FIELD(50100; "Item Disposal Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Disposal Nos.';
            TableRelation = "No. Series";
        }
    }
}
