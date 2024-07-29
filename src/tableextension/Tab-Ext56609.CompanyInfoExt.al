tableextension 56609 "Company Info Ext" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
         field(56601; "Company P.I.N"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    var
        myInt: Integer;
}