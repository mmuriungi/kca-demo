table 51289 "PostGraduate Setup"
{
    Caption = 'PostGraduate Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; Code[10])
        {
            Caption = 'Pk';
        }
        field(2; "Check Student "; Boolean)
        {
            Caption = 'Check Student ';
        }
        field(3; "Min. Supervisor Applic Fees"; Decimal)
        {
            Caption = 'Min. Supervisor Applic Fees';
        }
        field(4; "Supervisor Assignment Nos."; Code[20])
        {
            Caption = 'Supervisor Assignment Nos.';
            TableRelation = "No. Series";
        }
        field(5; "Submission Nos"; Code[20])
        {
            Caption = 'Submission Nos';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; Pk)
        {
            Clustered = true;
        }
    }
}
