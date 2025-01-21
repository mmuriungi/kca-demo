page 51004 "Class Attendance Card"
{
    PageType = Card;
    SourceTable = "Class Attendance Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Reg. No"; Rec."Class Rep. Reg. No")
                {
                    Caption = 'Class Representative';
                    ApplicationArea = All;
                }
                field("Lecturer Code"; Rec."Lecturer Code")
                {
                    ApplicationArea = All;
                }
                field(LectName; LectName)
                {
                    Caption = 'Lecturer Name';
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = All;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = All;
                }
                field("Class Type"; Rec."Class Type")
                {
                    ApplicationArea = All;
                }
            }
            group(ATtDet)
            {
                Caption = 'Attendance Details';
                part(Attendance; "Class Attendance Details Part")
                {
                    Caption = 'Attendance';
                    SubPageLink = Semester = FIELD(Semester),
                                  "Attendance Date" = FIELD("Attendance Date"),
                                  "Lecturer Code" = FIELD("Lecturer Code"),
                                  "Unit Code" = FIELD("Unit Code");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(Comments)
            {
                Caption = 'Attendance Report';
                Image = Check;
                RunObject = report "Class Attendance";
                ApplicationArea = All;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(UnitName);
        CLEAR(LectName);
        //ACAUnitsSubjects.RESET;
        //ACAUnitsSubjects.SETRANGE()

        IF HRMEmployeeC.GET(Rec."Lecturer Code") THEN BEGIN
            LectName := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Attendance Date" := TODAY;
        ACASemester.RESET;
        ACASemester.SETRANGE("Current Semester", TRUE);
        IF ACASemester.FIND('-') THEN BEGIN
            Rec.Semester := ACASemester.Code;
        END;
        Rec."Captured By" := USERID;
    end;

    var
        HRMEmployeeC: Record "HRM-Employee C";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        UnitName: Code[150];
        LectName: Code[150];
        ACASemester: Record "ACA-Semesters";
}

