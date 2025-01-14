tableextension 50034 "Approval Entry Ext" extends "Approval Entry"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Approved The Document"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56602; "Last Modified By ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}