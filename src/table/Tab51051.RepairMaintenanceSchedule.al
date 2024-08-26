table 51051 "Repair Maintenance  Schedule"
{
    Caption = 'Repair Maintenance  Schedule';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Reg No"; Code[40])
        {
            Caption = 'Reg No';
        }
        field(2; Make; Code[60])
        {
            Caption = 'Make';
        }
        field(3; Milleage; Code[60])
        {
            Caption = 'Milleage';
        }
        field(4; "Nature Of Repair"; Code[60])
        {
            Caption = 'Nature Of Repair';
        }
        field(5; "Date Of Repair"; Code[60])
        {
            Caption = 'Date Of Repair';
        }
        field(6; "Amount "; Code[60])
        {
            Caption = 'Amount ';
        }
        field(7; "Comments By TO"; Code[60])
        {
            Caption = 'Comments By TO';
        }
    }
    keys
    {
        key(PK; "Reg No")
        {
            Clustered = true;
        }
    }
}
