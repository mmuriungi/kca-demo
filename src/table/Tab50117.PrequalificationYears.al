table 50117 "Prequalification Years"
{
    Caption = 'Prequalification Years';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Preq Years"; Code[20])
        {
            Caption = 'Preq Years';
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(3; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(4; "Preq Categories"; Integer)
        {
            Caption = 'Preq Categories';
        }
        field(5; "Preq Date List"; Integer)
        {
            Caption = 'Preq Date List';
        }
    }
    keys
    {
        key(PK; "Preq Years")
        {
            Clustered = true;
        }
    }
}
