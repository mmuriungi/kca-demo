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
        //Password
        field(50003; "Password"; text[2048])
        {
            DataClassification = ToBeClassified;
        }
        //OTP
        field(50004; "OTP"; text[20])
        {
            DataClassification = ToBeClassified;
        }
        //"Contact Person"
        field(50005; "Contact Person"; text[150])
        {
            DataClassification = ToBeClassified;
        }
        //"Email 2"
        field(50006; "Email 2"; text[150])
        {
            DataClassification = ToBeClassified;
        }
        // /"Telephone 2"
        field(50007; "Telephone 2"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        //"Vendor Categorization"
        field(50008; "Vendor Categorization"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        //"Email 1","Contact Telephone","Agpo Certification No."
        field(50009; "Email 1"; text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Contact Telephone"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Agpo Certification No."; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
