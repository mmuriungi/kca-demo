tableextension 50020 "Budget NameExt" extends "G/L Budget Name"
{
    fields
    {
        field(50000; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
        }
    }
}
