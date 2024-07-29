tableextension 50015 Vendors extends Vendor
{
    fields
    {
        field(50000; "Requisition Default Vendor"; Boolean)
        {
            Caption = 'Requisition Default Vendor';
            DataClassification = ToBeClassified;
        }
        field(50001; "Kra Pin"; text[50])
        {

        }
        field(50002; "Bank Account No"; code[30])
        {

        }
    }
}
