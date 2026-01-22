table 50167 "Club/Society Activity"
{
    Caption = 'Club/Society Activity';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Activity No."; code[20])
        {
            Caption = 'Activity No.';
        }
        field(2; "Club/Society Code"; Code[20])
        {
            Caption = 'Club/Society Code';
            TableRelation = Club;
        }
        field(3; "Activity Date"; Date)
        {
            Caption = 'Activity Date';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Planned,Completed,Cancelled;
        }
        field(6; Attendance; Integer)
        {
            Caption = 'Attendance';
        }
        //."No. Series"
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(PK; "Activity No.", "Club/Society Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        clubsetup.Get();
        ClubSetup.TestField("Club/Society Activity Nos");
        NoseriesMgmt.InitSeries(clubsetup."Club/Society Activity Nos", xRec."No. Series", 0D, Rec."Activity No.", Rec."No. Series");
    end;

    var
        NoseriesMgmt: Codeunit "NoSeriesManagement";
        ClubSetup: Record "Student Welfare Setup";
}
