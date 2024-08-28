table 51078 AllSpecimentList
{
    Caption = 'AllSpecimentList';
    DataClassification = ToBeClassified;
    LookupPageId = AllSpecimentList;
    DrillDownPageId = AllSpecimentList;
    fields
    {

        field(1; "specimen code"; Code[30])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMS-Setup Lab Test".Code;
        }

        field(2; "Lab Test"; Code[60])
        {
            DataClassification = ToBeClassified;

        }

        field(3; "Specimen Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Lab Test Description"; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Result"; Code[60])
        {
            DataClassification = ToBeClassified;


        }
        field(6; unit; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Minimum Value"; Decimal)
        {
        }
        field(7; "Maximum Value"; Decimal)
        {
        }
        field(8; Flag; code[60])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Lab Test", "specimen code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}