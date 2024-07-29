tableextension 56608 "Base Calendar Change Ext" extends "Base Calendar Change"
{
    fields
    {
        // Add changes to table fields here
         field(56601; "Date Day"; Integer)
        {
            Caption = 'Day Date';
            DataClassification = ToBeClassified;
        }
        field(56602; "Date Month"; Integer)
        {
            Caption = 'Month Date';
            DataClassification = ToBeClassified;
        }
    }
    
    var
        myInt: Integer;
}