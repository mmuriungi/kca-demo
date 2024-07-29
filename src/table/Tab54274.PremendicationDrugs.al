table 54274 "Premendication Drugs"
{
    fields
    {
        field(1; "No."; integer)
        {
            AutoIncrement = true;

        }
        field(2; "Treatment No."; code[30])
        {

        }
        field(3; "Description"; Text[100])
        {

        }
        field(4; "Dosage"; Text[50])
        {

        }
        field(5; "No. of Days taken"; Text[100])
        {

        }
        field(6; "Prescribed by"; Option)
        {
            OptionMembers = Self,Pharmacist,"Nurse/Clinician/Doctor";
        }
        field(7; "Remarks"; Text[200])
        {

        }


    }
    keys
    {
        key(key1; "No.", "Treatment No.")
        {

        }
    }

}