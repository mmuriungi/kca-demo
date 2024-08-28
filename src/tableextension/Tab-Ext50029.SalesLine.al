tableextension 50029 SalesLine extends "Sales Line"
{
    fields
    {
        field(80000; "Sales Location Category"; Option)
        {

            OptionMembers = " ",Staff,Students;
            OptionCaption = ' ,Staff,Students';
            Caption = 'Sales Location Category';
            DataClassification = ToBeClassified;
        }
    }

}