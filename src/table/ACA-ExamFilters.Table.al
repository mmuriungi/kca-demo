table 78041 "ACA-Exam Filters"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "UserID/Name"; Code[20])
        {
            Caption = 'UserID/Name';
            DataClassification = CustomerContent;
        }
        field(2; "Program Filter"; Code[20])
        {
            Caption = 'Program Filter';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(4; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
            DataClassification = CustomerContent;
        }
        field(5; "Programme Option Filter"; Code[20])
        {
            Caption = 'Programme Option Filter';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "UserID/Name")
        {
            Clustered = true;
        }
    }
}