table 56261 SmsModel
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Phone; Text[100])
        {
            Caption = 'Phone Numbers (comma separated)';
        }
        field(3; Body; Text[1024])
        {
            Caption = 'Message (Short)';
        }
        field(4; Body2; Text[1024])
        {
            Caption = 'Your Message';
        }
        field(5; Group; Option)
        {
            OptionMembers = Staff, Student, "Student List 1", "Student List 2";
            DataClassification = ToBeClassified;
        }
        field(6; Time2; Option)
        {
            Caption = 'Send Time';
             OptionMembers = Now, Later;
            DataClassification = ToBeClassified;
        }
        field(7; Date2; DateTime)
        {
            Caption = 'Select Date';
        }
        field(8; ResponseMessage; Text[1024])
        {
            Caption = 'Response Message';
            Editable = false;
        }
    }

     keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, Phone, Body, Body2)
        {
        }
    }
}