table 51276 "ACA-Prog/Stage Sem. Schedule"
{
    Caption = 'ACA-Prog/Stage Sem. Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[250])
        {
            Caption = 'Code';
            trigger OnValidate()
            begin
                progs.RESET;
                IF progs.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ProgSems.RESET;
                        ProgSems.SETRANGE(ProgSems."Programme Code", progs.Code);
                        ProgSems.SETRANGE(ProgSems.Semester, Code);
                        IF NOT ProgSems.FIND('-') THEN BEGIN
                            ProgSems.INIT;
                            ProgSems."Programme Code" := progs.Code;
                            ProgSems.Semester := Code;
                            IF ProgSems.INSERT THEN;
                        END;
                    END;
                    UNTIL progs.NEXT = 0;
                END;
            end;
        }
        field(2; "Programme Code"; Code[50])
        {
            Caption = 'Programme Code';
            TableRelation = "ACA-Programme";
            trigger OnValidate()
            begin
                progs.GET("Programme Code");
                "Programme Name" := progs.description;
            end;
        }
        field(3; "Programme Name"; Text[250])
        {
            Caption = 'Programme Name';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(6; "Stage Code"; Code[20])
        {
            Caption = 'Stage Code';
            TableRelation = "ACA-Programme Stages".code where("Programme Code" = field("Programme Code"));
            trigger OnValidate()
            var
                ACAProgrammeStages: Record "ACA-Programme Stages";
            begin
                progs.RESET;
                IF progs.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        ProgSems.RESET;
                        ProgSems.SETRANGE(ProgSems."Programme Code", progs.Code);
                        ProgSems.SETRANGE(ProgSems.Current, TRUE);
                        IF ProgSems.FIND('-') THEN BEGIN
                            ProgSems.Current := FALSE;
                            ProgSems.MODIFY;
                        END;

                        ProgSems.RESET;
                        ProgSems.SETRANGE(ProgSems."Programme Code", progs.Code);
                        ProgSems.SETRANGE(ProgSems.Semester, Code);
                        IF NOT ProgSems.FIND('-') THEN BEGIN
                            ProgSems.INIT;
                            ProgSems."Programme Code" := progs.Code;
                            ProgSems.Semester := Code;
                            ProgSems.Current := TRUE;
                            ProgSems.INSERT;
                        END ELSE BEGIN
                            ProgSems.Current := TRUE;
                            ProgSems.MODIFY;
                        END;
                        //////////////////////////////////////////////////////////////////////
                        ACAProgrammeStages.RESET;
                        ACAProgrammeStages.SETRANGE("Programme Code", progs.Code);
                        IF ACAProgrammeStages.FIND('-') THEN BEGIN
                            REPEAT
                            BEGIN
                                ACAProgrammeStageSemesters.RESET;
                                ACAProgrammeStageSemesters.SETRANGE(ACAProgrammeStageSemesters."Programme Code", progs.Code);
                                ACAProgrammeStageSemesters.SETRANGE(ACAProgrammeStageSemesters.Current, TRUE);
                                ACAProgrammeStageSemesters.SETRANGE(ACAProgrammeStageSemesters.Stage, ACAProgrammeStages.Code);
                                IF ACAProgrammeStageSemesters.FIND('-') THEN BEGIN
                                    ACAProgrammeStageSemesters.Current := FALSE;
                                    ACAProgrammeStageSemesters.MODIFY;
                                END;

                                ACAProgrammeStageSemesters.RESET;
                                ACAProgrammeStageSemesters.SETRANGE(ACAProgrammeStageSemesters."Programme Code", progs.Code);
                                ACAProgrammeStageSemesters.SETRANGE(ACAProgrammeStageSemesters.Semester, Code);
                                ACAProgrammeStageSemesters.SETRANGE(ACAProgrammeStageSemesters.Stage, ACAProgrammeStages.Code);
                                IF NOT ACAProgrammeStageSemesters.FIND('-') THEN BEGIN
                                    ACAProgrammeStageSemesters.INIT;
                                    ACAProgrammeStageSemesters."Programme Code" := progs.Code;
                                    ACAProgrammeStageSemesters.Semester := Code;
                                    ACAProgrammeStageSemesters.Stage := ACAProgrammeStages.Code;
                                    ACAProgrammeStageSemesters.Current := TRUE;
                                    ACAProgrammeStageSemesters.INSERT;
                                END ELSE BEGIN
                                    ACAProgrammeStageSemesters.Current := TRUE;
                                    ACAProgrammeStageSemesters.MODIFY;
                                END;

                            END;
                            UNTIL ACAProgrammeStages.NEXT = 0;
                        END;
                        ///////////////////////////////////////////////////////////////////////
                    END;
                    UNTIL progs.NEXT = 0;
                END;
            end;
        }
        field(7; "Academic Year"; Text[9])
        {
            Caption = 'Academic Year';
        }
        field(8; "SMS Results Semester"; Boolean)
        {
            Caption = 'SMS Results Semester';
        }
        field(9; "Lock Exam Editting"; Boolean)
        {
            Caption = 'Lock Exam Editing';
        }
        field(10; "Lock CAT Editting"; Boolean)
        {
            Caption = 'Lock CAT Editing';
        }
        field(12; "Released Results"; Boolean)
        {
            Caption = 'Released Results';
        }
        field(13; "Lock Lecturer Editing"; Boolean)
        {
            Caption = 'Lock Lecturer Editing';
        }
        field(14; "Mark entry Dealine"; Date)
        {
            Caption = 'Mark Entry Deadline';
        }
        field(15; "Registration Deadline"; Date)
        {
            Caption = 'Registration Deadline';
        }
        field(16; "Ignore Editing Rule"; Boolean)
        {
            Caption = 'Ignore Editing Rule';
        }
        field(17; "BackLog Marks"; Boolean)
        {
            Caption = 'BackLog Marks';
        }
        field(18; "AllowDeanEditing"; Boolean)
        {
            Caption = 'Allow Dean Editing';
        }
        field(19; "Marks Changeable"; Boolean)
        {
            Caption = 'Marks Changeable';
        }
        field(20; "Evaluate Lecture"; Boolean)
        {
            Caption = 'Evaluate Lecture';
        }
        field(21; "Special Entry Deadline"; Date)
        {
            Caption = 'Special Entry Deadline';
        }
        field(23; "Remarks"; Text[150])
        {
            Caption = 'Remarks';
        }
        field(24; "Current Semester"; Boolean)
        {
            Caption = 'Current Semester';
        }
        field(25; "Scheduled Stages Units"; Integer)
        {
            Caption = 'Scheduled Stages Units';
        }
        field(26; "Supplementary Entry Deadline"; Date)
        {
            Caption = 'Supplementary Entry Deadline';
        }
        field(27; "Buffer Results"; Boolean)
        {
            Caption = 'Buffer Results';
        }
    }

    keys
    {
        key(PK; "Code", "Programme Code", "Stage Code")
        {
            Clustered = true;
        }
    }
    var
        CReg: Record "ACA-Course Registration";
        progs: Record "ACA-Programme";
        ProgSems: Record "ACA-Programme Semesters";
        ACAProgrammeStageSemesters: Record "ACA-Programme Stage Semesters";
}
