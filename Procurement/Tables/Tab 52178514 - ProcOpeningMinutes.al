table 52178514 "Proc-Opening Minutes"
{
    DrillDownPageId = "Proc-Opening Minutes";
    Caption = 'Proc-Opening Minutes';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
        }
        field(2; "Procurement Method"; Enum "Proc-Procurement Methods")
        {
            Caption = 'Procurement Method';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(4; "Minutes No"; Code[50])
        {
            Caption = 'Minutes No';
        }
        field(5; "Created By"; Code[50])
        {

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
