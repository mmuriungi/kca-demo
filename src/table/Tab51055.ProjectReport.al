table 51055 "Project Report"
{
    Caption = 'Project Report';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Report Code"; Code[40])
        {
            Caption = 'Report Code';
        }
        field(2; "Reporting Date "; Date)
        {
            Caption = 'Reporting Date ';
        }
        field(3; "Reporting  month"; Code[60])
        {
            Caption = 'Reporting  month';
        }
        field(4; "Report description"; Text[100])
        {
            Caption = 'Report description';
        }
    }
    keys
    {
        key(PK; "Report Code")
        {
            Clustered = true;
        }
    }
}
