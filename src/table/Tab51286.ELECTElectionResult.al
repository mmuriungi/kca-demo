table 51286 "ELECT Election Result"
{
    Caption = 'ELECT Election Result';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Election"; Code[20])
        {
            Caption = 'Election';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(5; "PIN No."; Text[30])
        {
            Caption = 'PIN No.';
            DataClassification = CustomerContent;
        }
        field(6; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(7; "Time"; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(8; Voted; Boolean)
        {
            Caption = 'Voted';
            DataClassification = CustomerContent;
        }
        field(9; "ElectionName"; Text[30])
        {
            Caption = 'Election Name';
        }
        field(10; "Student name"; Text[30])
        {
            Caption = 'Student Name';
        }
        //"Candidate No."
        field(11; "Candidate No."; Code[20])
        {
            Caption = 'Candidate No.';
        }
        //Position
        field(12; Position; Code[20])
        {
            Caption = 'Position';
        }
        //"Date Time"
        field(13; "Date Time"; DateTime)
        {
            Caption = 'Date Time';
        }
    }

    keys
    {
        key(PK; Election, "Student No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Date := Today;
        Time := Time;
    end;

    trigger OnModify()
    begin
        TestField(Voted, false); // Prevent modification if already voted
    end;

    var
        AlreadyVotedErr: Label 'This student has already voted in this election.';

    procedure Vote()
    begin
        if Voted then
            Error(AlreadyVotedErr);

        Voted := true;
        Date := Today;
        Time := Time;
        Modify();
    end;
}