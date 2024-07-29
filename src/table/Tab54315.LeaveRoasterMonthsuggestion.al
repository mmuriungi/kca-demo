
table 54315 "Leave RoasterMonth suggestion"
{
    Caption = ' Leave RoasterMonth suggestion';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Staff Code"; Code[30])
        {
        }
        field(2; "Staff ID"; Code[30])
        {
        }
        field(7; "proposed no of days"; integer)
        {

        }
        field(3; "Suggestion No"; Integer)
        {

            AutoIncrement = true;
        }
        field(4; "leave Month"; Option)
        {
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(5; "Purpose"; Text[250])
        {
        }
        field(6; Priority; Boolean)
        {
        }
        field(8; "Leave Roaster No."; Code[30])
        {
        }

    }

    keys
    {
        key(Key1; "Leave Roaster No.", "Staff Code", "Staff ID", "Suggestion No")
        {
        }
    }

    fieldgroups
    {
    }
}

