table 52178729 "Proc-Quotation Request Vendors"
{
    DrillDownPageId = "Quotation Request Vendors";
    LookupPageId = "Quotation Request Vendors";
    fields
    {
        field(1; "Document Type"; Enum "Proc-Procurement Methods")
        {

        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
        }
        field(4; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(5; "Expected Closing Date"; Date)
        {

        }
        field(6; "Email"; Text[100])
        {

        }
        field(7; "Prequalification Period"; Code[30])
        {

        }
        field(8; "Telephone No."; Text[100])
        {

        }

    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}