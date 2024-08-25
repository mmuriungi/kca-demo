table 50164 Club
{
    Caption = 'Club';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; "Patron No."; Code[20])
        {
            Caption = 'Patron No.';
            TableRelation = Employee;
        }
        field(5; "Founding Date"; Date)
        {
            Caption = 'Founding Date';
        }
        field(6; "Member Count"; Integer)
        {
            Caption = 'Member Count';
            FieldClass = FlowField;
            CalcFormula = count("Club Member" where("Club Code" = field(Code)));
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Active,Inactive,PendingApproval;
        }
        //Activity Count
        field(8; "Activity Count"; Integer)
        {
            Caption = 'Activity Count';
            FieldClass = FlowField;
            CalcFormula = count("Club/Society Activity" where("Club/Society Code" = field(Code)));
        }
        //"Date Filter"
        field(9; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            fieldclass = flowfilter;
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