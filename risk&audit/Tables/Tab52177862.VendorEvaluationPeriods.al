table 50158 "Vendor Evaluation Periods"
{
    Caption = 'Vendor Evaluation Periods';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Start date"; Date)
        {
            Caption = 'Start date';
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }
        field(4; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                VendorEv: Record "Vendor Evaluation Periods";
            begin
                VendorEv.reset;
                VendorEv.SetFilter(Code, '<>%1', Code);
                VendorEv.SetRange(Active, true);
                if VendorEv.Find('-') then
                    repeat
                        VendorEv.Active := false;
                        VendorEv.Modify();
                    until VendorEv.Next() = 0;
            end;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}
