table 51312 "HRM-Calendar"
{
    Caption = 'HRM-Calendar';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Year; Code[20])
        {
            Caption = 'Year';
        }
        field(2; Starts; Date)
        {
            Caption = 'Starts';
        }
        field(3; Ends; Date)
        {
            Caption = 'Ends';
        }
        field(4; Current; Boolean)
        {
            Caption = 'Current';
        }
    }
    keys
    {
        key(PK; Year)
        {
            Clustered = true;
        }
    }
}
