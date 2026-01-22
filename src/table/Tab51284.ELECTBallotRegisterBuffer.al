table 51284 "ELECT-Ballot Register Buffer"
{
    Caption = 'ELECT-Ballot Register Buffer';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Election Code"; Code[20])
        {
            Caption = 'Election Code';
        }
        field(2; "Ballot ID"; Code[20])
        {
            Caption = 'Ballot ID';
            trigger OnValidate()
            begin
                ELECTVoterRegister.RESET;
                ELECTVoterRegister.SETRANGE("Ballot ID", Rec."Ballot ID");
                IF ELECTVoterRegister.FIND('-') THEN BEGIN
                    "Voting Time" := TIME;
                    "Votting Date" := TODAY;
                    "Electral District" := ELECTVoterRegister."Electral District";
                    "Department Code" := ELECTVoterRegister."Department Code";
                    "School Code" := ELECTVoterRegister."School Code";
                    "Campus Code" := ELECTVoterRegister."Campus Code";
                    "Polling Center" := ELECTVoterRegister."Polling Center Code";
                END;
            end;
        }
        field(4; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            trigger OnValidate()
            begin
                ELECTPositions.RESET;
                ELECTPositions.SETRANGE("Election Code", Rec."Election Code");
                ELECTPositions.SETRANGE("Position Code", Rec."Position Code");
                IF ELECTPositions.FIND('-') THEN BEGIN
                    "Electral District" := ELECTPositions."Electral District";
                    "Campus Code" := ELECTPositions."Campus Code";
                    "Department Code" := ELECTPositions."Department Code";
                    "School Code" := ELECTPositions."School Code";
                    "Voting Time" := TIME;
                    "Votting Date" := TODAY;
                END;

            end;
        }
        field(5; "Candidate No."; Code[20])
        {
            Caption = 'Candidate No.';
        }
        field(6; "Votting Date"; Date)
        {
            Caption = 'Votting Date';
        }
        field(7; "Voting Time"; Time)
        {
            Caption = 'Voting Time';
        }
        field(8; "Electral District"; Code[20])
        {
            Caption = 'Electral District';
        }
        field(9; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(10; "School Code"; Code[20])
        {
            Caption = 'School Code';
        }
        field(11; "Campus Code"; Code[20])
        {
            Caption = 'Campus Code';
        }
        field(12; "Polling Center"; Code[20])
        {
            Caption = 'Polling Center';
        }
        field(13; "Polling Booth"; Code[20])
        {
            Caption = 'Polling Booth';
        }
        field(14; "Voter No."; Code[30])
        {
            Caption = 'Voter No.';
        }
    }

    keys
    {
        key(PK; "Election Code", "Ballot ID", "Position Code")
        {
            Clustered = true;
        }
    }

    var
        ELECTVoterRegister: Record "ELECT-Voter Register";
        ELECTPositions: Record "ELECT-Positions";
}
