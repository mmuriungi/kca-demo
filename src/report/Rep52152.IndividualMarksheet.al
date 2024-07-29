report 52152 "Individual Marksheet"
{
    ApplicationArea = All;
    Caption = 'Individual Marksheet';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Individual Marksheet.rdl';
    dataset
    {
        dataitem(TBLExamResultsBuff; "TBL Exam Results Buff.")
        {
            //DataItemTableView = where("Lecturer Posted Marks" = filter(true));
            column(CompName; compInfo.Name)
            {
            }
            column(CompAddress; compInfo.Address + ' ' + compInfo."Address 2")
            {
            }
            column(CompPhone; compInfo."Phone No." + ' ' + compInfo."Phone No. 2")
            {
            }
            column(CompMail; compInfo."E-Mail")
            {
            }
            column(COmpHomePage; compInfo."Home Page")
            {
            }
            column(Pic; compInfo.Picture)
            {
            }
            column(LecturerCode; hrmemps."First Name" + ' ' + hrmemps."Middle Name" + ' ' + hrmemps."Last Name" + '(' + "Lecturer Code" + ')')
            {
            }
            column(ProgrammeCode; "Programme Code" + ': ' + programs.Description)
            {
            }
            column(AcademicYear; "Academic Year")
            {
            }
            column(SemesterCode; "Semester Code")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(StudentName; "Student Name")
            {
            }
            column(ExamScore; "Exam Score")
            {
            }
            column(UnitCode; "Unit Code" + ': ' + ProgUnits.Desription)
            {
            }
            column(UserCode; "User Code")
            {
            }
            column(CATCapturedBy; "CAT Captured By")
            {
            }
            column(CATFLow; "CAT FLow")
            {
            }
            column(CATScore; "CAT Score")
            {
            }
            column(ExamCapturedBy; "Exam Captured By")
            {
            }
            column(ExamCategory; "Exam Category")
            {
            }
            column(ExamFLow; "Exam FLow")
            {
            }
            column(TotalScore; "Total Score")
            {
            }
            column(seq; Seq)
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                seq := seq + 1;
                programs.Reset();
                programs.SetRange(code, TBLExamResultsBuff."Programme Code");
                if programs.find('-') then;

                ProgUnits.Reset();
                ProgUnits.SetRange(Code, TBLExamResultsBuff."Unit Code");
                ProgUnits.SetRange("Programme Code", TBLExamResultsBuff."Programme Code");
                if ProgUnits.Find('-') then;

                hrmemps.Reset();
                hrmemps.SetRange("No.", "Lecturer Code");
                if hrmemps.find('-') then;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }

    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        clear(compInfo);
        compInfo.Reset();
        if compInfo.Find('-') then compInfo.CalcFields(Picture);
        clear(seq);
    end;

    var
        compInfo: record "Company Information";
        seq: Integer;
        programs: Record "ACA-Programme";
        ProgUnits: Record "ACA-Units/Subjects";
        hrmemps: Record "HRM-Employee C";
}
