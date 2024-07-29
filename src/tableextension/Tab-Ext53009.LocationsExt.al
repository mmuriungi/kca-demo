tableextension 53009 LocationsExt extends Location
{
    fields
    {
        field(88000; "Cafeteria Location Category"; Option)
        {
            OptionCaption = ' ,Staff,Students';
            OptionMembers = " ",Staff,Students;
            DataClassification = ToBeClassified;

        }
        field(88001; "Campus Code"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        // field(88002; "Cafeteria Location";Boolean)
        // {
        //     DataClassification = ToBeClassified;

        // }
    }

}