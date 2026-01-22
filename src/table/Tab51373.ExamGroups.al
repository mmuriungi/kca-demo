table 51376 "Exam Groups"
{
    Caption = 'Exam Groups';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(4; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Year Filter"; Text[50])
        {
            Caption = 'Year Filter';
        }
        field(8; "School Filter"; Text[250])
        {
            Caption = 'School Filter';
        }
        field(9; "Programme Filter"; Text[250])
        {
            Caption = 'Programme Filter';
        }
        field(10; "Exclude Years"; Boolean)
        {
            Caption = 'Exclude Years';
        }
        field(11; "Exclude Schools"; Boolean)
        {
            Caption = 'Exclude Schools';
        }
        field(12; "Exclude Programmes"; Boolean)
        {
            Caption = 'Exclude Programmes';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}