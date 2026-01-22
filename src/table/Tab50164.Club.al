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
            TableRelation = "HRM-Employee C";
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
            OptionMembers = " ",Active,Inactive,PendingApproval;
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
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(11; "Approval Status"; enum "Custom Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        clubsetup.Get();
        ClubSetup.TestField("Club/Society Nos");
        NoseriesMgmt.InitSeries(clubsetup."Club/Society Nos", xRec."No. Series", 0D, Rec."Code", Rec."No. Series");
    end;

    var
        NoseriesMgmt: Codeunit "NoSeriesManagement";
        ClubSetup: Record "Student Welfare Setup";
}