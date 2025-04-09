tableextension 50040 "Marketing Setup Ext" extends "Marketing Setup"
{
    fields
    {
        field(50000; Feedback; Code[20])
        {
            Caption = 'Feedback';
            DataClassification = ToBeClassified;
            TableRelation="No. Series";
        }
    }
}
