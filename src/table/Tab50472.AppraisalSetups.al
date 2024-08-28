/// <summary>
/// Table Appraisal Setups (ID 50040).
/// </summary>
table 50472 "Appraisal Setups"
{
    Caption = 'Appraisal Setups';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Pk; code[20])
        {

        }
        field(2; "Appraisal No"; Code[20])
        {
            Caption = 'Appraisal No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }

        field(3; "Max Score"; Integer)
        {
            Caption = 'Max Score';
            DataClassification = ToBeClassified;
        }



    }
    keys
    {


    }
}
