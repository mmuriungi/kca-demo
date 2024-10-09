table 51281 "Online Recruitment users"
{
    Caption = 'Online Recruitment users';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Initials; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Mr,Mrs,Miss;
        }
        field(2; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Postal Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Postal Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "ID Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Male,Female;
        }
        field(9; "Cell Phone Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Home Phone Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Residential Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Citizenship; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; County; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(15; "Ethnic Origin"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = African,Indian,White,Coloured;
        }
        field(16; Disabled; Option)
        {
            OptionMembers = No,Yes," ";
            DataClassification = ToBeClassified;
        }
        field(17; "Disability Details"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Driving License"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "KRA PIN Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "1st Language"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "2nd Language"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Additional Language"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Applicant Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = External,Internals;
        }
        field(25; "Email Address"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(26; Password; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Ethnic Group"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "PWD Number"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "SessionKey"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Account Confirmed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Details Updated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Passport No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Religion"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Denomination"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Email Address")
        {
        }
    }

    fieldgroups
    {
    }
}
