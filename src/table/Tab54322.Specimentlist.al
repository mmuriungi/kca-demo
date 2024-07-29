table 54322 "Speciment  list"
{


    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Lab Test"; Code[60])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "specimen code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Specimen Name"; Code[60])
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
        field(7; "Normal Range"; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Flag; code[60])
        {
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Lab Test")
        {
            Clustered = true;
        }
    }
}
