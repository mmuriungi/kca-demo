tableextension 50004 "G/L Account Ext" extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(56601; "Budget Controlled"; Boolean)
        {

        }
        field(56602; "Date Filters"; Date)
        {
            Caption = 'Date Filters';
            FieldClass = FlowFilter;

            TableRelation = "G/L Entry" where("Posting Date" = FIELD("Date Filter"));




        }
    }

    var
        myInt: Integer;
}