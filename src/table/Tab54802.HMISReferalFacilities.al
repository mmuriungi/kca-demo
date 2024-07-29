table 54802 "HMIS-Referal Facilities"
{
    DrillDownPageID = "HMIS-Referal Facilities List";
    LookupPageID = "HMIS-Referal Facilities List";

    fields
    {
        field(1; "Facility Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Contact Person"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Contact Phone"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Contact Mail"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Facility Name")
        {
        }
    }

    fieldgroups
    {
    }
}

