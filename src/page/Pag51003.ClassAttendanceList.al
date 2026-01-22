page 51003 "Class Attendance List"
{
    CardPageID = "Class Attendance Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Class Attendance Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
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
                field("Class Rep. Reg. No"; Rec."Class Rep. Reg. No")
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
                field("Number Present"; Rec."Number Present")
                {
                    ApplicationArea = All;
                }
                field("Number Absent"; Rec."Number Absent")
                {
                    ApplicationArea = All;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Mail"; Rec."Class Rep. Mail")
                {
                    ApplicationArea = All;
                }
                field("Class Rep. Phone"; Rec."Class Rep. Phone")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
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

    var
        HRMEmployeeC: Record "HRM-Employee C";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        UnitName: Code[150];
        LectName: Code[150];
}

