table 52178513 "Proc-Post Qualification"
{
    DrillDownPageId = "Proc-Post Qualification";
    Caption = 'Proc-Post Qualification';
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
        field(3; "Date Conducted"; Date)
        {

        }
        field(4; Findings; Text[2048])
        {

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
