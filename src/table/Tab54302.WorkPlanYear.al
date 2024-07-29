table 54302 "WorkPlan Year"
{
    Caption = 'WorkPlan Year ';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Workplan Year";
    LookupPageId = "Workplan Year";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Code[20])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
