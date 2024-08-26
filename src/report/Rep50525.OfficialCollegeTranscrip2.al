report 50525 "Official College Transcrip2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Official College Transcrip2.rdl';
    Caption = 'Official College Transcript';

    dataset
    {
        dataitem(Coregs; "ACA-Classification Course Reg.")
        {
            DataItemTableView = WHERE(Graduating = FILTER(true));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "School Code", Programme, "Student Number", "Graduation Academic Year", "Year of Study";
            column(CoName; 'Tom Mboya University College')
            {
            }
            column(addresses; CompanyInformation.Address + ',' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(phones; CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2")
            {
            }
            column(Mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(StudNo; Coregs."Student Number")
            {
            }
            column(Prog; Coregs.Programme)
            {
            }
            column(Sem; '')
            {
            }
            column(Stag; '')
            {
            }
            column(CumSc; Coregs."Total Marks")
            {
            }
            column(CurrSem; Coregs."Total Marks")
            {
            }
            column(Pic2; CompanyInformation.Picture)
            {
            }
            column(YoS; Coregs."Year of Study")
            {
            }
            column(TotalYearlyMarks; Coregs."Total Marks")
            {
            }
            column(YearlyAverage; Coregs."Normal Average")
            {
            }
            column(YearlyGrade; Coregs."Final Classification Grade")
            {
            }
            column(YearlyFailed; Coregs."Failed Courses")
            {
            }
            column(YearlyTotalUnits; Coregs."Total Courses")
            {
            }
            column(YearlyRemarks; TransCriptRemarks)
            {
            }
            column(AcadYear; Coregs."Graduation Academic Year")
            {
            }
            column(sName; UpperCase(sName))
            {
            }
            column(pName; UpperCase(pName))
            {
            }
            column(GRADDATE; GRADDATE)
            {
            }
            column(YearOfStudy; YearOfStudy)
            {
            }
            column(YearOfAdmi; YearOfAdmi)
            {
            }
            column(SchoolNamez; SchoolName)
            {
            }
            column(acadyearz; acadyear)
            {
            }
            column(From100Legend; 'A (70% - 100%)        - Excellent         B (60% - 69%)      - Good       C (50% - 59%)     -Satisfactory ')
            {
            }
            column(From40Legend; 'D (40% - 49%)          - Fair                 E (39% and Below)   - Fail')
            {
            }
            column(PassMarkLegend; 'NOTE:   Pass mark is ' + Format(Passmark) + '%')
            {
            }
            column(DoubleLine; '===============================================================================')
            {
            }
            column(Recomm; 'Recommendation:')
            {
            }
            column(singleLine; '===============================================================================')
            {
            }
            column(signedSignature; dimVal.Signature)
            {
            }
            column(TranscriptSignatory; dimVal."HOD Names")
            {
            }
            column(TransCriptTitle; dimVal.Titles)
            {
            }
            column(ExamCategory; prog."Exam Category")
            {
            }
            column(FacultyName; UpperCase(dimVal."Faculty Name"))
            {
            }
            column(codSchool; 'COD, ' + SchoolName)
            {
            }
            column(codDept; 'COD,' + DeptName)
            {
            }
            column(dateSigned; 'Date:.......................................................')
            {
            }
            column(PassRemark; PassRemark)
            {
            }
            column(Label1; GLabel[1])
            {
            }
            column(Label2; GLabel[2])
            {
            }
            column(Label3; GLabel[3])
            {
            }
            column(Label4; GLabel[4])
            {
            }
            column(Label5; GLabel[5])
            {
            }
            column(BLabel1; GLabel2[1])
            {
            }
            column(BLabel2; GLabel2[2])
            {
            }
            column(BLabel3; GLabel2[3])
            {
            }
            column(BLabel4; GLabel2[4])
            {
            }
            column(BLabel5; GLabel2[5])
            {
            }
            column(LegendRange1; LegendRange[1])
            {
            }
            column(LegendGrade1; LegendGrade[1])
            {
            }
            column(LegendDesc1; LegendDesc[1])
            {
            }
            column(LegendRange2; LegendRange[2])
            {
            }
            column(LegendGrade2; LegendGrade[2])
            {
            }
            column(LegendDesc2; LegendDesc[2])
            {
            }
            column(LegendRange3; LegendRange[3])
            {
            }
            column(LegendGrade3; LegendGrade[3])
            {
            }
            column(LegendDesc3; LegendDesc[3])
            {
            }
            column(LegendRange4; LegendRange[4])
            {
            }
            column(LegendGrade4; LegendGrade[4])
            {
            }
            column(LegendDesc4; LegendDesc[4])
            {
            }
            column(LegendRange5; LegendRange[5])
            {
            }
            column(LegendGrade5; LegendGrade[5])
            {
            }
            column(LegendDesc5; LegendDesc[5])
            {
            }
            column(LegendRange6; LegendRange[6])
            {
            }
            column(LegendGrade6; LegendGrade[6])
            {
            }
            column(LegendDesc6; LegendDesc[6])
            {
            }
            column(RegAcadLabel; 'Registrar, Academic Affairs')
            {
            }
            dataitem(UnitsReg; "ACA-Classification Units")
            {
                DataItemLink = "Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Year of Study" = FIELD("Year of Study");
                DataItemTableView = WHERE("Allow In Graduate" = FILTER(true));
                column(Unit; UnitsReg."Unit Code")
                {
                }
                column(Desc; UnitsReg."Unit Description")
                {
                }
                column(Score; UnitsReg."Total Score Decimal")
                {
                }
                column(Final; UnitsReg."Weighted Total Score")
                {
                }
                column(Grade; UnitsReg.Grade)
                {
                }
                column(Status; '')
                {
                }

                trigger OnAfterGetRecord()
                begin
                    units_Subjects.Reset;
                    units_Subjects.SetRange("Programme Code", UnitsReg.Programme);
                    units_Subjects.SetRange(Code, UnitsReg."Unit Code");
                    if units_Subjects.Find('-') then begin

                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                Clear(LegendDesc);
                Clear(LegendGrade);
                Clear(LegendRange);
                Clear(Countings);
                Clear(SchoolName);
                Clear(Countings);
                prog.Reset;
                prog.SetRange(Code, Coregs.Programme);
                if prog.Find('-') then begin
                    prog.TestField("Exam Category");
                    ACAExamGraddingSetup.Reset;
                    ACAExamGraddingSetup.SetRange(Category, prog."Exam Category");
                    if ACAExamGraddingSetup.SetCurrentKey(Grade) then;
                    if ACAExamGraddingSetup.Find('-') then begin
                        repeat
                        begin
                            Countings += 1;
                            LegendDesc[Countings] := ACAExamGraddingSetup.Description;
                            LegendGrade[Countings] := ACAExamGraddingSetup.Grade;
                            LegendRange[Countings] := ACAExamGraddingSetup.Range;
                        end;
                        until ACAExamGraddingSetup.Next = 0;
                    end;
                    pName := prog.Description;
                    dimVal.Reset;
                    dimVal.SetRange(dimVal."Dimension Code", 'FACULTY');
                    dimVal.SetRange(dimVal.Code, prog."School Code");
                    if dimVal.Find('-') then begin
                        SchoolName := dimVal.Name;
                    end;
                end;
                dimVal.Reset;
                dimVal.SetRange(dimVal."Dimension Code", 'Department');
                dimVal.SetRange(dimVal.Code, prog."Department Code");
                if dimVal.Find('-') then begin
                    DeptName := dimVal.Name;
                end;

                Clear(YearOfStudy);

                YearOfStudy := Format(Coregs."Year of Study");


                Clear(sName);
                Clear(YearOfAdmi);
                Clear(GRADDATE);
                cust.Reset;
                cust.SetRange(cust."No.", Coregs."Student Number");
                if cust.Find('-') then begin
                    sName := cust.Name;

                end;



                i := 1;
                Gradings.Reset;
                Gradings.SetRange(Gradings.Category, prog."Exam Category");
                Gradings.Ascending := false;
                if Gradings.Find('-') then begin
                    repeat
                        GLabel[i] := Gradings.Grade + '   (' + Gradings.Range + ') - ' + Gradings.Description;
                        GLabel2[i] := ' - ' + Gradings.Description;
                        if Gradings.Failed = true then
                            Passmark := Round(Gradings."Up to", 1);
                        i := i + 1;
                    until Gradings.Next = 0;
                end;


                Clear(TransCriptRemarks);
                Clear(PassRemark);
                ACAProgCatTranscriptComm.Reset;
                ACAProgCatTranscriptComm.SetRange("Exam Catogory", prog."Exam Category");
                ACAProgCatTranscriptComm.SetRange("Year of Study", Coregs."Year of Study");
                if ACAProgCatTranscriptComm.Find('-') then begin
                    if Coregs."Final Classification Pass" then
                        PassRemark := ACAProgCatTranscriptComm."Pass Comment"
                    else
                        PassRemark := ACAProgCatTranscriptComm."Failed Comment";
                    if ACAProgCatTranscriptComm."Include Programme Name" then PassRemark := PassRemark + ' ' + prog.Description;
                    if ACAProgCatTranscriptComm."Include Classification" then PassRemark := PassRemark + ' - ' + Coregs.Classification;
                    PassRemark := UpperCase(PassRemark);
                    TransCriptRemarks := PassRemark;
                end;
                CourseReg12.Reset;
                CourseReg12.SetRange("Student No.", Coregs."Student Number");
                CourseReg12.SetRange("Year Of Study", Coregs."Year of Study");
                CourseReg12.SetFilter(Reversed, '%1', false);
                if CourseReg12.Find('-') then
                    GRADDATE := Coregs."Graduation Academic Year";
                YearOfAdmi := Coregs."Admission Date";
                acadyear := CourseReg12."Academic Year";
            end;

            trigger OnPostDataItem()
            begin
                // ExamProcess.UpdateCourseReg("Course Registration"."Student No.","Course Registration".Programme,"Course Registration".Stage,"Course Registration".Semester);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Reset;
        if CompanyInformation.Find('-') then begin
            CompanyInformation.CalcFields(Picture);
        end;
    end;

    var
        ACAProgCatTranscriptComm: Record "ACA-Prog. Cat. Transcript Comm";
        ACAResultsStatus: Record "ACA-Results Status";
        TransCriptRemarks: Text[250];
        CourseReg12: Record "ACA-Course Registration";
        GRADDATE: Code[30];
        pName: Text[250];
        units_Subjects: Record "ACA-Units/Subjects";
        YearOfStudy: Code[10];
        YearOfAdmi: Date;
        SchoolName: Text[250];
        ExamProcess: Codeunit "Exams Processing";
        EResults: Record "ACA-Exam Results";
        UnitsR: Record "ACA-Units/Subjects";
        "Units/Subj": Record "ACA-Units/Subjects";
        Sem: Record "ACA-Semesters";
        StudUnits: Record "ACA-Student Units";
        stduntz: Record "ACA-Student Units";
        TotalCatMarks: Decimal;
        TotalCatContributions: Decimal;
        TotalMainExamContributions: Decimal;
        TotalExamMark: Decimal;
        FinalExamMark: Decimal;
        FinalCATMarks: Decimal;
        Gradez: Code[10];
        TotalMarks: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record "ACA-Exam Gradding Setup";
        Gradeaqq2: Code[10];
        TotMarks: Decimal;
        sName: Code[250];
        cust: Record Customer;
        acadyear: Code[20];
        Sems: Code[20];
        prog: Record "ACA-Programme";
        dimVal: Record "Dimension Value";
        ProgStages: Record "ACA-Programme Stages";
        PassRemark: Text[200];
        SemRec: Record "ACA-Semesters";
        Creg: Record "ACA-Course Registration";
        IntakeRec: Record "ACA-Intake";
        DeptName: Text[100];
        i: Integer;
        GLabel: array[10] of Text[200];
        GLabel2: array[10] of Text[200];
        Passmark: Decimal;
        CompanyInformation: Record "Company Information";
        UnitsCount: Integer;
        UnitsFailedCount: Integer;
        TotalMarksCounted: Decimal;
        AverageMarks: Decimal;
        AvrgGrade: Code[1];
        AvrgRemarks: Code[250];
        YearofStudyView: Option " ","1st","2nd","3rd","4th","5th","6th";
        SemesterLoader: Integer;
        ProgramLoader: Integer;
        LegendRange: array[40] of Code[20];
        LegendGrade: array[40] of Code[2];
        LegendDesc: array[40] of Code[50];
        ACAExamGraddingSetup: Record "ACA-Exam Gradding Setup";
        Countings: Integer;
}

