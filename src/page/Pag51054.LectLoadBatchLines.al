page 51054 "Lect Load Batch Lines"
{
    AutoSplitKey = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Lect Load Batch Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = EmpName;
                field(No; Rec."Lecturer Code")
                {
                    Caption = 'No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(EmpName; EmpName)
                {
                    Caption = 'Names';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Faculty; Rec.Faculty)
                {
                    ApplicationArea = All;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field(Campus; Rec.Campus)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Courses Count"; Rec."Courses Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Approve; Rec.Approve)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reject; Rec.Reject)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Admissible; Rec.Admissible)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Appointment Later Ref. No."; Rec."Appointment Later Ref. No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Appointment Later Ref."; Rec."Appointment Later Ref.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Number; HRMEmployeeC."No.")
                {
                    Caption = 'Number';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(cancelLoad)
            {
                Caption = 'Cancel the Load';
                Image = CancelAllLines;

                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF Rec.Approve THEN ERROR('The Load is already approved!');
                    IF CONFIRM('Cancel the Load for ' + Rec."Lecturer Code" + '?', FALSE) = FALSE THEN EXIT;

                    LectLoadCustProdSource.RESET;
                    LectLoadCustProdSource.SETRANGE(LectLoadCustProdSource.Lecturer, Rec."Semester Code");
                    LectLoadCustProdSource.SETRANGE(LectLoadCustProdSource.Programme, Rec."Lecturer Code");
                    IF LectLoadCustProdSource.FIND('-') THEN BEGIN
                        LectLoadCustProdSource.DELETEALL;
                    END;

                    MESSAGE('The Load details have been deleted.');
                end;
            }
            action(PrinAppointment)
            {
                Caption = 'Print Appointment Letter';
                Image = PrintAcknowledgement;


                ShortCutKey = 'F5';
                Visible = VisibleStatus;
                ApplicationArea = All;

                trigger OnAction()
                var
                    counted: Integer;
                    LectLoadBatchLines: Record "Lect Load Batch Lines";
                begin
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                    LectLoadBatchLines.SETRANGE("Lecturer Code", Rec."Lecturer Code");
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        IF Rec.Approve THEN;
                        //   REPORT.RUN(Report::"Lecturer Appointment Laters", TRUE, FALSE, LectLoadBatchLines);
                    END;
                end;
            }
            action(CourseLoad)
            {
                Caption = 'Course Loading Summary';
                Image = PrintAcknowledgement;


                ShortCutKey = 'F5';
                ApplicationArea = All;

                trigger OnAction()
                var
                    counted: Integer;
                    LectLoadBatchLines: Record "Lect Load Batch Lines";
                begin
                    LectLoadBatchLines.RESET;
                    LectLoadBatchLines.SETRANGE("Semester Code", Rec."Semester Code");
                    //LectLoadBatchLines.SETRANGE("Lecturer Code",Rec."Lecturer Code");
                    IF LectLoadBatchLines.FIND('-') THEN BEGIN
                        // REPORT.RUN(Report::"Lecturer Course Loading", TRUE, FALSE, LectLoadBatchLines);
                    END;
                end;
            }
            action(ClassList)
            {
                Caption = 'Class List';
                Image = List;


                ApplicationArea = All;
                //RunObject = Report 65208;
            }
            action(AttendanceList)
            {
                Caption = 'Attendance List';
                Image = ListPage;


                ApplicationArea = All;

                trigger OnAction()
                var
                    ACALecturersUnits: Record "ACA-Lecturers Units";
                begin
                    ACALecturersUnits.RESET;
                    ACALecturersUnits.SETRANGE(Semester, Rec."Semester Code");
                    ACALecturersUnits.SETRANGE(Lecturer, Rec."Lecturer Code");
                    IF ACALecturersUnits.FIND('-') THEN BEGIN
                        // REPORT.RUN(Report::"Lect Class Attendance List", TRUE, FALSE, ACALecturersUnits);
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(EmpName);
        HRMEmployeeC.RESET;
        HRMEmployeeC.SETRANGE(HRMEmployeeC."No.", Rec."Lecturer Code");
        IF HRMEmployeeC.FIND('-') THEN BEGIN
            EmpName := HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
            Rec."Lecturer Name" := EmpName;
        END;

        IF Rec.Approve THEN VisibleStatus := TRUE ELSE VisibleStatus := FALSE;
    end;

    var
        LectLoadCustProdSource: Record "ACA-Lecturers Units";
        EmpName: Code[200];
        HRMEmployeeC: Record "HRM-Employee C";
        VisibleStatus: Boolean;

}

