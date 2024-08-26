table 50703 "Research Publications"
{
    Caption = 'Research Publications';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; Code[20])
        {
            Caption = '';
        }
        field(2; "Title of Publication"; Text[100])
        {

        }
        field(3; Status; Option)
        {
            OptionMembers = " ","In Progress",Published;
        }
        field(4; "Journal Published"; Text[100])
        {

        }
        field(5; Authors; Text[100])
        {

        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
}
