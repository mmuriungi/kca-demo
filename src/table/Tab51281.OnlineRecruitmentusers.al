table 51281 "Online Recruitment users"
{
    Caption = 'Online Recruitment users';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Initials; Option)
        {
            Caption = 'Initials';
            OptionMembers = " ",Mr,Mrs,Ms,Dr,Prof; // Customize as needed
        }
        field(2; "First Name"; Text[100])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[100])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
        }
        field(5; "Postal Address"; Text[100])
        {
            Caption = 'Postal Address';
        }
        field(6; "Postal Code"; Code[30])
        {
            Caption = 'Postal Code';
        }
        field(7; "ID Number"; Text[30])
        {
            Caption = 'ID Number';
        }
        field(8; Gender; Option)
        {
            Caption = 'Gender';
            OptionMembers = " ",Male,Female,Other;
        }
        field(9; "Cell Phone Number"; Code[50])
        {
            Caption = 'Cell Phone Number';
        }
        field(10; "Home Phone Number"; Code[50])
        {
            Caption = 'Home Phone Number';
        }
        field(11; "Residential Address"; Text[150])
        {
            Caption = 'Residential Address';
        }
        field(12; Citizenship; Text[100])
        {
            Caption = 'Citizenship';
        }
        field(13; County; Text[50])
        {
            Caption = 'County';
        }
        field(14; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            OptionMembers = " ",Single,Married,Divorced,Widowed;
        }
        field(15; "Ethnic Group"; Text[50])
        {
            Caption = 'Ethnic Group';
        }
        field(16; Disabled; Option)
        {
            Caption = 'Disabled';
            OptionMembers = " ",Yes,No;
        }
        field(17; "Disability Details"; Text[100])
        {
            Caption = 'Disability Details';
        }
        field(18; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(19; "Driving License"; Text[50])
        {
            Caption = 'Driving License';
        }
        field(20; "KRA PIN Number"; Text[30])
        {
            Caption = 'KRA PIN Number';
        }
        field(21; "1st Language"; Code[50])
        {
            Caption = '1st Language';
        }
        field(22; "2nd Language"; Code[50])
        {
            Caption = '2nd Language';
        }
        field(23; "Additional Language"; Code[50])
        {
            Caption = 'Additional Language';
        }
        field(24; "Applicant Type"; Option)
        {
            Caption = 'Applicant Type';
            OptionMembers = " ",Student,Staff,Other; // Customize as needed
        }
        field(25; "Email Address"; Text[50])
        {
            Caption = 'Email Address';
        }
        field(26; Password; Text[50])
        {
            Caption = 'Password';
        }
        field(27; "Created Date"; Date)
        {
            Caption = 'Created Date';
        }
        field(28; "PWD Number"; Text[50])
        {
            Caption = 'PWD Number';
        }
        field(29; "Activation Code"; Code[10])
        {
            Caption = 'Activation Code';
        }
        field(30; Activated; Boolean)
        {
            Caption = 'Activated';
        }
    }

    keys
    {
        key(PK; "Email Address", "ID Number")
        {
            Clustered = true;
        }
        key(EY; "Email Address")
        {
        }
    }
}
