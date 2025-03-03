page 50963 "Process Exams Central Gen."
{
    PageType = Card;
    SourceTable = "ACA-Programme";
    //SourceTableView = WHERE(Code = FILTER('A100'));

    layout
    {
        area(content)
        {
            group(ProgrammeFil)
            {
                Caption = 'Programme Filter';
                field(Schools; Schools)
                {
                    Caption = 'School Filter';
                    TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('FACULTY'));
                    ApplicationArea = All;
                }
                field(progy; programs)
                {
                    Caption = 'Programme';
                    TableRelation = "ACA-Programme".Code;
                    ApplicationArea = All;
                }
                field(UnitCode; UnitCode)
                {
                    Caption = 'Unit Code';
                    ApplicationArea = All;
                }
                field(StudNos; StudNos)
                {
                    Caption = 'Student No';
                    TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('STUDENT'));
                    ApplicationArea = All;
                }
                field(AcadYear; AcadYear)
                {
                    Caption = 'Academic Year';
                    TableRelation = "ACA-Academic Year".Code;
                    ApplicationArea = All;
                }
                field(semesterz; semesterz)
                {
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Process Senate")
            {
                Image = EncryptionKeys;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Process Senate';
                trigger OnAction()
                var
                    senateReportNew: Codeunit "Senate Processing";
                begin
                    senateReportNew.processResults(programs, semesterz);
                end;
            }
            action(PostMarksNew)
            {
                Caption = 'Process Marks';
                Image = EncryptionKeys;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    AcdYrs: Record "ACA-Academic Year";
                    Custos: Record Customer;
                    usersetup: record "User Setup";
                    StudentUnits: Record "ACA-Student Units";
                    UnitsSubjects: Record "ACA-Units/Subjects";
                    Programme_Fin: Record "ACA-Programme";
                    ProgrammeStages_Fin: Record "ACA-Programme Stages";
                    AcademicYear_Fin: Record "ACA-Academic Year";
                    Semesters_Fin: Record "ACA-Semesters";
                    ExamResults: Record "ACA-Exam Results";
                    ClassSpecialExamsDetails: Record "Aca-Special Exams Details";
                    ClassCustomer: Record Customer;
                    ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
                    ClassDimensionValue: Record "Dimension Value";
                    ClassGradingSystem: Record "ACA-Grading System";
                    ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
                    ClassExamResults2: Record "ACA-Exam Results";
                    TotalRecs: Integer;
                    CountedRecs: Integer;
                    RemeiningRecs: Integer;
                    ExpectedElectives: Integer;
                    CountedElectives: Integer;
                    ProgBar2: Dialog;
                    Progyz: Record "ACA-Programme";
                    ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
                    ACAExamClassificationUnits: Record "ACA-Exam Classification Units";
                    ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
                    ACAExamFailedReasons: Record "ACA-Exam Failed Reasons";
                    ACASenateReportsHeader: Record "ACA-Senate Reports Header";
                    ACAExamClassificationStuds: Record "ACA-Exam Classification Studs";
                    ACAExamClassificationStudsCheck: Record "ACA-Exam Classification Studs";
                    ACAExamResultsFin: Record "ACA-Exam Results";
                    ACAResultsStatus: Record "ACA-Results Status";
                    ProgressForCoReg: Dialog;
                    Tens: Text;
                    ACASemesters: Record "ACA-Semesters";
                    ACAExamResults_Fin: Record "ACA-Exam Results";
                    ProgBar22: Dialog;
                    Coregcs: Record "ACA-Course Registration";
                    ACAExamCummulativeResit: Record "ACA-Exam Cummulative Resit";
                    ACAStudentUnitsForResits: Record "ACA-Student Units";
                    SEQUENCES: Integer;
                    CurrStudentNo: Code[20];
                    CountedNos: Integer;
                    CurrSchool: Code[20];
                    senateReportNew: Codeunit "Senate Processing";
                begin
                    if usersetup.Get(UserId) then begin
                        usersetup.TestField("Can Process Senate Marks");
                    end else
                        error('Accedd Denied!');
                    if Confirm('Process Marks?', true) = false then Error('Cancelled by user!');
                    if AcadYear = '' then Error('Specify Academic Year');

                    Clear(ProgFIls);
                    AcademicYear_Finz.Reset;
                    AcademicYear_Finz.SetFilter(Code, AcadYear);
                    if AcademicYear_Finz.Find('-') then begin
                        repeat
                        begin
                            Clear(GradAcademicYear);
                            GradAcademicYear := AcademicYear_Finz.Code;//AcadYear;


                            // Clear CLassification For Selected Filters
                            ProgFIls := GetProgFilters1(programs, Schools);
                            ACAExamClassificationStuds.Reset;
                            ACAExamCourseRegistration.Reset;
                            ACAExamClassificationUnits.Reset;
                            if StudNos <> '' then begin
                                ACAExamClassificationStuds.SetFilter("Student Number", StudNos);
                                ACAExamCourseRegistration.SetRange("Student Number", StudNos);
                                ACAExamClassificationUnits.SetRange("Student No.", StudNos);
                            end;
                            if GradAcademicYear <> '' then begin
                                ACAExamClassificationStuds.SetFilter("Academic Year", GradAcademicYear);
                                ACAExamCourseRegistration.SetFilter("Academic Year", GradAcademicYear);
                                ACAExamClassificationUnits.SetFilter("Academic Year", GradAcademicYear);
                            end;

                            ACAExamClassificationStuds.SetFilter(Programme, ProgFIls);
                            ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);
                            ACAExamClassificationUnits.SetFilter(Programme, ProgFIls);
                            if ACAExamClassificationStuds.Find('-') then ACAExamClassificationStuds.DeleteAll;
                            if ACAExamCourseRegistration.Find('-') then ACAExamCourseRegistration.DeleteAll;
                            if ACAExamClassificationUnits.Find('-') then ACAExamClassificationUnits.DeleteAll;


                            ACASenateReportsHeader.Reset;
                            ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                            ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                            if (ACASenateReportsHeader.Find('-')) then ACASenateReportsHeader.DeleteAll;

                            Coregcs.Reset;
                            Coregcs.SetFilter(Programmes, ProgFIls);
                            Coregcs.SetRange("Academic Year", GradAcademicYear);
                            Coregcs.SetRange(Reversed, false);
                            Coregcs.SetFilter(Status, '<>%1', StudentUnits.Status::Alluminae);
                            if StudNos <> '' then begin
                                Coregcs.SetFilter("Student No.", StudNos);
                            end;
                            if Coregcs.Find('-') then begin
                                Clear(TotalRecs);
                                Clear(RemeiningRecs);
                                Clear(CountedRecs);
                                TotalRecs := Coregcs.Count;
                                RemeiningRecs := TotalRecs;
                                // Loop through all Ungraduated Students Units
                                Progressbar.Open('#1#####################################################\' +
                                '#2############################################################\' +
                                '#3###########################################################\' +
                                '#4############################################################\' +
                                '#5###########################################################\' +
                                '#6############################################################');
                                Progressbar.Update(1, 'Processing  values....');
                                Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                repeat
                                begin

                                    CountedRecs := CountedRecs + 1;
                                    RemeiningRecs := RemeiningRecs - 1;
                                    // Create Registration Unit entry if Not Exists
                                    Progressbar.Update(3, '.....................................................');
                                    Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                                    Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                    Progressbar.Update(6, '----------------------------------------------------');
                                    Progyz.Reset;
                                    Progyz.SetFilter(Code, Coregcs.Programmes);
                                    if Progyz.Find('-') then begin
                                    end;
                                    Clear(YosStages);
                                    if Coregcs."Year Of Study" = 0 then Coregcs.Validate(Stage);
                                    if Coregcs."Year Of Study" = 1 then
                                        YosStages := 'Y1S1|Y1S2|Y1S3|Y1S4'
                                    else
                                        if Coregcs."Year Of Study" = 2 then
                                            YosStages := 'Y2S1|Y2S2|Y2S3|Y2S4'
                                        else
                                            if Coregcs."Year Of Study" = 3 then
                                                YosStages := 'Y3S1|Y3S2|Y3S3|Y3S4'
                                            else
                                                if Coregcs."Year Of Study" = 4 then
                                                    YosStages := 'Y4S1|Y4S2|Y4S3|Y4S4'
                                                else
                                                    if Coregcs."Year Of Study" = 5 then
                                                        YosStages := 'Y5S1|Y5S2|Y5S3|Y5S4'
                                                    else
                                                        if Coregcs."Year Of Study" = 6 then
                                                            YosStages := 'Y6S1|Y6S2|Y6S3|Y6S4'
                                                        else
                                                            if Coregcs."Year Of Study" = 7 then
                                                                YosStages := 'Y7S1|Y7S2|Y7S3|Y7S4'
                                                            else
                                                                if Coregcs."Year Of Study" = 8 then YosStages := 'Y8S1|Y8S2|Y8S3|Y8S4';

                                    ACAExamCummulativeResit.Reset;
                                    ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                    ACAExamCummulativeResit.SetRange("Academic Year", GradAcademicYear);
                                    if ACAExamCummulativeResit.Find('-') then ACAExamCummulativeResit.DeleteAll;

                                    Custos.Reset;
                                    Custos.SetRange("No.", Coregcs."Student No.");
                                    if Custos.Find('-') then
                                        Custos.CalcFields("Senate Classification Based on");

                                    StudentUnits.Reset;
                                    StudentUnits.SetRange("Student No.", Coregcs."Student No.");
                                    if Custos."Senate Classification Based on" = Custos."Senate Classification Based on"::"Year of Study" then
                                        StudentUnits.SetFilter("Unit Stage", YosStages)
                                    else
                                        StudentUnits.SetFilter("Academic Year", Coregcs."Academic Year");
                                    if StudentUnits.Find('-') then begin
                                        repeat
                                        begin



                                            StudentUnits.CalcFields(StudentUnits."CATs Marks Exists");
                                            if StudentUnits."CATs Marks Exists" = false then begin

                                                AcdYrs.Reset;
                                                AcdYrs.SetRange(Code, StudentUnits."Academic Year");
                                                AcdYrs.SetRange("Allow CATs Exempt", true);
                                                if AcdYrs.Find('-') then begin
                                                    ExamResults.Init;
                                                    ExamResults."Student No." := StudentUnits."Student No.";
                                                    ExamResults.Programmes := StudentUnits.Programme;
                                                    ExamResults.Stage := StudentUnits.Stage;
                                                    ExamResults.Unit := StudentUnits.Unit;
                                                    ExamResults.Semester := StudentUnits.Semester;
                                                    ExamResults."Academic Year" := StudentUnits."Academic Year";
                                                    ExamResults."Reg. Transaction ID" := StudentUnits."Reg. Transacton ID";
                                                    ExamResults.ExamType := 'CAT';
                                                    ExamResults.Exam := 'CAT';
                                                    ExamResults."Exam Category" := Progyz."Exam Category";
                                                    ExamResults.Score := 0;
                                                    ExamResults."User Name" := 'AUTOPOST';
                                                    ExamResults.Insert;
                                                end;
                                            end;
                                            ExamResults.Reset;
                                            ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                            ExamResults.SetRange(Unit, StudentUnits.Unit);
                                            if ExamResults.Find('-') then begin
                                                repeat
                                                begin
                                                    if ExamResults.ExamType <> '' then begin
                                                        ExamResults.Exam := ExamResults.ExamType;
                                                        ExamResults.Modify;
                                                    end else
                                                        if ExamResults.Exam <> '' then begin
                                                            if ExamResults.ExamType = '' then begin
                                                                //ExamResults.ExamType:=ExamResults.Exam;
                                                                ExamResults.Rename(ExamResults."Student No.", ExamResults.Programmes, ExamResults.Stage,
                                                                ExamResults.Unit, ExamResults.Semester, ExamResults.Exam, ExamResults."Reg. Transaction ID", ExamResults."Entry No");
                                                            end;
                                                        end;
                                                end;
                                                until ExamResults.Next = 0;
                                            end;
                                            ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                            ExamResults.Reset;
                                            ExamResults.SetFilter("Counted Occurances", '>%1', 1);
                                            ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                            ExamResults.SetRange(Unit, StudentUnits.Unit);
                                            if ExamResults.Find('-') then begin
                                                repeat
                                                begin
                                                    ACAExamResultsFin.Reset;
                                                    ACAExamResultsFin.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamResultsFin.SetRange(Programmes, StudentUnits.Programme);
                                                    ACAExamResultsFin.SetRange(Unit, StudentUnits.Unit);
                                                    ACAExamResultsFin.SetRange(Semester, StudentUnits.Semester);
                                                    ACAExamResultsFin.SetRange(ExamType, ExamResults.ExamType);

                                                    if ACAExamResultsFin.Find('-') then begin
                                                        ACAExamResultsFin.CalcFields("Counted Occurances");
                                                        if ACAExamResultsFin."Counted Occurances" > 1 then begin
                                                            ACAExamResultsFin.Delete;
                                                        end;
                                                    end;

                                                end;
                                                until ExamResults.Next = 0;
                                            end;
                                            ////////////////////////////////// Remgitove Multiple Occurances of a Mark
                                            ////////////////////////////////////////////////////////////////////////////
                                            // Grad Headers
                                            ACAResultsStatus.Reset;
                                            ACAResultsStatus.SetRange("Special Programme Class", Progyz."Special Programme Class");
                                            ACAResultsStatus.SetRange("Academic Year", GradAcademicYear);
                                            if ACAResultsStatus.Find('-') then begin
                                                repeat
                                                begin

                                                    ACASenateReportsHeader.Reset;
                                                    ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                                                    ACASenateReportsHeader.SetRange("School Code", Progyz."School Code");
                                                    ACASenateReportsHeader.SetRange("Classification Code", ACAResultsStatus.Code);
                                                    ACASenateReportsHeader.SetRange("Programme Code", Progyz.Code);
                                                    ACASenateReportsHeader.SetRange("Year of Study", Coregcs."Year Of Study");
                                                    if not (ACASenateReportsHeader.Find('-')) then begin

                                                        ACASenateReportsHeader.Init;
                                                        ACASenateReportsHeader."Academic Year" := GradAcademicYear;
                                                        ACASenateReportsHeader."Reporting Academic Year" := GradAcademicYear;
                                                        ACASenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                                                        ACASenateReportsHeader."Programme Code" := Progyz.Code;
                                                        ACASenateReportsHeader."School Code" := Progyz."School Code";
                                                        ACASenateReportsHeader."Year of Study" := Coregcs."Year Of Study";
                                                        ACASenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                                                        ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                        ACASenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                                                        ACASenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                                                        ACASenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                                                        ACASenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                                                        ACASenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                                                        ACASenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                                                        ACASenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                                                        ACASenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                                                        ACASenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                                                        ACASenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                                                        ACASenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                                                        ACASenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                                                        ACASenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                                                        ACASenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                                                        ACASenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                                                        ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                        ACASenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                                                        ACASenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                                                        ACASenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                                                        ACASenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                                                        ACASenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                                                        ACASenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                                                        ACASenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                                                        ACASenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                                                        ACASenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                                                        ACASenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                                                        ACASenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                                                        ACASenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                                                        ACASenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                                                        ACASenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                                                        ACASenateReportsHeader.Insert;

                                                    end;
                                                end;
                                                until ACAResultsStatus.Next = 0;
                                            end;
                                            ////////////////////////////////////////////////////////////////////////////
                                            ACAExamClassificationStuds.Reset;
                                            ACAExamClassificationStuds.SetRange("Student Number", StudentUnits."Student No.");
                                            ACAExamClassificationStuds.SetRange(Programme, StudentUnits.Programme);
                                            ACAExamClassificationStuds.SetRange("Academic Year", GradAcademicYear);
                                            // ACAExamClassificationStuds.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                            if not ACAExamClassificationStuds.Find('-') then begin
                                                ACAExamClassificationStuds.Init;
                                                ACAExamClassificationStuds."Student Number" := StudentUnits."Student No.";
                                                ACAExamClassificationStuds."Reporting Academic Year" := GradAcademicYear;
                                                ACAExamClassificationStuds."School Code" := Progyz."School Code";
                                                ACAExamClassificationStuds.Department := Progyz."Department Code";
                                                ACAExamClassificationStuds."Programme Option" := Coregcs.Options;
                                                ACAExamClassificationStuds.Programme := StudentUnits.Programme;
                                                ACAExamClassificationStuds."Academic Year" := GradAcademicYear;
                                                ACAExamClassificationStuds."Year of Study" := Coregcs."Year Of Study";
                                                //ACAExamClassificationStuds."Department Name":=GetDepartmentNameOrSchool(Progyz."Department Code");
                                                ACAExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
                                                ACAExamClassificationStuds."Student Name" := GetStudentName(StudentUnits."Student No.");
                                                ACAExamClassificationStuds.Cohort := GetCohort(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds."Final Stage" := GetFinalStage(StudentUnits.Programme);
                                                ACAExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(StudentUnits.Programme);
                                                ACAExamClassificationStuds."Admission Date" := GetAdmissionDate(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                ACAExamClassificationStuds.Graduating := false;
                                                ACAExamClassificationStuds.Classification := '';
                                                ACAExamClassificationStuds.Insert;

                                                // // // // // // //          ACAExamCummulativeResit.RESET;
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Academic Year",ACAExamClassificationStuds."Academic Year");
                                                // // // // // // //        IF ACAExamCummulativeResit.FIND('-') THEN ACAExamCummulativeResit.DELETEALL;
                                                // // // // // // //
                                                // // // // // // //        ACAStudentUnitsForResits.RESET;
                                                // // // // // // //        ACAStudentUnitsForResits.SETRANGE("Student No.",StudentUnits."Student No.");
                                                // // // // // // //        ACAStudentUnitsForResits.SETRANGE("Reg. Reversed",FALSE);
                                                // // // // // // //        IF ACAStudentUnitsForResits.FIND('-') THEN BEGIN
                                                // // // // // // //          REPEAT
                                                // // // // // // //              BEGIN
                                                // // // // // // //                ACAStudentUnitsForResits.CALCFIELDS("EXAMs Marks","CATs Marks","CATs Marks Exists","EXAMs Marks Exists");
                                                // // // // // // //                IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                // // // // // // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE) OR
                                                // // // // // // //                   (((GetUnitPassStatus((GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                // // // // // // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme)),
                                                // // // // // // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme))=FALSE))) THEN BEGIN
                                                // // // // // // //      UnitsSubjects.RESET;
                                                // // // // // // //      UnitsSubjects.SETRANGE("Programme Code",ACAStudentUnitsForResits.Programme);
                                                // // // // // // //      UnitsSubjects.SETRANGE(Code,ACAStudentUnitsForResits.Unit);
                                                // // // // // // //      IF UnitsSubjects.FIND('-') THEN BEGIN
                                                // // // // // // //
                                                // // // // // // //        IF NOT (GetYearOfStudy(UnitsSubjects."Stage Code")>Coregcs."Year Of Study") THEN BEGIN
                                                // // // // // // //          ACAExamCummulativeResit.RESET;
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Unit Code",ACAStudentUnitsForResits.Unit);
                                                // // // // // // //        ACAExamCummulativeResit.SETRANGE("Academic Year",Coregcs."Academic Year");
                                                // // // // // // //        IF NOT (ACAExamCummulativeResit.FIND('-')) THEN BEGIN
                                                // // // // // // //            ACAExamCummulativeResit.INIT;
                                                // // // // // // //            ACAExamCummulativeResit."Student Number":=StudentUnits."Student No.";
                                                // // // // // // //            ACAExamCummulativeResit."School Code":=ACAExamClassificationStuds."School Code";
                                                // // // // // // //            ACAExamCummulativeResit."Academic Year":=ACAExamClassificationStuds."Academic Year";
                                                // // // // // // //            ACAExamCummulativeResit."Unit Code":=ACAStudentUnitsForResits.Unit;
                                                // // // // // // //            ACAExamCummulativeResit."Student Name":=ACAExamClassificationStuds."Student Name";
                                                // // // // // // //            ACAExamCummulativeResit.Programme:=ACAExamClassificationStuds.Programme;
                                                // // // // // // //            ACAExamCummulativeResit."School Name":=ACAExamClassificationStuds."School Name";
                                                // // // // // // //            ACAExamCummulativeResit."Unit Description":=UnitsSubjects.Desription;
                                                // // // // // // //            ACAExamCummulativeResit."Credit Hours":=UnitsSubjects."Credit Hours";
                                                // // // // // // //            IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Core THEN
                                                // // // // // // //              ACAExamCummulativeResit."Unit Type":='CORE'
                                                // // // // // // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Required THEN
                                                // // // // // // //              ACAExamCummulativeResit."Unit Type":='Required'
                                                // // // // // // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Elective THEN
                                                // // // // // // //              ACAExamCummulativeResit."Unit Type":='Elective';
                                                // // // // // // //
                                                // // // // // // //            ACAExamCummulativeResit.Score:=ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks";
                                                // // // // // // //            IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                // // // // // // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE)) THEN
                                                // // // // // // //            ACAExamCummulativeResit.Grade:='!' ELSE
                                                // // // // // // //            ACAExamCummulativeResit.Grade:=GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                // // // // // // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme);
                                                // // // // // // //              IF ACAExamCummulativeResit.Grade<>'' THEN
                                                // // // // // // //            IF ACAExamCummulativeResit.INSERT THEN;
                                                // // // // // // //
                                                // // // // // // //            END;
                                                // // // // // // //            END;
                                                // // // // // // //        END;
                                                // // // // // // //        END;
                                                // // // // // // //              END;
                                                // // // // // // //            UNTIL ACAStudentUnitsForResits.NEXT=0;
                                                // // // // // // //          END;
                                                // // // // // // //        // Pick all Resits for the Student
                                            end;
                                            /////////////////////////////////////// YoS Tracker
                                            Progyz.Reset;
                                            if Progyz.Get(Coregcs.Programmes) then;
                                            ACAExamCourseRegistration.Reset;
                                            ACAExamCourseRegistration.SetRange("Student Number", Coregcs."Student No.");
                                            ACAExamCourseRegistration.SetRange(Programme, Coregcs.Programmes);
                                            ACAExamCourseRegistration.SetRange("Year of Study", Coregcs."Year Of Study");
                                            ACAExamCourseRegistration.SetRange("Academic Year", GradAcademicYear);
                                            // ACAExamCourseRegistration.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                            if not ACAExamCourseRegistration.Find('-') then begin
                                                ACAExamCourseRegistration.Init;
                                                ACAExamCourseRegistration."Student Number" := Coregcs."Student No.";
                                                ACAExamCourseRegistration.Programme := Coregcs.Programmes;
                                                ACAExamCourseRegistration."Year of Study" := Coregcs."Year Of Study";
                                                ACAExamCourseRegistration."Reporting Academic Year" := GradAcademicYear;
                                                ACAExamCourseRegistration."Academic Year" := Coregcs."Academic Year";
                                                ACAExamCourseRegistration."School Code" := Progyz."School Code";
                                                ACAExamCourseRegistration."Programme Option" := Coregcs.Options;
                                                // ACAExamCourseRegistration.Department:=Progyz."Department Code";
                                                // ACAExamCourseRegistration."Department Name":=ACAExamClassificationStuds."Department Name";
                                                ACAExamCourseRegistration."School Name" := ACAExamClassificationStuds."School Name";
                                                ACAExamCourseRegistration."Student Name" := ACAExamClassificationStuds."Student Name";
                                                ACAExamCourseRegistration.Cohort := ACAExamClassificationStuds.Cohort;
                                                ACAExamCourseRegistration."Final Stage" := ACAExamClassificationStuds."Final Stage";
                                                ACAExamCourseRegistration."Final Academic Year" := ACAExamClassificationStuds."Final Academic Year";
                                                ACAExamCourseRegistration."Final Year of Study" := ACAExamClassificationStuds."Final Year of Study";
                                                ACAExamCourseRegistration."Admission Date" := ACAExamClassificationStuds."Admission Date";
                                                ACAExamCourseRegistration."Admission Academic Year" := ACAExamClassificationStuds."Admission Academic Year";

                                                if ((Progyz.Category = Progyz.Category::Certificate) or
                                                   (Progyz.Category = Progyz.Category::"Course List") or
                                                   (Progyz.Category = Progyz.Category::Professional)) then begin
                                                    ACAExamCourseRegistration."Category Order" := 2;
                                                end else
                                                    if (Progyz.Category = Progyz.Category::Diploma) then begin
                                                        ACAExamCourseRegistration."Category Order" := 3;
                                                    end else
                                                        if (Progyz.Category = Progyz.Category::Postgraduate) then begin
                                                            ACAExamCourseRegistration."Category Order" := 4;
                                                        end else
                                                            if (Progyz.Category = Progyz.Category::Undergraduate) then begin
                                                                ACAExamCourseRegistration."Category Order" := 1;
                                                            end;

                                                ACAExamCourseRegistration.Graduating := false;
                                                ACAExamCourseRegistration.Classification := '';
                                                ACAExamCourseRegistration.Insert;
                                            end;
                                            /////////////////////////////////////// end of YoS Tracker

                                            //Get best CAT Marks
                                            StudentUnits."Unit not in Catalogue" := false;

                                            UnitsSubjects.Reset;
                                            UnitsSubjects.SetRange("Programme Code", StudentUnits.Programme);
                                            UnitsSubjects.SetRange(Code, StudentUnits.Unit);
                                            if UnitsSubjects.Find('-') then begin

                                                ACAExamClassificationUnits.Reset;
                                                ACAExamClassificationUnits.SetRange("Student No.", Coregcs."Student No.");
                                                ACAExamClassificationUnits.SetRange(Programme, Coregcs.Programmes);
                                                ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                //    ACAExamClassificationUnits.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                                ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                if not ACAExamClassificationUnits.Find('-') then begin
                                                    ACAExamClassificationUnits.Init;
                                                    ACAExamClassificationUnits."Student No." := Coregcs."Student No.";
                                                    ACAExamClassificationUnits.Programme := Coregcs.Programmes;
                                                    ACAExamClassificationUnits."Reporting Academic Year" := GradAcademicYear;
                                                    ACAExamClassificationUnits."School Code" := Progyz."School Code";
                                                    // //            ACAExamClassificationUnits."Department Code":=Progyz."Department Code";
                                                    ACAExamClassificationUnits."Unit Code" := StudentUnits.Unit;
                                                    ACAExamClassificationUnits."Credit Hours" := UnitsSubjects."Credit Hours";
                                                    ACAExamClassificationUnits."Unit Type" := Format(UnitsSubjects."Unit Type");
                                                    ACAExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                                    //            IF ACACourseRegistration."Year Of Study"=0 THEN
                                                    //              ACACourseRegistration."Year Of Study":=GetYearOfStudy(ACACourseRegistration.Stage);
                                                    ACAExamClassificationUnits."Year of Study" := ACAExamCourseRegistration."Year of Study";
                                                    ACAExamClassificationUnits."Academic Year" := GradAcademicYear;

                                                    ExamResults.Reset;
                                                    ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                    ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                    if ExamResults.Find('-') then begin
                                                        ExamResults.CalcFields("Number of Repeats", "Number of Resits");
                                                        if ExamResults."Number of Repeats" > 0 then
                                                            ACAExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                                        if ExamResults."Number of Resits" > 0 then
                                                            ACAExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                                    end;

                                                    ACAExamClassificationUnits.Insert;
                                                end;

                                                /////////////////////////// Update Unit Score
                                                ACAExamClassificationUnits.Reset;
                                                ACAExamClassificationUnits.SetRange("Student No.", Coregcs."Student No.");
                                                ACAExamClassificationUnits.SetRange(Programme, Coregcs.Programmes);
                                                ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                ACAExamClassificationUnits.SetRange("Reporting Academic Year", GradAcademicYear);
                                                if ACAExamClassificationUnits.Find('-') then begin
                                                    // //
                                                    // //              ClassStudentUnits.RESET;
                                                    // //              ClassStudentUnits.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                    // //              ClassStudentUnits.SETRANGE(Programme,ACAExamClassificationUnits.Programme);
                                                    // //            //  ClassStudentUnits.SETRANGE("Reg Reversed",FALSE);
                                                    // //              ClassStudentUnits.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                    // //              IF ClassStudentUnits.FIND('+') THEN BEGIN
                                                    //Get CAT Marks
                                                    // //                ClassExamResults.RESET;
                                                    // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                    // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                    // //                ClassExamResults.SETFILTER(Exam,'%1|%2','ASSIGNMENT','CAT');
                                                    // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                    // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                    // // // // // // // //              IF StudentUnits."CATs Marks Exists" THEN BEGIN
                                                    // // // // // // // //                  ACAExamClassificationUnits."CAT Score":=FORMAT(StudentUnits."CATs Marks");
                                                    // // // // // // // //                  ACAExamClassificationUnits."CAT Score Decimal":=StudentUnits."CATs Marks";
                                                    // // // // // // // //                    END;
                                                    // // // // // // // // // //                  END;
                                                    // // // // // // // //              //Get Exam Marks
                                                    // // // // // // // // // //                ClassExamResults.RESET;
                                                    // // // // // // // // // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                    // // // // // // // // // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                    // // // // // // // // // //                ClassExamResults.SETFILTER(Exam,'%1|%2|%3|%4','EXAM','EXAM100','EXAMS','FINAL EXAM');
                                                    // // // // // // // // // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                    // // // // // // // // // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                    // // // // // // // //              IF StudentUnits."EXAMs Marks Exists" THEN BEGIN
                                                    // // // // // // // //                  ACAExamClassificationUnits."Exam Score":=FORMAT(StudentUnits."EXAMs Marks");
                                                    // // // // // // // //                  ACAExamClassificationUnits."Exam Score Decimal":=StudentUnits."EXAMs Marks";
                                                    // // // // // // // //                  END;
                                                    // //                  END;

                                                    //  IF ACAExamClassificationUnits."Exam Score"='' THEN BEGIN
                                                    ACAExamResults_Fin.Reset;
                                                    ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                    ACAExamResults_Fin.SetFilter(Exam, '%1|%2|%3|%4', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM');
                                                    ACAExamResults_Fin.SetCurrentKey(Score);
                                                    if ACAExamResults_Fin.Find('+') then begin
                                                        ACAExamClassificationUnits."Exam Score" := Format(ACAExamResults_Fin.Score);
                                                        ACAExamClassificationUnits."Exam Score Decimal" := ACAExamResults_Fin.Score;
                                                    end;
                                                    //     END;

                                                    //   IF ACAExamClassificationUnits."CAT Score"='' THEN BEGIN
                                                    ACAExamResults_Fin.Reset;
                                                    ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                    ACAExamResults_Fin.SetFilter(Exam, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                                                    ACAExamResults_Fin.SetCurrentKey(Score);
                                                    if ACAExamResults_Fin.Find('+') then begin
                                                        ACAExamClassificationUnits."CAT Score" := Format(ACAExamResults_Fin.Score);
                                                        ACAExamClassificationUnits."CAT Score Decimal" := ACAExamResults_Fin.Score;
                                                    end;
                                                    // END;

                                                    //Update Total Marks
                                                    if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                        // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                        // //                    ACAExamClassificationUnits.Grade:='?';
                                                        // //                    ACAExamClassificationUnits."Grade Comment":='MISSED';
                                                        // //                    ACAExamClassificationUnits."Comsolidated Prefix":='?';
                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                                    end else
                                                        if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                            // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                            // //                    ACAExamClassificationUnits.Grade:='!';
                                                            // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                            // //                    ACAExamClassificationUnits."Comsolidated Prefix":='c';
                                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                                        end else
                                                            if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                                // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                                // //                    ACAExamClassificationUnits.Grade:='!';
                                                                // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                                // //                    ACAExamClassificationUnits."Comsolidated Prefix":='e';
                                                                ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                                            end else
                                                                if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                                                end;

                                                    if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                        // //                 ACAExamClassificationUnits."Grade Comment":=GetGradeComment(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                        ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                        ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                        ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                        // //                  ACAExamClassificationUnits.Grade:=GetGrade(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                        // //                  ACAExamClassificationUnits.Pass:=GetUnitPassStatus(ACAExamClassificationUnits.Grade,ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                        // //                  IF ACAExamClassificationUnits.Pass=FALSE THEN BEGIN
                                                        // //                    ACAExamClassificationUnits."Comsolidated Prefix":='^';
                                                        //  END;
                                                    end else begin
                                                        ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                        ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                        ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                    end;
                                                    ACAExamClassificationUnits."Allow In Graduate" := true;
                                                    /// Update Cummulative Resit
                                                    ACAExamClassificationUnits.CalcFields(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                                                    if not (ACAExamClassificationUnits.Pass) then begin
                                                        ACAExamCummulativeResit.Reset;
                                                        ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                                        ACAExamCummulativeResit.SetRange("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                        ACAExamCummulativeResit.SetRange("Academic Year", Coregcs."Academic Year");
                                                        if not (ACAExamCummulativeResit.Find('-')) then begin
                                                            ACAExamCummulativeResit.Init;
                                                            ACAExamCummulativeResit."Student Number" := StudentUnits."Student No.";
                                                            ACAExamCummulativeResit."School Code" := ACAExamClassificationStuds."School Code";
                                                            ACAExamCummulativeResit."Academic Year" := StudentUnits."Academic Year";
                                                            ACAExamCummulativeResit."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                                            ACAExamCummulativeResit."Student Name" := ACAExamClassificationStuds."Student Name";
                                                            ACAExamCummulativeResit.Programme := StudentUnits.Programme;
                                                            ACAExamCummulativeResit."School Name" := ACAExamClassificationStuds."School Name";
                                                            ACAExamCummulativeResit."Unit Description" := UnitsSubjects.Desription;
                                                            ACAExamCummulativeResit."Credit Hours" := UnitsSubjects."Credit Hours";
                                                            ACAExamCummulativeResit."Unit Type" := ACAExamClassificationUnits."Unit Type";
                                                            ACAExamCummulativeResit.Score := ACAExamClassificationUnits."Total Score Decimal";
                                                            ACAExamCummulativeResit.Grade := ACAExamClassificationUnits.Grade;
                                                            if ACAExamCummulativeResit.Insert then;
                                                        end;
                                                    end;
                                                    if ACAExamClassificationUnits.Modify then;
                                                    //////////////////////////// Update Units Scores.. End
                                                end else begin
                                                    StudentUnits."Unit not in Catalogue" := true;
                                                end;
                                            end;
                                            StudentUnits.Modify;
                                            ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii End of Finalize Units
                                        end;

                                        until StudentUnits.Next = 0;
                                    end;

                                end;
                                until Coregcs.Next = 0;
                                Progressbar.Close;
                            end;

                            //Update Senate Header
                            // // // // // // //
                            // // // // // // //            ACASenateReportsHeader.RESET;
                            // // // // // // //            ACASenateReportsHeader.SETFILTER("Programme Code",ProgFIls);
                            // // // // // // //            ACASenateReportsHeader.SETFILTER("Academic Year",GradAcademicYear);
                            // // // // // // //            IF ACASenateReportsHeader.FIND('-') THEN ACASenateReportsHeader.DELETEALL;
                            // // // // // // //
                            // // // // // // // ACAExamCourseRegistration.RESET;
                            // // // // // // // ACAExamCourseRegistration.SETFILTER(Programme,ProgFIls);
                            // // // // // // // ACAExamCourseRegistration.SETFILTER("Academic Year",GradAcademicYear);
                            // // // // // // // IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                            // // // // // // //  TotalRecs:=ACAExamCourseRegistration.COUNT;
                            // // // // // // //  RemeiningRecs:=TotalRecs;
                            // // // // // // //  ProgBar2.OPEN('#1#####################################################\'+
                            // // // // // // //  '#2############################################################\'+
                            // // // // // // //  '#3###########################################################\'+
                            // // // // // // //  '#4############################################################\'+
                            // // // // // // //  '#5###########################################################\'+
                            // // // // // // //  '#6############################################################');
                            // // // // // // //     ProgBar2.UPDATE(1,'2 of 3 Updating Class Items');
                            // // // // // // //     ProgBar2.UPDATE(2,'Total Recs.: '+FORMAT(TotalRecs));
                            // // // // // // //    REPEAT
                            // // // // // // //      BEGIN
                            // // // // // // // ACAExamFailedReasons.RESET;
                            // // // // // // // ACAExamFailedReasons.SETRANGE("Student No.",ACAExamCourseRegistration."Student Number");
                            // // // // // // // IF ACAExamFailedReasons.FIND('-') THEN ACAExamFailedReasons.DELETEALL;
                            // // // // // // //      CountedRecs+=1;
                            // // // // // // //      RemeiningRecs-=1;
                            // // // // // // //     ProgBar2.UPDATE(3,'.....................................................');
                            // // // // // // //     ProgBar2.UPDATE(4,'Processed: '+FORMAT(CountedRecs));
                            // // // // // // //     ProgBar2.UPDATE(5,'Remaining: '+FORMAT(RemeiningRecs));
                            // // // // // // //     ProgBar2.UPDATE(6,'----------------------------------------------------');
                            // // // // // // //
                            // // // // // // // // //
                            // // // // // // // // //            ACAResultsStatus.RESET;
                            // // // // // // // // //            ACAResultsStatus.SETRANGE("Special Programme Class",Progyz."Special Programme Class");
                            // // // // // // // // //            ACAResultsStatus.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                            // // // // // // // // //            IF ACAResultsStatus.FIND('-') THEN BEGIN
                            // // // // // // // // //              REPEAT
                            // // // // // // // // //                  BEGIN
                            // // // // // // // // //                  ACASenateReportsHeader.RESET;
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("School Code",Progyz."School Code");
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Classification Code",ACAResultsStatus.Code);
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Programme Code",Progyz.Code);
                            // // // // // // // // //                  ACASenateReportsHeader.SETRANGE("Year of Study",ACAExamCourseRegistration."Year of Study");
                            // // // // // // // // //                  IF NOT (ACASenateReportsHeader.FIND('-')) THEN BEGIN
                            // // // // // // // // //                    ACASenateReportsHeader.INIT;
                            // // // // // // // // //                    ACASenateReportsHeader."Academic Year":=ACAExamCourseRegistration."Academic Year";
                            // // // // // // // // //                    ACASenateReportsHeader."Reporting Academic Year":=ACAExamCourseRegistration."Academic Year";
                            // // // // // // // // //                    ACASenateReportsHeader."Rubric Order":=ACAResultsStatus."Order No";
                            // // // // // // // // //                    ACASenateReportsHeader."Programme Code":=Progyz.Code;
                            // // // // // // // // //                    ACASenateReportsHeader."School Code":=Progyz."School Code";
                            // // // // // // // // //                    ACASenateReportsHeader."Year of Study":=ACAExamCourseRegistration."Year of Study";
                            // // // // // // // // //                    ACASenateReportsHeader."Classification Code":=ACAResultsStatus.Code;
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 1":=ACAResultsStatus."IncludeVariable 1";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 2":=ACAResultsStatus."IncludeVariable 2";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 3":=ACAResultsStatus."IncludeVariable 3";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 4":=ACAResultsStatus."IncludeVariable 4";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 5":=ACAResultsStatus."IncludeVariable 5";
                            // // // // // // // // //                    ACASenateReportsHeader."IncludeVariable 6":=ACAResultsStatus."IncludeVariable 6";
                            // // // // // // // // //                    ACASenateReportsHeader."Summary Page Caption":=ACAResultsStatus."Summary Page Caption";
                            // // // // // // // // //                    ACASenateReportsHeader."Include Failed Units Headers":=ACAResultsStatus."Include Failed Units Headers";
                            // // // // // // // // //                    ACASenateReportsHeader."Include Academic Year Caption":=ACAResultsStatus."Include Academic Year Caption";
                            // // // // // // // // //                    ACASenateReportsHeader."Academic Year Text":=ACAResultsStatus."Academic Year Text";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg1":=ACAResultsStatus."Status Msg1";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg2":=ACAResultsStatus."Status Msg2";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg3":=ACAResultsStatus."Status Msg3";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg4":=ACAResultsStatus."Status Msg4";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg5":=ACAResultsStatus."Status Msg5";
                            // // // // // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 1":=ACAResultsStatus."Grad. Status Msg 1";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 2":=ACAResultsStatus."Grad. Status Msg 2";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 3":=ACAResultsStatus."Grad. Status Msg 3";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 4":=ACAResultsStatus."Grad. Status Msg 4";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 5":=ACAResultsStatus."Grad. Status Msg 5";
                            // // // // // // // // //                    ACASenateReportsHeader."Grad. Status Msg 6":=ACAResultsStatus."Grad. Status Msg 6";
                            // // // // // // // // //                    ACASenateReportsHeader."Finalists Graduation Comments":=ACAResultsStatus."Finalists Grad. Comm. Degree";
                            // // // // // // // // //                    ACASenateReportsHeader."1st Year Grad. Comments":=ACAResultsStatus."1st Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."2nd Year Grad. Comments":=ACAResultsStatus."2nd Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."3rd Year Grad. Comments":=ACAResultsStatus."3rd Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."4th Year Grad. Comments":=ACAResultsStatus."4th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."5th Year Grad. Comments":=ACAResultsStatus."5th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."6th Year Grad. Comments":=ACAResultsStatus."6th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader."7th Year Grad. Comments":=ACAResultsStatus."7th Year Grad. Comments";
                            // // // // // // // // //                    ACASenateReportsHeader.INSERT;
                            // // // // // // // // //                    END;
                            // // // // // // // // //                  END;
                            // // // // // // // // //                UNTIL ACAResultsStatus.NEXT=0;
                            // // // // // // // // //              END;
                            // // // // // // //      END;
                            // // // // // // //        UNTIL ACAExamCourseRegistration.NEXT=0;
                            // // // // // // //        ProgBar2.CLOSE;
                            // // // // // // //        END;
                            // // // // // // //



                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            //......................................................................................Compute Averages Here
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////


                            // Update Averages
                            Clear(TotalRecs);
                            Clear(CountedRecs);
                            Clear(RemeiningRecs);
                            Clear(ACAExamClassificationStuds);
                            ACAExamCourseRegistration.Reset;
                            ACAExamCourseRegistration.SetFilter("Reporting Academic Year", GradAcademicYear);
                            if StudNos <> '' then
                                ACAExamCourseRegistration.SetFilter("Student Number", StudNos) else
                                ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);// Only Apply Prog & School if Student FIlter is not Applied
                            if ACAExamCourseRegistration.Find('-') then begin
                                TotalRecs := ACAExamCourseRegistration.Count;
                                RemeiningRecs := TotalRecs;
                                ProgBar2.Open('#1#####################################################\' +
                                '#2############################################################\' +
                                '#3###########################################################\' +
                                '#4############################################################\' +
                                '#5###########################################################\' +
                                '#6############################################################');
                                ProgBar2.Update(1, '3 of 3 Updating Class Items');
                                ProgBar2.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                repeat
                                begin
                                    Progyz.Reset;
                                    Progyz.SetRange(Code, ACAExamCourseRegistration.Programme);
                                    if Progyz.Find('-') then;
                                    CountedRecs += 1;
                                    RemeiningRecs -= 1;
                                    ProgBar2.Update(3, '.....................................................');
                                    ProgBar2.Update(4, 'Processed: ' + Format(CountedRecs));
                                    ProgBar2.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                    ProgBar2.Update(6, '----------------------------------------------------');
                                    ACAExamCourseRegistration.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                    "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Classified Total Marks");
                                    //   IF ACAExamCourseRegistration."Total Courses"<>0 THEN
                                    ACAExamCourseRegistration."Normal Average" := Round((ACAExamCourseRegistration.Average), 0.01, '=');
                                    // ACAExamCourseRegistration."Normal Average":=ROUND((ACAExamCourseRegistration."Total Marks"/ACAExamCourseRegistration."Total Courses"),0.01,'=');
                                    //          IF ACAExamCourseRegistration."Total Units"<>0 THEN
                                    //          ACAExamCourseRegistration."Weighted Average":=ROUND((ACAExamCourseRegistration."Total Weighted Marks"/ACAExamCourseRegistration."Total Units"),0.01,'=');
                                    if ACAExamCourseRegistration."Total Classified C. Count" <> 0 then
                                        ACAExamCourseRegistration."Classified Average" := Round((ACAExamCourseRegistration."Classified Total Marks" / ACAExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                                    if ACAExamCourseRegistration."Total Classified Units" <> 0 then
                                        ACAExamCourseRegistration."Classified W. Average" := Round((ACAExamCourseRegistration."Classified W. Total" / ACAExamCourseRegistration."Total Classified Units"), 0.01, '=');
                                    ACAExamCourseRegistration."Required Stage Units" := RequiredStageUnits(ACAExamCourseRegistration.Programme,
                                    ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Student Number");
                                    if ACAExamCourseRegistration."Required Stage Units" > ACAExamCourseRegistration."Attained Stage Units" then
                                        ACAExamCourseRegistration."Units Deficit" := ACAExamCourseRegistration."Required Stage Units" - ACAExamCourseRegistration."Attained Stage Units";
                                    ACAExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACAExamCourseRegistration."Student Number");

                                    //     IF ((ACAExamCourseRegistration."Student Number"='SC/00002/016') AND (ACAExamCourseRegistration."Academic Year"='2019/2020')) THEN
                                    //       CLEAR(Tens);
                                    ACAExamCourseRegistration."Final Classification" := GetRubRic(Progyz, ACAExamCourseRegistration);
                                    ACAExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                    ACAExamCourseRegistration."Academic Year", Progyz);
                                    ACAExamCourseRegistration."Final Classification Order" := GetRubricOrder(ACAExamCourseRegistration."Final Classification");
                                    ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                    ACAExamCourseRegistration."Academic Year", Progyz);
                                    ACAExamCourseRegistration.Classification := GetRubRic(Progyz, ACAExamCourseRegistration);

                                    // //           IF ((ACAExamCourseRegistration."Total Courses"=0) OR (ACAExamCourseRegistration."Units Deficit">0)) THEN BEGIN
                                    // //             IF ACAExamCourseRegistration.Classification='PASS LIST' THEN BEGIN
                                    // //           ACAExamCourseRegistration."Final Classification":='HALT';
                                    // //           ACAExamCourseRegistration."Final Classification Pass":=FALSE;
                                    // //           ACAExamCourseRegistration."Final Classification Order":=10;
                                    // //           ACAExamCourseRegistration.Graduating:=FALSE;
                                    // //           ACAExamCourseRegistration.Classification:='HALT';
                                    // //               END;
                                    if ACAExamCourseRegistration."Total Courses" = 0 then begin
                                        ACAExamCourseRegistration."Final Classification" := 'HALT';
                                        ACAExamCourseRegistration."Final Classification Pass" := false;
                                        ACAExamCourseRegistration."Final Classification Order" := 10;
                                        ACAExamCourseRegistration.Graduating := false;
                                        ACAExamCourseRegistration.Classification := 'HALT';
                                    end;
                                    // END;
                                    ACAExamCourseRegistration.CalcFields("Total Marks",
                       "Total Weighted Marks",
                       "Total Failed Courses",
                       "Total Failed Units",
                       "Failed Courses",
                       "Failed Units",
                       "Failed Cores",
                       "Failed Required",
                       "Failed Electives",
                       "Total Cores Done",
                       "Total Cores Passed",
                       "Total Required Done",
                       "Total Electives Done",
                       "Tota Electives Passed");
                                    ACAExamCourseRegistration.CalcFields(
                                    "Classified Electives C. Count",
                                    "Classified Electives Units",
                                    "Total Classified C. Count",
                                    "Total Classified Units",
                                    "Classified Total Marks",
                                    "Classified W. Total",
                                    "Total Failed Core Units");
                                    ACAExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study");
                                    ACAExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACAExamCourseRegistration.Programme, ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Programme Option");
                                    ACAExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration.Programme);
                                    ACAExamCourseRegistration.Modify;

                                end;
                                until ACAExamCourseRegistration.Next = 0;
                                ProgBar2.Close;
                            end;

                            ACASenateReportsHeader.Reset;
                            ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                            ACASenateReportsHeader.SetFilter("Reporting Academic Year", GradAcademicYear);
                            if ACASenateReportsHeader.Find('-') then begin
                                ProgBar22.Open('#1##########################################');
                                repeat
                                begin
                                    ProgBar22.Update(1, 'Student Number: ' + ACASenateReportsHeader."Programme Code" + ' Class: ' + ACASenateReportsHeader."Classification Code");

                                    ACASenateReportsHeader.CalcFields("School Classification Count", "School Total Passed", "School Total Passed",
"School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
"Prog. Total Count", School_AcadYear_Count, School_AcadYear_Status_Count, School_AcadYearTrans_Count);

                                    if ACASenateReportsHeader."School Total Count" > 0 then
                                        ACASenateReportsHeader."Sch. Class % Value" := Round(((ACASenateReportsHeader."School Classification Count" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."School Total Count" > 0 then
                                        ACASenateReportsHeader."School % Failed" := Round(((ACASenateReportsHeader."School Total Failed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."School Total Count" > 0 then
                                        ACASenateReportsHeader."School % Passed" := Round(((ACASenateReportsHeader."School Total Passed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');

                                    if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                        ACASenateReportsHeader."Prog. Class % Value" := Round(((ACASenateReportsHeader."Programme Classification Count" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                        ACASenateReportsHeader."Programme % Failed" := Round(((ACASenateReportsHeader."Programme Total Failed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                    if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                        ACASenateReportsHeader."Programme % Passed" := Round(((ACASenateReportsHeader."Programme Total Passed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                    ACASenateReportsHeader.Modify;
                                end;
                                until ACASenateReportsHeader.Next = 0;
                                ProgBar22.Close;
                            end;
                            // //
                            // //                CLEAR(SEQUENCES);
                            // //                CLEAR(CountedNos);
                            // //            REPEAT
                            // //              BEGIN
                            // //              CountedNos:=CountedNos+1;
                            // //              CLEAR(CurrSchool);
                            // //        ACAExamCourseRegistration.RESET;
                            // //        ACAExamCourseRegistration.SETRANGE("Year of Study",CountedNos);
                            // //        ACAExamCourseRegistration.SETRANGE("Academic Year",GradAcademicYear);
                            // //        ACAExamCourseRegistration.SETRANGE("Resit Exists",TRUE);
                            // //        ACAExamCourseRegistration.SETCURRENTKEY("Academic Year","Year of Study","Student Number");
                            // //        IF  ACAExamCourseRegistration.FIND('-') THEN BEGIN
                            // //                CLEAR(SEQUENCES);
                            // //          REPEAT
                            // //              BEGIN
                            // //              IF CurrSchool<>ACAExamCourseRegistration."School Code" THEN BEGIN
                            // //                CurrSchool:=ACAExamCourseRegistration."School Code";
                            // //                CLEAR(SEQUENCES);
                            // //
                            // //                END;
                            // //              SEQUENCES:=SEQUENCES+1;
                            // //              ACAExamCourseRegistration."Cumm. Resit Serial":=SEQUENCES;
                            // //              ACAExamCourseRegistration.MODIFY;
                            // //              END;
                            // //            UNTIL ACAExamCourseRegistration.NEXT=0;
                            // //          END;
                            // //          END;
                            // //          UNTIL CountedNos=8;

                            // //
                            // //                CLEAR(SEQUENCES);
                            // //                CLEAR(CurrStudentNo);
                            // //          ACAExamCummulativeResit.RESET;
                            // //        ACAExamCummulativeResit.SETRANGE("Academic Year",GradAcademicYear);
                            // //        ACAExamCummulativeResit.SETFILTER(Programme,ProgFIls);
                            // //        ACAExamCummulativeResit.SETCURRENTKEY(Programme,"Student Number");
                            // //        IF ACAExamCummulativeResit.FIND('-') THEN BEGIN
                            // //          REPEAT
                            // //            BEGIN
                            // //             IF CurrStudentNo<> ACAExamCummulativeResit."Student Number" THEN BEGIN
                            // //               CurrStudentNo:= ACAExamCummulativeResit."Student Number";
                            // //               SEQUENCES:=SEQUENCES+1;
                            // //
                            // //               END;
                            // //               ACAExamCummulativeResit.Serial:=SEQUENCES;
                            // //               ACAExamCummulativeResit.MODIFY;
                            // //            END;
                            // //            UNTIL ACAExamCummulativeResit.NEXT=0;
                            // //          END;








                            if GetProgFilters2(programs, Schools) <> '' then begin
                                Clear(ProgFIls);

                                // Clear CLassification For Selected Filters
                                ProgFIls := GetProgFilters2(programs, Schools);
                                ACAExamClassificationStuds.Reset;
                                ACAExamCourseRegistration.Reset;
                                ACAExamClassificationUnits.Reset;
                                if StudNos <> '' then begin
                                    ACAExamClassificationStuds.SetFilter("Student Number", StudNos);
                                    ACAExamCourseRegistration.SetRange("Student Number", StudNos);
                                    ACAExamClassificationUnits.SetRange("Student No.", StudNos);
                                end;

                                if GradAcademicYear <> '' then begin
                                    ACAExamClassificationStuds.SetFilter("Academic Year", GradAcademicYear);
                                    ACAExamCourseRegistration.SetFilter("Academic Year", GradAcademicYear);
                                    ACAExamClassificationUnits.SetFilter("Academic Year", GradAcademicYear);
                                end;

                                ACAExamClassificationStuds.SetFilter(Programme, ProgFIls);
                                ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);
                                ACAExamClassificationUnits.SetFilter(Programme, ProgFIls);
                                if ACAExamClassificationStuds.Find('-') then ACAExamClassificationStuds.DeleteAll;
                                if ACAExamCourseRegistration.Find('-') then ACAExamCourseRegistration.DeleteAll;
                                if ACAExamClassificationUnits.Find('-') then ACAExamClassificationUnits.DeleteAll;


                                ACASenateReportsHeader.Reset;
                                ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                                ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                                if (ACASenateReportsHeader.Find('-')) then ACASenateReportsHeader.DeleteAll;

                                Coregcs.Reset;
                                Coregcs.SetFilter(Programmes, ProgFIls);
                                Coregcs.SetRange("Academic Year", GradAcademicYear);
                                Coregcs.SetRange(Reversed, false);
                                Coregcs.SetFilter(Status, '<>%1', StudentUnits.Status::Alluminae);
                                if StudNos <> '' then begin
                                    Coregcs.SetFilter("Student No.", StudNos);
                                end;
                                if Coregcs.Find('-') then begin
                                    Clear(TotalRecs);
                                    Clear(RemeiningRecs);
                                    Clear(CountedRecs);
                                    TotalRecs := Coregcs.Count;
                                    RemeiningRecs := TotalRecs;
                                    // Loop through all Ungraduated Students Units
                                    Progressbar.Open('#1#####################################################\' +
                                    '#2############################################################\' +
                                    '#3###########################################################\' +
                                    '#4############################################################\' +
                                    '#5###########################################################\' +
                                    '#6############################################################');
                                    Progressbar.Update(1, 'Processing  values....');
                                    Progressbar.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                    repeat
                                    begin

                                        CountedRecs := CountedRecs + 1;
                                        RemeiningRecs := RemeiningRecs - 1;
                                        // Create Registration Unit entry if Not Exists
                                        Progressbar.Update(3, '.....................................................');
                                        Progressbar.Update(4, 'Processed: ' + Format(CountedRecs));
                                        Progressbar.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                        Progressbar.Update(6, '----------------------------------------------------');
                                        Progyz.Reset;
                                        Progyz.SetFilter(Code, Coregcs.Programmes);
                                        if Progyz.Find('-') then begin
                                        end;
                                        Clear(YosStages);
                                        if Coregcs."Year Of Study" = 0 then Coregcs.Validate(Stage);
                                        if Coregcs."Year Of Study" = 1 then
                                            YosStages := 'Y1S1|Y1S2|Y1S3|Y1S4'
                                        else
                                            if Coregcs."Year Of Study" = 2 then
                                                YosStages := 'Y2S1|Y2S2|Y2S3|Y2S4'
                                            else
                                                if Coregcs."Year Of Study" = 3 then
                                                    YosStages := 'Y3S1|Y3S2|Y3S3|Y3S4'
                                                else
                                                    if Coregcs."Year Of Study" = 4 then
                                                        YosStages := 'Y4S1|Y4S2|Y4S3|Y4S4'
                                                    else
                                                        if Coregcs."Year Of Study" = 5 then
                                                            YosStages := 'Y5S1|Y5S2|Y5S3|Y5S4'
                                                        else
                                                            if Coregcs."Year Of Study" = 6 then
                                                                YosStages := 'Y6S1|Y6S2|Y6S3|Y6S4'
                                                            else
                                                                if Coregcs."Year Of Study" = 7 then
                                                                    YosStages := 'Y7S1|Y7S2|Y7S3|Y7S4'
                                                                else
                                                                    if Coregcs."Year Of Study" = 8 then YosStages := 'Y8S1|Y8S2|Y8S3|Y8S4';

                                        ACAExamCummulativeResit.Reset;
                                        ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                        ACAExamCummulativeResit.SetRange("Academic Year", GradAcademicYear);
                                        if ACAExamCummulativeResit.Find('-') then ACAExamCummulativeResit.DeleteAll;

                                        Custos.Reset;
                                        Custos.SetRange("No.", Coregcs."Student No.");
                                        if Custos.Find('-') then;
                                        Custos.CalcFields("Senate Classification Based on");

                                        StudentUnits.Reset;
                                        StudentUnits.SetRange("Student No.", Coregcs."Student No.");
                                        if Custos."Senate Classification Based on" = Custos."Senate Classification Based on"::"Year of Study" then
                                            StudentUnits.SetFilter("Unit Stage", YosStages)
                                        else
                                            StudentUnits.SetFilter("Academic Year", Coregcs."Academic Year");

                                        if StudentUnits.Find('-') then begin //sdgfdfg

                                            repeat
                                            begin
                                                StudentUnits.CalcFields(StudentUnits."CATs Marks Exists");
                                                if StudentUnits."CATs Marks Exists" = false then begin
                                                    AcdYrs.Reset;
                                                    AcdYrs.SetRange(Code, StudentUnits."Academic Year");
                                                    AcdYrs.SetRange("Allow CATs Exempt", true);
                                                    if AcdYrs.Find('-') then begin
                                                        ExamResults.Init;
                                                        ExamResults."Student No." := StudentUnits."Student No.";
                                                        ExamResults.Programmes := StudentUnits.Programme;
                                                        ExamResults.Stage := StudentUnits.Stage;
                                                        ExamResults.Unit := StudentUnits.Unit;
                                                        ExamResults.Semester := StudentUnits.Semester;
                                                        ExamResults."Academic Year" := StudentUnits."Academic Year";
                                                        ExamResults."Reg. Transaction ID" := StudentUnits."Reg. Transacton ID";
                                                        ExamResults.ExamType := 'CAT';
                                                        ExamResults.Exam := 'CAT';
                                                        ExamResults."Exam Category" := Progyz."Exam Category";
                                                        ExamResults.Score := 0;
                                                        ExamResults."User Name" := 'AUTOPOST';
                                                        ExamResults.Insert;
                                                    end;
                                                end;
                                                ExamResults.Reset;
                                                ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                if ExamResults.Find('-') then begin
                                                    repeat
                                                    begin
                                                        if ExamResults.ExamType <> '' then begin
                                                            ExamResults.Exam := ExamResults.ExamType;
                                                            ExamResults.Modify;
                                                        end else
                                                            if ExamResults.Exam <> '' then begin
                                                                if ExamResults.ExamType = '' then begin
                                                                    //ExamResults.ExamType:=ExamResults.Exam;
                                                                    ExamResults.Rename(ExamResults."Student No.", ExamResults.Programmes, ExamResults.Stage,
                                                                    ExamResults.Unit, ExamResults.Semester, ExamResults.Exam, ExamResults."Reg. Transaction ID", ExamResults."Entry No");
                                                                end;
                                                            end;
                                                    end;
                                                    until ExamResults.Next = 0;
                                                end;
                                                ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                                ExamResults.Reset;
                                                ExamResults.SetFilter("Counted Occurances", '>%1', 1);
                                                ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                if ExamResults.Find('-') then begin
                                                    repeat
                                                    begin
                                                        ACAExamResultsFin.Reset;
                                                        ACAExamResultsFin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResultsFin.SetRange(Programmes, StudentUnits.Programme);
                                                        ACAExamResultsFin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResultsFin.SetRange(Semester, StudentUnits.Semester);
                                                        ACAExamResultsFin.SetRange(ExamType, ExamResults.ExamType);
                                                        if ACAExamResultsFin.Find('-') then begin
                                                            ACAExamResultsFin.CalcFields("Counted Occurances");
                                                            if ACAExamResultsFin."Counted Occurances" > 1 then begin
                                                                ACAExamResultsFin.Delete;
                                                            end;
                                                        end;
                                                    end;
                                                    until ExamResults.Next = 0;
                                                end;
                                                ////////////////////////////////// Remove Multiple Occurances of a Mark
                                                ////////////////////////////////////////////////////////////////////////////
                                                // Grad Headers

                                                ACAResultsStatus.Reset;
                                                ACAResultsStatus.SetRange("Special Programme Class", Progyz."Special Programme Class");
                                                ACAResultsStatus.SetRange("Academic Year", GradAcademicYear);
                                                if ACAResultsStatus.Find('-') then begin
                                                    repeat
                                                    begin
                                                        ACASenateReportsHeader.Reset;
                                                        ACASenateReportsHeader.SetRange("Academic Year", GradAcademicYear);
                                                        ACASenateReportsHeader.SetRange("School Code", Progyz."School Code");
                                                        ACASenateReportsHeader.SetRange("Classification Code", ACAResultsStatus.Code);
                                                        ACASenateReportsHeader.SetRange("Programme Code", Progyz.Code);
                                                        ACASenateReportsHeader.SetRange("Year of Study", Coregcs."Year Of Study");
                                                        if not (ACASenateReportsHeader.Find('-')) then begin
                                                            ACASenateReportsHeader.Init;
                                                            ACASenateReportsHeader."Academic Year" := GradAcademicYear;
                                                            ACASenateReportsHeader."Reporting Academic Year" := GradAcademicYear;
                                                            ACASenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                                                            ACASenateReportsHeader."Programme Code" := Progyz.Code;
                                                            ACASenateReportsHeader."School Code" := Progyz."School Code";
                                                            ACASenateReportsHeader."Year of Study" := Coregcs."Year Of Study";
                                                            ACASenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                                                            ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                            ACASenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                                                            ACASenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                                                            ACASenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                                                            ACASenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                                                            ACASenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                                                            ACASenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                                                            ACASenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                                                            ACASenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                                                            ACASenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                                                            ACASenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                                                            ACASenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                                                            ACASenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                                                            ACASenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                                                            ACASenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                                                            ACASenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                                                            ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                            ACASenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                                                            ACASenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                                                            ACASenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                                                            ACASenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                                                            ACASenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                                                            ACASenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                                                            ACASenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                                                            ACASenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                                                            ACASenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                                                            ACASenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                                                            ACASenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                                                            ACASenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                                                            ACASenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                                                            ACASenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                                                            ACASenateReportsHeader.Insert;
                                                        end;
                                                    end;
                                                    until ACAResultsStatus.Next = 0;
                                                end;
                                                ////////////////////////////////////////////////////////////////////////////
                                                ACAExamClassificationStuds.Reset;
                                                ACAExamClassificationStuds.SetRange("Student Number", StudentUnits."Student No.");
                                                ACAExamClassificationStuds.SetRange(Programme, StudentUnits.Programme);
                                                ACAExamClassificationStuds.SetRange("Academic Year", GradAcademicYear);
                                                ACAExamClassificationStuds.SetRange("Reporting Academic Year", GradAcademicYear);
                                                if not ACAExamClassificationStuds.Find('-') then begin
                                                    ACAExamClassificationStuds.Init;
                                                    ACAExamClassificationStuds."Student Number" := StudentUnits."Student No.";
                                                    ACAExamClassificationStuds."Reporting Academic Year" := GradAcademicYear;
                                                    ACAExamClassificationStuds."School Code" := Progyz."School Code";
                                                    ACAExamClassificationStuds.Department := Progyz."Department Code";
                                                    ACAExamClassificationStuds."Programme Option" := Coregcs.Options;
                                                    ACAExamClassificationStuds.Programme := StudentUnits.Programme;
                                                    ACAExamClassificationStuds."Academic Year" := Coregcs."Academic Year";
                                                    ACAExamClassificationStuds."Year of Study" := GetYearOfStudy(StudentUnits.Stage);
                                                    //ACAExamClassificationStuds."Department Name":=GetDepartmentNameOrSchool(Progyz."Department Code");
                                                    ACAExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
                                                    ACAExamClassificationStuds."Student Name" := GetStudentName(StudentUnits."Student No.");
                                                    ACAExamClassificationStuds.Cohort := GetCohort(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Final Stage" := GetFinalStage(StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Admission Date" := GetAdmissionDate(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                                    ACAExamClassificationStuds.Graduating := false;
                                                    ACAExamClassificationStuds.Classification := '';
                                                    if ACAExamClassificationStuds.Insert then;
                                                    // //
                                                    // //          ACAExamCummulativeResit.RESET;
                                                    // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                    // //        ACAExamCummulativeResit.SETRANGE("Academic Year",ACAExamClassificationStuds."Academic Year");
                                                    // //        IF ACAExamCummulativeResit.FIND('-') THEN ACAExamCummulativeResit.DELETEALL;
                                                    // //
                                                    // //        ACAStudentUnitsForResits.RESET;
                                                    // //        ACAStudentUnitsForResits.SETRANGE("Student No.",StudentUnits."Student No.");
                                                    // //        ACAStudentUnitsForResits.SETRANGE("Reg. Reversed",FALSE);
                                                    // //        IF ACAStudentUnitsForResits.FIND('-') THEN BEGIN
                                                    // //          REPEAT
                                                    // //              BEGIN
                                                    // //                ACAStudentUnitsForResits.CALCFIELDS("EXAMs Marks","CATs Marks","CATs Marks Exists","EXAMs Marks Exists");
                                                    // //                IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                    // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE) OR
                                                    // //                   (((GetUnitPassStatus((GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                    // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme)),
                                                    // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme))=FALSE))) THEN BEGIN
                                                    // //      UnitsSubjects.RESET;
                                                    // //      UnitsSubjects.SETRANGE("Programme Code",ACAStudentUnitsForResits.Programme);
                                                    // //      UnitsSubjects.SETRANGE(Code,ACAStudentUnitsForResits.Unit);
                                                    // //      IF UnitsSubjects.FIND('-') THEN BEGIN
                                                    // //        IF NOT (GetYearOfStudy(UnitsSubjects."Stage Code")>Coregcs."Year Of Study") THEN BEGIN
                                                    // //          ACAExamCummulativeResit.RESET;
                                                    // //        ACAExamCummulativeResit.SETRANGE("Student Number",StudentUnits."Student No.");
                                                    // //        ACAExamCummulativeResit.SETRANGE("Unit Code",ACAStudentUnitsForResits.Unit);
                                                    // //        ACAExamCummulativeResit.SETRANGE("Academic Year",ACAExamClassificationStuds."Academic Year");
                                                    // //        IF NOT (ACAExamCummulativeResit.FIND('-')) THEN BEGIN
                                                    // //            ACAExamCummulativeResit.INIT;
                                                    // //            ACAExamCummulativeResit."Student Number":=StudentUnits."Student No.";
                                                    // //            ACAExamCummulativeResit."School Code":=ACAExamClassificationStuds."School Code";
                                                    // //            ACAExamCummulativeResit."Academic Year":=ACAExamClassificationStuds."Academic Year";
                                                    // //            ACAExamCummulativeResit."Unit Code":=ACAStudentUnitsForResits.Unit;
                                                    // //            ACAExamCummulativeResit."Student Name":=ACAExamClassificationStuds."Student Name";
                                                    // //            ACAExamCummulativeResit.Programme:=ACAExamClassificationStuds.Programme;
                                                    // //            ACAExamCummulativeResit."School Name":=ACAExamClassificationStuds."School Name";
                                                    // //            ACAExamCummulativeResit."Unit Description":=UnitsSubjects.Desription;
                                                    // //            ACAExamCummulativeResit."Credit Hours":=UnitsSubjects."Credit Hours";
                                                    // //            IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Core THEN
                                                    // //              ACAExamCummulativeResit."Unit Type":='CORE'
                                                    // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Required THEN
                                                    // //              ACAExamCummulativeResit."Unit Type":='Required'
                                                    // //            ELSE IF UnitsSubjects."Unit Type"=UnitsSubjects."Unit Type"::Elective THEN
                                                    // //              ACAExamCummulativeResit."Unit Type":='Elective';
                                                    // //
                                                    // //            ACAExamCummulativeResit.Score:=ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks";
                                                    // //            IF ((ACAStudentUnitsForResits."CATs Marks Exists"=FALSE) OR
                                                    // //                  (ACAStudentUnitsForResits."EXAMs Marks Exists"=FALSE)) THEN
                                                    // //            ACAExamCummulativeResit.Grade:='!' ELSE
                                                    // //            ACAExamCummulativeResit.Grade:=GetGrade((ACAStudentUnitsForResits."EXAMs Marks"+ACAStudentUnitsForResits."CATs Marks"),
                                                    // //              ACAStudentUnitsForResits.Unit,ACAExamClassificationStuds.Programme);
                                                    // //              IF ACAExamCummulativeResit.Grade<>'' THEN
                                                    // //            IF ACAExamCummulativeResit.INSERT THEN;
                                                    // //
                                                    // //            END;
                                                    // //            END;
                                                    // //        END;
                                                    // //        END;
                                                    // //              END;
                                                    // //              END;
                                                    // //            UNTIL ACAStudentUnitsForResits.NEXT=0;
                                                    // //          END;
                                                    // Pick all Resits for the Student
                                                end;
                                                /////////////////////////////////////// YoS Tracker

                                                Progyz.Reset;
                                                if Progyz.Get(Coregcs.Programmes) then;
                                                ACAExamCourseRegistration.Reset;
                                                ACAExamCourseRegistration.SetRange("Student Number", StudentUnits."Student No.");
                                                ACAExamCourseRegistration.SetRange(Programme, StudentUnits.Programme);
                                                ACAExamCourseRegistration.SetRange("Year of Study", Coregcs."Year Of Study");
                                                ACAExamCourseRegistration.SetRange("Academic Year", GradAcademicYear);
                                                ACAExamCourseRegistration.SetRange("Reporting Academic Year", GradAcademicYear);
                                                if not ACAExamCourseRegistration.Find('-') then begin
                                                    ACAExamCourseRegistration.Init;
                                                    ACAExamCourseRegistration."Student Number" := StudentUnits."Student No.";
                                                    ACAExamCourseRegistration.Programme := StudentUnits.Programme;
                                                    ACAExamCourseRegistration."Year of Study" := Coregcs."Year Of Study";
                                                    ACAExamCourseRegistration."Reporting Academic Year" := Coregcs."Academic Year";
                                                    ACAExamCourseRegistration."Academic Year" := Coregcs."Academic Year";
                                                    ACAExamCourseRegistration."School Code" := Progyz."School Code";
                                                    ACAExamCourseRegistration."Programme Option" := Coregcs.Options;
                                                    // ACAExamCourseRegistration.Department:=Progyz."Department Code";
                                                    // ACAExamCourseRegistration."Department Name":=ACAExamClassificationStuds."Department Name";
                                                    ACAExamCourseRegistration."School Name" := ACAExamClassificationStuds."School Name";
                                                    ACAExamCourseRegistration."Student Name" := ACAExamClassificationStuds."Student Name";
                                                    ACAExamCourseRegistration.Cohort := ACAExamClassificationStuds.Cohort;
                                                    ACAExamCourseRegistration."Final Stage" := ACAExamClassificationStuds."Final Stage";
                                                    ACAExamCourseRegistration."Final Academic Year" := ACAExamClassificationStuds."Final Academic Year";
                                                    ACAExamCourseRegistration."Final Year of Study" := ACAExamClassificationStuds."Final Year of Study";
                                                    ACAExamCourseRegistration."Admission Date" := ACAExamClassificationStuds."Admission Date";
                                                    ACAExamCourseRegistration."Admission Academic Year" := ACAExamClassificationStuds."Admission Academic Year";

                                                    if ((Progyz.Category = Progyz.Category::Certificate) or
                                                       (Progyz.Category = Progyz.Category::"Course List") or
                                                       (Progyz.Category = Progyz.Category::Professional)) then begin
                                                        ACAExamCourseRegistration."Category Order" := 2;
                                                    end else
                                                        if (Progyz.Category = Progyz.Category::Diploma) then begin
                                                            ACAExamCourseRegistration."Category Order" := 3;
                                                        end else
                                                            if (Progyz.Category = Progyz.Category::Postgraduate) then begin
                                                                ACAExamCourseRegistration."Category Order" := 4;
                                                            end else
                                                                if (Progyz.Category = Progyz.Category::Undergraduate) then begin
                                                                    ACAExamCourseRegistration."Category Order" := 1;
                                                                end;
                                                    ACAExamCourseRegistration.Graduating := false;
                                                    ACAExamCourseRegistration.Classification := '';
                                                    if ACAExamCourseRegistration.Insert then;
                                                end;
                                                /////////////////////////////////////// end of YoS Tracker
                                                ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                                ExamResults.Reset;
                                                ExamResults.SetFilter("Counted Occurances", '>%1', 1);
                                                ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                if ExamResults.Find('-') then begin
                                                    repeat
                                                    begin
                                                        ACAExamResultsFin.Reset;
                                                        ACAExamResultsFin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResultsFin.SetRange(Programmes, StudentUnits.Programme);
                                                        ACAExamResultsFin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResultsFin.SetRange(Semester, StudentUnits.Semester);
                                                        ACAExamResultsFin.SetRange(ExamType, ExamResults.ExamType);
                                                        if ACAExamResultsFin.Find('-') then begin
                                                            ACAExamResultsFin.CalcFields("Counted Occurances");
                                                            if ACAExamResultsFin."Counted Occurances" > 1 then begin
                                                                ACAExamResultsFin.Delete;
                                                            end;
                                                        end;
                                                    end;
                                                    until ExamResults.Next = 0;
                                                end;
                                                ////////////////////////////////// Remove Multiple Occurances of a Mark
                                                //Get best CAT Marks
                                                StudentUnits."Unit not in Catalogue" := false;

                                                UnitsSubjects.Reset;
                                                UnitsSubjects.SetRange("Programme Code", StudentUnits.Programme);
                                                UnitsSubjects.SetRange(Code, StudentUnits.Unit);
                                                if UnitsSubjects.Find('-') then begin

                                                    ACAExamClassificationUnits.Reset;
                                                    ACAExamClassificationUnits.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamClassificationUnits.SetRange(Programme, StudentUnits.Programme);
                                                    ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                    ACAExamClassificationUnits.SetRange("Reporting Academic Year", GradAcademicYear);
                                                    ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                    if not ACAExamClassificationUnits.Find('-') then begin
                                                        ACAExamClassificationUnits.Init;
                                                        ACAExamClassificationUnits."Student No." := StudentUnits."Student No.";
                                                        ACAExamClassificationUnits.Programme := StudentUnits.Programme;
                                                        ACAExamClassificationUnits."Reporting Academic Year" := GradAcademicYear;
                                                        ACAExamClassificationUnits."School Code" := Progyz."School Code";
                                                        // //            ACAExamClassificationUnits."Department Code":=Progyz."Department Code";
                                                        ACAExamClassificationUnits."Unit Code" := StudentUnits.Unit;
                                                        ACAExamClassificationUnits."Credit Hours" := UnitsSubjects."Credit Hours";
                                                        ACAExamClassificationUnits."Unit Type" := Format(UnitsSubjects."Unit Type");
                                                        ACAExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                                        //            IF ACACourseRegistration."Year Of Study"=0 THEN
                                                        //              ACACourseRegistration."Year Of Study":=GetYearOfStudy(ACACourseRegistration.Stage);
                                                        ACAExamClassificationUnits."Year of Study" := ACAExamCourseRegistration."Year of Study";
                                                        ACAExamClassificationUnits."Academic Year" := GradAcademicYear;

                                                        ExamResults.Reset;
                                                        ExamResults.SetRange("Student No.", StudentUnits."Student No.");
                                                        ExamResults.SetRange(Unit, StudentUnits.Unit);
                                                        if ExamResults.Find('-') then begin
                                                            ExamResults.CalcFields("Number of Repeats", "Number of Resits");
                                                            if ExamResults."Number of Repeats" > 0 then
                                                                ACAExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                                            if ExamResults."Number of Resits" > 0 then
                                                                ACAExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                                        end;

                                                        if ACAExamClassificationUnits.Insert then;
                                                    end;

                                                    /////////////////////////// Update Unit Score
                                                    ACAExamClassificationUnits.Reset;
                                                    ACAExamClassificationUnits.SetRange("Student No.", StudentUnits."Student No.");
                                                    ACAExamClassificationUnits.SetRange(Programme, StudentUnits.Programme);
                                                    ACAExamClassificationUnits.SetRange("Unit Code", StudentUnits.Unit);
                                                    ACAExamClassificationUnits.SetRange("Academic Year", GradAcademicYear);
                                                    ACAExamClassificationUnits.SetRange("Reporting Academic Year", GradAcademicYear);
                                                    if ACAExamClassificationUnits.Find('-') then begin
                                                        // //
                                                        // //              ClassStudentUnits.RESET;
                                                        // //              ClassStudentUnits.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                        // //              ClassStudentUnits.SETRANGE(Programme,ACAExamClassificationUnits.Programme);
                                                        // //            //  ClassStudentUnits.SETRANGE("Reg Reversed",FALSE);
                                                        // //              ClassStudentUnits.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                        // //              IF ClassStudentUnits.FIND('+') THEN BEGIN
                                                        StudentUnits.CalcFields("EXAMs Marks", "CATs Marks", "CATs Marks Exists", "EXAMs Marks Exists");
                                                        //Get CAT Marks
                                                        // //                ClassExamResults.RESET;
                                                        // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                        // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                        // //                ClassExamResults.SETFILTER(Exam,'%1|%2','ASSIGNMENT','CAT');
                                                        // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                        // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                        // // // // // // //              IF StudentUnits."CATs Marks Exists" THEN BEGIN
                                                        // // // // // // //                  ACAExamClassificationUnits."CAT Score":=FORMAT(StudentUnits."CATs Marks");
                                                        // // // // // // //                  ACAExamClassificationUnits."CAT Score Decimal":=StudentUnits."CATs Marks";
                                                        // // // // // // //                    END;
                                                        // // // // // // // // //                  END;
                                                        // // // // // // //              //Get Exam Marks
                                                        // // // // // // // // //                ClassExamResults.RESET;
                                                        // // // // // // // // //                ClassExamResults.SETRANGE("Student No.",ACAExamClassificationUnits."Student No.");
                                                        // // // // // // // // //                ClassExamResults.SETRANGE(Unit,ACAExamClassificationUnits."Unit Code");
                                                        // // // // // // // // //                ClassExamResults.SETFILTER(Exam,'%1|%2|%3|%4','EXAM','EXAM100','EXAMS','FINAL EXAM');
                                                        // // // // // // // // //                ClassExamResults.SETCURRENTKEY(Semester);
                                                        // // // // // // // // //                IF ClassExamResults.FIND('+') THEN BEGIN
                                                        // // // // // // //              IF StudentUnits."EXAMs Marks Exists" THEN BEGIN
                                                        // // // // // // //                  ACAExamClassificationUnits."Exam Score":=FORMAT(StudentUnits."EXAMs Marks");
                                                        // // // // // // //                  ACAExamClassificationUnits."Exam Score Decimal":=StudentUnits."EXAMs Marks";
                                                        // // // // // // //                  END;
                                                        // //                  END;

                                                        //  IF ACAExamClassificationUnits."Exam Score"='' THEN BEGIN
                                                        ACAExamResults_Fin.Reset;
                                                        ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResults_Fin.SetFilter(Exam, '%1|%2|%3|%4', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM');
                                                        ACAExamResults_Fin.SetCurrentKey(Score);
                                                        if ACAExamResults_Fin.Find('+') then begin
                                                            ACAExamClassificationUnits."Exam Score" := Format(ACAExamResults_Fin.Score);
                                                            ACAExamClassificationUnits."Exam Score Decimal" := ACAExamResults_Fin.Score;
                                                        end;
                                                        //     END;

                                                        //   IF ACAExamClassificationUnits."CAT Score"='' THEN BEGIN
                                                        ACAExamResults_Fin.Reset;
                                                        ACAExamResults_Fin.SetRange("Student No.", StudentUnits."Student No.");
                                                        ACAExamResults_Fin.SetRange(Unit, StudentUnits.Unit);
                                                        ACAExamResults_Fin.SetFilter(Exam, '%1|%2', 'ASSIGNMENT', 'CAT');
                                                        ACAExamResults_Fin.SetCurrentKey(Score);
                                                        if ACAExamResults_Fin.Find('+') then begin
                                                            ACAExamClassificationUnits."CAT Score" := Format(ACAExamResults_Fin.Score);
                                                            ACAExamClassificationUnits."CAT Score Decimal" := ACAExamResults_Fin.Score;
                                                        end;
                                                        // END;

                                                        //Update Total Marks
                                                        if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                            // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                            // //                    ACAExamClassificationUnits.Grade:='?';
                                                            // //                    ACAExamClassificationUnits."Grade Comment":='MISSED';
                                                            // //                    ACAExamClassificationUnits."Comsolidated Prefix":='?';
                                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                                        end else
                                                            if ((ACAExamClassificationUnits."Exam Score" = '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                                // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                                // //                    ACAExamClassificationUnits.Grade:='!';
                                                                // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                                // //                    ACAExamClassificationUnits."Comsolidated Prefix":='c';
                                                                ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                                            end else
                                                                if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" = '')) then begin
                                                                    // //                    ACAExamClassificationUnits.Pass:=FALSE;
                                                                    // //                    ACAExamClassificationUnits.Grade:='!';
                                                                    // //                    ACAExamClassificationUnits."Grade Comment":='INCOMPLETE';
                                                                    // //                    ACAExamClassificationUnits."Comsolidated Prefix":='e';
                                                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                                                end else
                                                                    if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                                                    end;

                                                        if ((ACAExamClassificationUnits."Exam Score" <> '') and (ACAExamClassificationUnits."CAT Score" <> '')) then begin
                                                            // //                 ACAExamClassificationUnits."Grade Comment":=GetGradeComment(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                            ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                            ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                            ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                            // //                  ACAExamClassificationUnits.Grade:=GetGrade(ACAExamClassificationUnits."Total Score Decimal",ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                            // //                  ACAExamClassificationUnits.Pass:=GetUnitPassStatus(ACAExamClassificationUnits.Grade,ACAExamClassificationUnits."Unit Code",ACAExamClassificationUnits.Programme);
                                                            // //                  IF ACAExamClassificationUnits.Pass=FALSE THEN BEGIN
                                                            // //                    ACAExamClassificationUnits."Comsolidated Prefix":='^';
                                                            //END;
                                                        end else begin
                                                            ACAExamClassificationUnits."Total Score" := Format(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal");
                                                            ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                                            ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal";
                                                        end;
                                                        ACAExamClassificationUnits."Allow In Graduate" := true;

                                                        /// Update Cummulative Resit
                                                        ACAExamClassificationUnits.CalcFields(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                                                        if not (ACAExamClassificationUnits.Pass) then begin
                                                            ACAExamCummulativeResit.Reset;
                                                            ACAExamCummulativeResit.SetRange("Student Number", StudentUnits."Student No.");
                                                            ACAExamCummulativeResit.SetRange("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                            ACAExamCummulativeResit.SetRange("Academic Year", Coregcs."Academic Year");
                                                            if not (ACAExamCummulativeResit.Find('-')) then begin
                                                                ACAExamCummulativeResit.Init;
                                                                ACAExamCummulativeResit."Student Number" := StudentUnits."Student No.";
                                                                ACAExamCummulativeResit."School Code" := ACAExamClassificationStuds."School Code";
                                                                ACAExamCummulativeResit."Academic Year" := StudentUnits."Academic Year";
                                                                ACAExamCummulativeResit."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                                                ACAExamCummulativeResit."Student Name" := ACAExamClassificationStuds."Student Name";
                                                                ACAExamCummulativeResit.Programme := StudentUnits.Programme;
                                                                ACAExamCummulativeResit."School Name" := ACAExamClassificationStuds."School Name";
                                                                ACAExamCummulativeResit."Unit Description" := UnitsSubjects.Desription;
                                                                ACAExamCummulativeResit."Credit Hours" := UnitsSubjects."Credit Hours";
                                                                ACAExamCummulativeResit."Unit Type" := ACAExamClassificationUnits."Unit Type";
                                                                ACAExamCummulativeResit.Score := ACAExamClassificationUnits."Total Score Decimal";
                                                                ACAExamCummulativeResit.Grade := ACAExamClassificationUnits.Grade;
                                                                if ACAExamCummulativeResit.Insert then;
                                                            end;
                                                        end;
                                                        if ACAExamClassificationUnits.Modify then;
                                                        //////////////////////////// Update Units Scores.. End
                                                    end else begin
                                                        StudentUnits."Unit not in Catalogue" := true;
                                                    end;
                                                end;
                                                StudentUnits.Modify;
                                                ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii End of Finalize Units
                                            end;
                                            until StudentUnits.Next = 0;
                                        end;
                                    end;
                                    until Coregcs.Next = 0;
                                    Progressbar.Close;
                                end;



                                // // // // // //Update Senate Header
                                // // // // //
                                // // // // //            ACASenateReportsHeader.RESET;
                                // // // // //            ACASenateReportsHeader.SETFILTER("Programme Code",ProgFIls);
                                // // // // //            ACASenateReportsHeader.SETFILTER("Reporting Academic Year",GradAcademicYear);
                                // // // // //            IF ACASenateReportsHeader.FIND('-') THEN ACASenateReportsHeader.DELETEALL;
                                // // // // //
                                // // // // // ACAExamCourseRegistration.RESET;
                                // // // // // ACAExamCourseRegistration.SETFILTER(Programme,ProgFIls);
                                // // // // // ACAExamCourseRegistration.SETFILTER("Academic Year",GradAcademicYear);
                                // // // // // IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                                // // // // //  TotalRecs:=ACAExamCourseRegistration.COUNT;
                                // // // // //  RemeiningRecs:=TotalRecs;
                                // // // // //  ProgBar2.OPEN('#1#####################################################\'+
                                // // // // //  '#2############################################################\'+
                                // // // // //  '#3###########################################################\'+
                                // // // // //  '#4############################################################\'+
                                // // // // //  '#5###########################################################\'+
                                // // // // //  '#6############################################################');
                                // // // // //     ProgBar2.UPDATE(1,'2 of 3 Updating Class Items');
                                // // // // //     ProgBar2.UPDATE(2,'Total Recs.: '+FORMAT(TotalRecs));
                                // // // // //    REPEAT
                                // // // // //      BEGIN
                                // // // // // ACAExamFailedReasons.RESET;
                                // // // // // ACAExamFailedReasons.SETRANGE("Student No.",ACAExamCourseRegistration."Student Number");
                                // // // // // IF ACAExamFailedReasons.FIND('-') THEN ACAExamFailedReasons.DELETEALL;
                                // // // // //      CountedRecs+=1;
                                // // // // //      RemeiningRecs-=1;
                                // // // // //     ProgBar2.UPDATE(3,'.....................................................');
                                // // // // //     ProgBar2.UPDATE(4,'Processed: '+FORMAT(CountedRecs));
                                // // // // //     ProgBar2.UPDATE(5,'Remaining: '+FORMAT(RemeiningRecs));
                                // // // // //     ProgBar2.UPDATE(6,'----------------------------------------------------');
                                // // // // //
                                // // // // //
                                // // // // //            ACAResultsStatus.RESET;
                                // // // // //            ACAResultsStatus.SETRANGE("Special Programme Class",Progyz."Special Programme Class");
                                // // // // //            ACAResultsStatus.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                                // // // // //            IF ACAResultsStatus.FIND('-') THEN BEGIN
                                // // // // //              REPEAT
                                // // // // //                  BEGIN
                                // // // // //                  ACASenateReportsHeader.RESET;
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Academic Year",ACAExamCourseRegistration."Academic Year");
                                // // // // //                  ACASenateReportsHeader.SETRANGE("School Code",Progyz."School Code");
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Classification Code",ACAResultsStatus.Code);
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Programme Code",Progyz.Code);
                                // // // // //                  ACASenateReportsHeader.SETRANGE("Year of Study",ACAExamCourseRegistration."Year of Study");
                                // // // // //                  IF NOT (ACASenateReportsHeader.FIND('-')) THEN BEGIN
                                // // // // //                    ACASenateReportsHeader.INIT;
                                // // // // //                    ACASenateReportsHeader."Academic Year":=ACAExamCourseRegistration."Academic Year";
                                // // // // //                    ACASenateReportsHeader."Rubric Order":=ACAResultsStatus."Order No";
                                // // // // //                    ACASenateReportsHeader."Programme Code":=Progyz.Code;
                                // // // // //                    ACASenateReportsHeader."School Code":=Progyz."School Code";
                                // // // // //                    ACASenateReportsHeader."Year of Study":=ACAExamCourseRegistration."Year of Study";
                                // // // // //                    ACASenateReportsHeader."Reporting Academic Year":=ACAExamCourseRegistration."Academic Year";
                                // // // // //                    ACASenateReportsHeader."Classification Code":=ACAResultsStatus.Code;
                                // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 1":=ACAResultsStatus."IncludeVariable 1";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 2":=ACAResultsStatus."IncludeVariable 2";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 3":=ACAResultsStatus."IncludeVariable 3";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 4":=ACAResultsStatus."IncludeVariable 4";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 5":=ACAResultsStatus."IncludeVariable 5";
                                // // // // //                    ACASenateReportsHeader."IncludeVariable 6":=ACAResultsStatus."IncludeVariable 6";
                                // // // // //                    ACASenateReportsHeader."Summary Page Caption":=ACAResultsStatus."Summary Page Caption";
                                // // // // //                    ACASenateReportsHeader."Include Failed Units Headers":=ACAResultsStatus."Include Failed Units Headers";
                                // // // // //                    ACASenateReportsHeader."Include Academic Year Caption":=ACAResultsStatus."Include Academic Year Caption";
                                // // // // //                    ACASenateReportsHeader."Academic Year Text":=ACAResultsStatus."Academic Year Text";
                                // // // // //                    ACASenateReportsHeader."Status Msg1":=ACAResultsStatus."Status Msg1";
                                // // // // //                    ACASenateReportsHeader."Status Msg2":=ACAResultsStatus."Status Msg2";
                                // // // // //                    ACASenateReportsHeader."Status Msg3":=ACAResultsStatus."Status Msg3";
                                // // // // //                    ACASenateReportsHeader."Status Msg4":=ACAResultsStatus."Status Msg4";
                                // // // // //                    ACASenateReportsHeader."Status Msg5":=ACAResultsStatus."Status Msg5";
                                // // // // //                    ACASenateReportsHeader."Status Msg6":=ACAResultsStatus."Status Msg6";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 1":=ACAResultsStatus."Grad. Status Msg 1";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 2":=ACAResultsStatus."Grad. Status Msg 2";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 3":=ACAResultsStatus."Grad. Status Msg 3";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 4":=ACAResultsStatus."Grad. Status Msg 4";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 5":=ACAResultsStatus."Grad. Status Msg 5";
                                // // // // //                    ACASenateReportsHeader."Grad. Status Msg 6":=ACAResultsStatus."Grad. Status Msg 6";
                                // // // // //                    ACASenateReportsHeader."Finalists Graduation Comments":=ACAResultsStatus."Finalists Grad. Comm. Degree";
                                // // // // //                    ACASenateReportsHeader."1st Year Grad. Comments":=ACAResultsStatus."1st Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."2nd Year Grad. Comments":=ACAResultsStatus."2nd Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."3rd Year Grad. Comments":=ACAResultsStatus."3rd Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."4th Year Grad. Comments":=ACAResultsStatus."4th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."5th Year Grad. Comments":=ACAResultsStatus."5th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."6th Year Grad. Comments":=ACAResultsStatus."6th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader."7th Year Grad. Comments":=ACAResultsStatus."7th Year Grad. Comments";
                                // // // // //                    ACASenateReportsHeader.INSERT;
                                // // // // //                    END;
                                // // // // //                  END;
                                // // // // //                UNTIL ACAResultsStatus.NEXT=0;
                                // // // // //              END;
                                // // // // //      END;
                                // // // // //        UNTIL ACAExamCourseRegistration.NEXT=0;
                                // // // // //        ProgBar2.CLOSE;
                                // // // // //        END;
                                // // // // //



                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                //......................................................................................Compute Averages Here
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////////////////


                                // Update Averages
                                Clear(TotalRecs);
                                Clear(CountedRecs);
                                Clear(RemeiningRecs);
                                Clear(ACAExamClassificationStuds);
                                ACAExamCourseRegistration.Reset;
                                ACAExamCourseRegistration.SetFilter("Reporting Academic Year", GradAcademicYear);
                                if StudNos <> '' then
                                    ACAExamCourseRegistration.SetFilter("Student Number", StudNos) else
                                    ACAExamCourseRegistration.SetFilter(Programme, ProgFIls);// Only Apply Prog & School if Student FIlter is not Applied
                                if ACAExamCourseRegistration.Find('-') then begin
                                    TotalRecs := ACAExamCourseRegistration.Count;
                                    RemeiningRecs := TotalRecs;
                                    ProgBar2.Open('#1#####################################################\' +
                                    '#2############################################################\' +
                                    '#3###########################################################\' +
                                    '#4############################################################\' +
                                    '#5###########################################################\' +
                                    '#6############################################################');
                                    ProgBar2.Update(1, '3 of 3 Updating Class Items');
                                    ProgBar2.Update(2, 'Total Recs.: ' + Format(TotalRecs));
                                    repeat
                                    begin

                                        Progyz.Reset;
                                        Progyz.SetRange(Code, ACAExamCourseRegistration.Programme);
                                        if Progyz.Find('-') then;
                                        CountedRecs += 1;
                                        RemeiningRecs -= 1;
                                        ProgBar2.Update(3, '.....................................................');
                                        ProgBar2.Update(4, 'Processed: ' + Format(CountedRecs));
                                        ProgBar2.Update(5, 'Remaining: ' + Format(RemeiningRecs));
                                        ProgBar2.Update(6, '----------------------------------------------------');
                                        ACAExamCourseRegistration.CalcFields("Total Marks", "Total Courses", "Total Weighted Marks",
                                      "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Weighted Average");
                                        //IF ACAExamCourseRegistration."Total Courses"<>0 THEN
                                        ACAExamCourseRegistration."Normal Average" := Round((ACAExamCourseRegistration.Average), 0.01, '=');
                                        // ACAExamCourseRegistration."Normal Average":=ROUND((ACAExamCourseRegistration."Total Marks"/ACAExamCourseRegistration."Total Courses"),0.01,'=');
                                        //          IF ACAExamCourseRegistration."Total Units"<>0 THEN
                                        //          ACAExamCourseRegistration."Weighted Average":=ROUND((ACAExamCourseRegistration."Total Weighted Marks"/ACAExamCourseRegistration."Total Units"),0.01,'=');
                                        if ACAExamCourseRegistration."Total Classified C. Count" <> 0 then
                                            ACAExamCourseRegistration."Classified Average" := Round((ACAExamCourseRegistration."Classified Total Marks" / ACAExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                                        if ACAExamCourseRegistration."Total Classified Units" <> 0 then
                                            ACAExamCourseRegistration."Classified W. Average" := Round((ACAExamCourseRegistration."Classified W. Total" / ACAExamCourseRegistration."Total Classified Units"), 0.01, '=');

                                        ACAExamCourseRegistration."Required Stage Units" := RequiredStageUnits(ACAExamCourseRegistration.Programme,
                                        ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Student Number");
                                        if ACAExamCourseRegistration."Required Stage Units" > ACAExamCourseRegistration."Attained Stage Units" then
                                            ACAExamCourseRegistration."Units Deficit" := ACAExamCourseRegistration."Required Stage Units" - ACAExamCourseRegistration."Attained Stage Units";
                                        ACAExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACAExamCourseRegistration."Student Number");

                                        ACAExamCourseRegistration."Final Classification" := GetRubRic(Progyz, ACAExamCourseRegistration);
                                        ACAExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                        ACAExamCourseRegistration."Academic Year", Progyz);
                                        ACAExamCourseRegistration."Final Classification Order" := GetRubricOrder(ACAExamCourseRegistration."Final Classification");
                                        ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                        ACAExamCourseRegistration."Academic Year", Progyz);
                                        ACAExamCourseRegistration.Classification := GetRubRic(Progyz, ACAExamCourseRegistration);
                                        // //           IF ((ACAExamCourseRegistration."Total Courses"=0) OR (ACAExamCourseRegistration."Units Deficit">0)) THEN BEGIN
                                        // //             IF ACAExamCourseRegistration.Classification='PASS LIST' THEN BEGIN
                                        // //           ACAExamCourseRegistration."Final Classification":='HALT';
                                        // //           ACAExamCourseRegistration."Final Classification Pass":=FALSE;
                                        // //           ACAExamCourseRegistration."Final Classification Order":=10;
                                        // //           ACAExamCourseRegistration.Graduating:=FALSE;
                                        // //           ACAExamCourseRegistration.Classification:='HALT';
                                        // //               END;
                                        if ACAExamCourseRegistration."Total Courses" = 0 then begin
                                            ACAExamCourseRegistration."Final Classification" := 'HALT';
                                            ACAExamCourseRegistration."Final Classification Pass" := false;
                                            ACAExamCourseRegistration."Final Classification Order" := 10;
                                            ACAExamCourseRegistration.Graduating := false;
                                            ACAExamCourseRegistration.Classification := 'HALT';
                                        end;
                                        //   END;
                                        ACAExamCourseRegistration.CalcFields("Total Marks",
                           "Total Weighted Marks",
                           "Total Failed Courses",
                           "Total Failed Units",
                           "Failed Courses",
                           "Failed Units",
                           "Failed Cores",
                           "Failed Required",
                           "Failed Electives",
                           "Total Cores Done",
                           "Total Cores Passed",
                           "Total Required Done",
                           "Total Electives Done",
                           "Tota Electives Passed");
                                        ACAExamCourseRegistration.CalcFields(
                                        "Classified Electives C. Count",
                                        "Classified Electives Units",
                                        "Total Classified C. Count",
                                        "Total Classified Units",
                                        "Classified Total Marks",
                                        "Classified W. Total",
                                        "Total Failed Core Units");
                                        ACAExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study");
                                        ACAExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACAExamCourseRegistration.Programme, ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Programme Option");
                                        ACAExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration.Programme);
                                        ACAExamCourseRegistration.Modify;

                                    end;
                                    until ACAExamCourseRegistration.Next = 0;
                                    ProgBar2.Close;
                                end;

                                ACASenateReportsHeader.Reset;
                                ACASenateReportsHeader.SetFilter("Programme Code", ProgFIls);
                                ACASenateReportsHeader.SetFilter("Reporting Academic Year", GradAcademicYear);
                                if ACASenateReportsHeader.Find('-') then begin
                                    ProgBar22.Open('#1##########################################');
                                    repeat
                                    begin
                                        ProgBar22.Update(1, 'Student Number: ' + ACASenateReportsHeader."Programme Code" + ' Class: ' + ACASenateReportsHeader."Classification Code");
                                        ACASenateReportsHeader.CalcFields("School Classification Count", "School Total Passed", "School Total Passed",
"School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
"Prog. Total Count");

                                        ACASenateReportsHeader.CalcFields("School Classification Count", "School Total Passed", "School Total Failed", "School Total Count",
                                        "Programme Classification Count", "Prog. Total Count", "Programme Total Failed", "Programme Total Passed");
                                        if ACASenateReportsHeader."School Total Count" > 0 then
                                            ACASenateReportsHeader."Sch. Class % Value" := Round(((ACASenateReportsHeader."School Classification Count" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."School Total Count" > 0 then
                                            ACASenateReportsHeader."School % Failed" := Round(((ACASenateReportsHeader."School Total Failed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."School Total Count" > 0 then
                                            ACASenateReportsHeader."School % Passed" := Round(((ACASenateReportsHeader."School Total Passed" / ACASenateReportsHeader."School Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                            ACASenateReportsHeader."Prog. Class % Value" := Round(((ACASenateReportsHeader."Programme Classification Count" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                            ACASenateReportsHeader."Programme % Failed" := Round(((ACASenateReportsHeader."Programme Total Failed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                        if ACASenateReportsHeader."Prog. Total Count" > 0 then
                                            ACASenateReportsHeader."Programme % Passed" := Round(((ACASenateReportsHeader."Programme Total Passed" / ACASenateReportsHeader."Prog. Total Count") * 100), 0.01, '=');
                                        ACASenateReportsHeader.Modify;
                                    end;
                                    until ACASenateReportsHeader.Next = 0;
                                    ProgBar22.Close;
                                end;
                                // //
                                // //                CLEAR(SEQUENCES);
                                // //                CLEAR(CountedNos);
                                // //            REPEAT
                                // //              BEGIN
                                // //              CountedNos:=CountedNos+1;
                                // //              CLEAR(CurrSchool);
                                // //        ACAExamCourseRegistration.RESET;
                                // //        ACAExamCourseRegistration.SETRANGE("Year of Study",CountedNos);
                                // //        ACAExamCourseRegistration.SETRANGE("Academic Year",GradAcademicYear);
                                // //        ACAExamCourseRegistration.SETRANGE("Resit Exists",TRUE);
                                // //        ACAExamCourseRegistration.SETCURRENTKEY("Academic Year","Year of Study","Student Number");
                                // //        IF  ACAExamCourseRegistration.FIND('-') THEN BEGIN
                                // //                CLEAR(SEQUENCES);
                                // //          REPEAT
                                // //              BEGIN
                                // //              IF CurrSchool<>ACAExamCourseRegistration."School Code" THEN BEGIN
                                // //                CurrSchool:=ACAExamCourseRegistration."School Code";
                                // //                CLEAR(SEQUENCES);
                                // //
                                // //                END;
                                // //              SEQUENCES:=SEQUENCES+1;
                                // //              ACAExamCourseRegistration."Cumm. Resit Serial":=SEQUENCES;
                                // //              ACAExamCourseRegistration.MODIFY;
                                // //              END;
                                // //            UNTIL ACAExamCourseRegistration.NEXT=0;
                                // //          END;
                                // //          END;
                                // //          UNTIL CountedNos=8;

                                // //
                                // //                CLEAR(SEQUENCES);
                                // //                CLEAR(CurrStudentNo);
                                // //          ACAExamCummulativeResit.RESET;
                                // //        ACAExamCummulativeResit.SETRANGE("Academic Year",GradAcademicYear);
                                // //        ACAExamCummulativeResit.SETFILTER(Programme,ProgFIls);
                                // //        ACAExamCummulativeResit.SETCURRENTKEY(Programme,"Student Number");
                                // //        IF ACAExamCummulativeResit.FIND('-') THEN BEGIN
                                // //          REPEAT
                                // //            BEGIN
                                // //             IF CurrStudentNo<> ACAExamCummulativeResit."Student Number" THEN BEGIN
                                // //               CurrStudentNo:= ACAExamCummulativeResit."Student Number";
                                // //               SEQUENCES:=SEQUENCES+1;
                                // //
                                // //               END;
                                // //               ACAExamCummulativeResit.Serial:=SEQUENCES;
                                // //               ACAExamCummulativeResit.MODIFY;
                                // //            END;
                                // //            UNTIL ACAExamCummulativeResit.NEXT=0;
                                // //          END;



                            end;
                        end;
                        until AcademicYear_Finz.Next = 0;
                    end;
                    Message('Processing completed successfully!');
                    if StrLen(programs) > 249 then programs := CopyStr(programs, 1, 249);
                    ///IF STRLEN(Semesters)>249 THEN Semesters:=COPYSTR(Semesters,1,249);
                    if StrLen(AcadYear) > 249 then GradAcademicYear := CopyStr(AcadYear, 1, 249) else GradAcademicYear := AcadYear;
                    if StrLen(Schools) > 249 then Schools := CopyStr(Schools, 1, 249);

                    UpdateFilters(UserId, programs, GradAcademicYear, Schools);
                end;

            }
            action("Process New KaRU")
            {
                ApplicationArea = All;
                Image = EncryptionKeys;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CourseRegForStoppage: Record "ACA-Course Registration";
                    AcaSpecialExamsDetails7: Record "Aca-Special Exams Details";
                    AcaSpecialExamsDetailsz: Record "Aca-Special Exams Details";
                    AcdYrs: Record "ACA-Academic Year";
                    Custos: Record Customer;
                    CountedRegistrations: Integer;
                    Coregcsz10: Record "ACA-Course Registration";
                    StudentUnits: Record "ACA-Student Units";
                    UnitsSubjects: Record "ACA-Units/Subjects";
                    Programme_Fin: Record "ACA-Programme";
                    ProgrammeStages_Fin: Record "ACA-Programme Stages";
                    AcademicYear_Fin: Record "ACA-Academic Year";
                    Semesters_Fin: Record "ACA-Semesters";
                    ExamResults: Record "ACA-Exam Results";
                    ClassSpecialExamsDetails: Record "Aca-Special Exams Details";
                    ClassCustomer: Record Customer;
                    ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
                    ClassDimensionValue: Record "Dimension Value";
                    ClassGradingSystem: Record "ACA-Grading System";
                    ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
                    ClassExamResults2: Record "ACA-Exam Results";
                    TotalRecs: Integer;
                    CountedRecs: Integer;
                    RemeiningRecs: Integer;
                    ExpectedElectives: Integer;
                    CountedElectives: Integer;
                    ProgBar2: Dialog;
                    Progyz: Record "ACA-Programme";
                    ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
                    ACAExamClassificationUnits: Record "ACA-Exam Classification Units";
                    ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
                    ACAExamFailedReasons: Record "ACA-Exam Failed Reasons";
                    ACASenateReportsHeader: Record "ACA-Senate Reports Header";
                    ACAExamClassificationStuds: Record "ACA-Exam Classification Studs";
                    ACAExamClassificationStudsCheck: Record "ACA-Exam Classification Studs";
                    ACAExamResultsFin: Record "ACA-Exam Results";
                    ACAResultsStatus: Record "ACA-Results Status";
                    ProgressForCoReg: Dialog;
                    Tens: Text;
                    ACASemesters: Record "ACA-Semesters";
                    ACAExamResults_Fin: Record "ACA-Exam Results";
                    ProgBar22: Dialog;
                    Coregcs: Record "ACA-Course Registration";
                    ACAExamCummulativeResit: Record "ACA-Exam Cummulative Resit";
                    ACAStudentUnitsForResits: Record "ACA-Student Units";
                    SEQUENCES: Integer;
                    CurrStudentNo: Code[250];
                    CountedNos: Integer;
                    CurrSchool: Code[250];
                    AcaSpecialExamsDetails6: Record "Aca-Special Exams Details";
                    ACASenateReportsHeaderSupp: Record "ACA-SuppExam Class. Studs";
                    ProgForFilters: Record "ACA-Programme";
                    ACASenateReportsHeaderSupps: Record "ACA-SuppSenate Repo. Header";
                    xxxxxxxxxxxxxxxxxxxxx: Text[20];
                    Aca2NDSpecialExamsDetails: Record "Aca-2nd Supp. Exams Details";
                    Aca2NDSpecialExamsDetails3: Record "Aca-2nd Supp. Exams Details";
                    ACAExam2NDSuppUnits: Record "ACA-2ndExam Supp. Units";
                    Aca2ndSuppExamsResults: Record "Aca-2nd Supp. Exams Results";
                    ACA2NDExamClassificationUnits: Record "ACA-2ndSuppExam Class. Units";
                    ACA2NDExamCourseRegistration: Record "ACA-2ndSuppExam. Co. Reg.";
                    ACA2NDExamFailedReasons: Record "ACA-2ndSuppExam Fail Reasons";
                    ACA2NDSenateReportsHeader: Record "ACA-2ndSuppSenate Repo. Header";
                    ACA2NDExamClassificationStuds: Record "ACA-2ndSuppExam Class. Studs";
                    ACA2NDExamClassificationStudsCheck: Record "ACA-2ndSuppExam Class. Studs";
                    ACA2NDExamCummulativeResit: Record "ACA-2ndSuppExam Cumm. Resit";
                begin
                    //ExamsProcessing.MarksPermissions(USERID);
                    IF CONFIRM('Process Marks?', TRUE) = FALSE THEN ERROR('Cancelled by user!');
                    IF AcadYear = '' THEN ERROR('Specify Academic Year');
                    IF ((Schools = '') AND (programs = '') AND (StudNos = '')) THEN ERROR('Specify one of the following:\a. School\b. Programme\c. Student');
                    CLEAR(Coregcs);
                    CLEAR(ACASenateReportsHeader);
                    CLEAR(ACAExamClassificationUnits);
                    CLEAR(ACAExamCourseRegistration);
                    CLEAR(ACAExamClassificationStuds);
                    CLEAR(Coregcs);
                    CLEAR(ACASenateReportsHeader);
                    CLEAR(ProgFIls);
                    CLEAR(ProgForFilters);
                    ProgForFilters.RESET;
                    IF Schools <> '' THEN
                        ProgForFilters.SETFILTER("School Code", Schools) ELSE
                        IF programs <> '' THEN
                            ProgForFilters.SETFILTER(Code, programs);
                    IF ProgForFilters.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            // Clear CLassification For Selected Filters
                            ProgFIls := ProgForFilters.Code;
                            ACAExamClassificationStuds.RESET;
                            ACAExamCourseRegistration.RESET;
                            ACAExamClassificationUnits.RESET;
                            IF StudNos <> '' THEN BEGIN
                                ACAExamClassificationStuds.SETFILTER("Student Number", StudNos);
                                ACAExamCourseRegistration.SETFILTER("Student Number", StudNos);
                                ACAExamClassificationUnits.SETFILTER("Student No.", StudNos);
                            END;
                            IF AcadYear <> '' THEN BEGIN
                                ACAExamClassificationStuds.SETFILTER("Academic Year", AcadYear);
                                ACAExamCourseRegistration.SETFILTER("Academic Year", AcadYear);
                                ACAExamClassificationUnits.SETFILTER("Academic Year", AcadYear);
                            END;

                            ACAExamClassificationStuds.SETFILTER(Programme, ProgFIls);
                            ACAExamCourseRegistration.SETFILTER(Programme, ProgFIls);
                            ACAExamClassificationUnits.SETFILTER(Programme, ProgFIls);
                            IF ACAExamClassificationStuds.FIND('-') THEN ACAExamClassificationStuds.DELETEALL;
                            IF ACAExamCourseRegistration.FIND('-') THEN ACAExamCourseRegistration.DELETEALL;
                            IF ACAExamClassificationUnits.FIND('-') THEN ACAExamClassificationUnits.DELETEALL;


                            ACASenateReportsHeaderSupp.RESET;
                            ACASenateReportsHeaderSupp.SETFILTER("Academic Year", AcadYear);
                            ACASenateReportsHeaderSupp.SETFILTER(Programme, ProgFIls);
                            IF (ACASenateReportsHeaderSupp.FIND('-')) THEN ACASenateReportsHeaderSupp.DELETEALL;

                            ACASenateReportsHeader.RESET;
                            ACASenateReportsHeader.SETFILTER("Academic Year", AcadYear);
                            ACASenateReportsHeader.SETFILTER("Programme Code", ProgFIls);
                            IF (ACASenateReportsHeader.FIND('-')) THEN ACASenateReportsHeader.DELETEALL;
                            //////////////////////////////////////////////////////////////////////////////////////////////
                            CLEAR(ACA2NDExamClassificationStuds);
                            CLEAR(ACA2NDExamCourseRegistration);
                            CLEAR(ACA2NDExamClassificationUnits);
                            CLEAR(ACAExam2NDSuppUnits);
                            ACA2NDExamClassificationStuds.RESET;
                            ACA2NDExamCourseRegistration.RESET;
                            ACA2NDExamClassificationUnits.RESET;
                            ACAExam2NDSuppUnits.RESET;
                            IF StudNos <> '' THEN BEGIN
                                ACA2NDExamClassificationStuds.SETFILTER("Student Number", StudNos);
                                ACA2NDExamCourseRegistration.SETRANGE("Student Number", StudNos);
                                ACA2NDExamClassificationUnits.SETRANGE("Student No.", StudNos);
                                ACAExam2NDSuppUnits.SETRANGE("Student No.", StudNos);
                            END;
                            IF AcadYear <> '' THEN BEGIN
                                ACA2NDExamClassificationStuds.SETFILTER("Academic Year", AcadYear);
                                ACA2NDExamCourseRegistration.SETFILTER("Academic Year", AcadYear);
                                ACA2NDExamClassificationUnits.SETFILTER("Academic Year", AcadYear);
                                ACAExam2NDSuppUnits.SETFILTER("Academic Year", AcadYear);
                            END;

                            ACA2NDExamClassificationStuds.SETFILTER(Programme, ProgFIls);
                            ACA2NDExamCourseRegistration.SETFILTER(Programme, ProgFIls);
                            ACA2NDExamClassificationUnits.SETFILTER(Programme, ProgFIls);
                            ACAExam2NDSuppUnits.SETFILTER(Programme, ProgFIls);
                            IF ACA2NDExamClassificationStuds.FIND('-') THEN ACA2NDExamClassificationStuds.DELETEALL;
                            IF ACA2NDExamCourseRegistration.FIND('-') THEN ACA2NDExamCourseRegistration.DELETEALL;
                            IF ACA2NDExamClassificationUnits.FIND('-') THEN ACA2NDExamClassificationUnits.DELETEALL;
                            IF ACAExam2NDSuppUnits.FIND('-') THEN ACAExam2NDSuppUnits.DELETEALL;


                            ACA2NDSenateReportsHeader.RESET;
                            ACA2NDSenateReportsHeader.SETFILTER("Academic Year", AcadYear);
                            ACA2NDSenateReportsHeader.SETFILTER("Programme Code", ProgFIls);
                            IF (ACA2NDSenateReportsHeader.FIND('-')) THEN ACA2NDSenateReportsHeader.DELETEALL;
                            ///////////////////////////////////////////////////////////////////////////////////////////////////
                            CLEAR(Coregcs);
                            Coregcs.RESET;
                            Coregcs.SETFILTER("Academic Year", AcadYear);
                            //Coregcs.SETRANGE("Exclude from Computation",FALSE);
                            Coregcs.SETFILTER(Programmes, ProgFIls);
                            Coregcs.SETFILTER(Status, '<>%1', Coregcs.Status::Alluminae);
                            IF StudNos <> '' THEN BEGIN
                                Coregcs.SETFILTER("Student No.", StudNos);
                            END ELSE BEGIN
                            END;
                            IF Coregcs.FIND('-') THEN BEGIN
                                CLEAR(TotalRecs);
                                CLEAR(RemeiningRecs);
                                CLEAR(CountedRecs);
                                TotalRecs := Coregcs.COUNT;
                                RemeiningRecs := TotalRecs;
                                // Loop through all Ungraduated Students Units
                                Progressbar.OPEN('#1#####################################################\' +
                                '#2############################################################\' +
                                '#3###########################################################\' +
                                '#4############################################################\' +
                                '#5###########################################################\' +
                                '#6############################################################');
                                Progressbar.UPDATE(1, 'Processing  values....');
                                Progressbar.UPDATE(2, 'Total Recs.: ' + FORMAT(TotalRecs));
                                REPEAT
                                BEGIN

                                    CountedRecs := CountedRecs + 1;
                                    RemeiningRecs := RemeiningRecs - 1;
                                    // Create Registration Unit entry if Not Exists
                                    Progressbar.UPDATE(3, '.....................................................');
                                    Progressbar.UPDATE(4, 'Processed: ' + FORMAT(CountedRecs));
                                    Progressbar.UPDATE(5, 'Remaining: ' + FORMAT(RemeiningRecs));
                                    Progressbar.UPDATE(6, '----------------------------------------------------');
                                    Progyz.RESET;
                                    Progyz.SETFILTER(Code, Coregcs.Programmes);
                                    IF Progyz.FIND('-') THEN BEGIN
                                    END;
                                    CLEAR(YosStages);
                                    IF Coregcs."Year Of Study" = 0 THEN BEGIN
                                        Coregcs.VALIDATE(Stage);
                                        // Coregcs.MODIFY;
                                    END;
                                    IF Coregcs."Year Of Study" = 1 THEN
                                        YosStages := 'Y1S1|Y1S2|Y1S3|Y1S4'
                                    ELSE IF Coregcs."Year Of Study" = 2 THEN
                                        YosStages := 'Y2S1|Y2S2|Y2S3|Y2S4'
                                    ELSE IF Coregcs."Year Of Study" = 3 THEN
                                        YosStages := 'Y3S1|Y3S2|Y3S3|Y3S4'
                                    ELSE IF Coregcs."Year Of Study" = 4 THEN
                                        YosStages := 'Y4S1|Y4S2|Y4S3|Y4S4'
                                    ELSE IF Coregcs."Year Of Study" = 5 THEN
                                        YosStages := 'Y5S1|Y5S2|Y5S3|Y5S4'
                                    ELSE IF Coregcs."Year Of Study" = 6 THEN
                                        YosStages := 'Y6S1|Y6S2|Y6S3|Y6S4'
                                    ELSE IF Coregcs."Year Of Study" = 7 THEN
                                        YosStages := 'Y7S1|Y7S2|Y7S3|Y7S4'
                                    ELSE IF Coregcs."Year Of Study" = 8 THEN YosStages := 'Y8S1|Y8S2|Y8S3|Y8S4';


                                    Custos.RESET;
                                    Custos.SETRANGE("No.", Coregcs."Student No.");
                                    IF Custos.FIND('-') THEN
                                        Custos.CALCFIELDS("Senate Classification Based on");
                                    CLEAR(StudentUnits);
                                    StudentUnits.RESET;
                                    StudentUnits.SETRANGE("Student No.", Coregcs."Student No.");
                                    StudentUnits.SETRANGE("Year Of Study", Coregcs."Year Of Study");
                                    //StudentUnits.SETRANGE(Semester,Coregcs.Semester);
                                    StudentUnits.SETFILTER(Unit, '<>%1', '');

                                    CLEAR(CountedRegistrations);
                                    CLEAR(Coregcsz10);
                                    Coregcsz10.RESET;
                                    Coregcsz10.SETRANGE("Student No.", Coregcs."Student No.");
                                    Coregcsz10.SETRANGE("Year Of Study", Coregcs."Year Of Study");
                                    Coregcsz10.SETRANGE(Reversed, FALSE);
                                    Coregcsz10.SETFILTER(Stage, '..%1', Coregcs.Stage);
                                    IF Coregcsz10.FIND('-') THEN BEGIN
                                        CountedRegistrations := Coregcsz10.COUNT;
                                        IF CountedRegistrations < 2 THEN // Filter

  StudentUnits.SETRANGE(Stage, Coregcs.Stage);
                                    END;
                                    //

                                    Coregcs.CALCFIELDS("Stoppage Exists In Acad. Year", "Stoppage Exists in YoS",
                                    "Stopped Academic Year", "Stopage Yearly Remark", "Academic Year Exclude Comp.");

                                    CLEAR(CourseRegForStoppage);
                                    CourseRegForStoppage.RESET;
                                    CourseRegForStoppage.SETRANGE("Student No.", Coregcs."Student No.");
                                    CourseRegForStoppage.SETRANGE("Year Of Study", Coregcs."Year Of Study");
                                    CourseRegForStoppage.SETRANGE("Academic Year", Coregcs."Stopped Academic Year");
                                    CourseRegForStoppage.SETRANGE(Reversed, TRUE);
                                    IF CourseRegForStoppage.FIND('-') THEN
                                        CourseRegForStoppage.CALCFIELDS("Academic Year Exclude Comp.", "Combine Discordant Sem. in Yr");

                                    IF Coregcs."Stopped Academic Year" <> '' THEN BEGIN
                                        IF CourseRegForStoppage."Academic Year Exclude Comp." = FALSE THEN BEGIN
                                            IF CourseRegForStoppage."Combine Discordant Sem. in Yr" = TRUE THEN BEGIN
                                                StudentUnits.SETRANGE("Reg. Reversed", FALSE);
                                                StudentUnits.SETFILTER("Academic Year (Flow)", '=%1|=%2', Coregcs."Stopped Academic Year", Coregcs."Academic Year");
                                            END ELSE BEGIN
                                                StudentUnits.SETFILTER("Academic Year (Flow)", '=%1', Coregcs."Academic Year");
                                            END;
                                        END ELSE BEGIN
                                            StudentUnits.SETRANGE("Reg. Reversed", FALSE);
                                        END;
                                    END
                                    ELSE BEGIN
                                        StudentUnits.SETFILTER("Academic Year (Flow)", '=%1', Coregcs."Academic Year");
                                        StudentUnits.SETRANGE("Reg. Reversed", FALSE);
                                    END;
                                    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    ////////////////////////////////////////////////////////////////////////////
                                    // Grad Headers
                                    ACAResultsStatus.RESET;
                                    ACAResultsStatus.SETRANGE("Special Programme Class", Progyz."Special Programme Class");
                                    ACAResultsStatus.SETRANGE("Academic Year", Coregcs."Academic Year");
                                    IF ACAResultsStatus.FIND('-') THEN BEGIN
                                        REPEAT
                                        BEGIN
                                            ACASenateReportsHeader.RESET;
                                            ACASenateReportsHeader.SETRANGE("Academic Year", Coregcs."Academic Year");
                                            ACASenateReportsHeader.SETRANGE("School Code", Progyz."School Code");
                                            ACASenateReportsHeader.SETRANGE("Classification Code", ACAResultsStatus.Code);
                                            ACASenateReportsHeader.SETRANGE("Programme Code", Progyz.Code);
                                            ACASenateReportsHeader.SETRANGE("Year of Study", Coregcs."Year Of Study");
                                            IF NOT (ACASenateReportsHeader.FIND('-')) THEN BEGIN
                                                ACASenateReportsHeader.INIT;
                                                ACASenateReportsHeader."Academic Year" := Coregcs."Academic Year";
                                                ACASenateReportsHeader."Reporting Academic Year" := Coregcs."Academic Year";
                                                ACASenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                                                ACASenateReportsHeader."Programme Code" := Progyz.Code;
                                                ACASenateReportsHeader."School Code" := Progyz."School Code";
                                                ACASenateReportsHeader."Year of Study" := Coregcs."Year Of Study";
                                                ACASenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                                                ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                ACASenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                                                ACASenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                                                ACASenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                                                ACASenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                                                ACASenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                                                ACASenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                                                ACASenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                                                ACASenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                                                ACASenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                                                ACASenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                                                ACASenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                                                ACASenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                                                ACASenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                                                ACASenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                                                ACASenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                                                ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                                                ACASenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                                                ACASenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                                                ACASenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                                                ACASenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                                                ACASenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                                                ACASenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                                                ACASenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                                                ACASenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                                                ACASenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                                                ACASenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                                                ACASenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                                                ACASenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                                                ACASenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                                                ACASenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                                                IF ACASenateReportsHeader.INSERT THEN;
                                            END;
                                        END;
                                        UNTIL ACAResultsStatus.NEXT = 0;
                                    END;
                                    ////////////////////////////////////////////////////////////////////////////
                                    ACAExamClassificationStuds.RESET;
                                    ACAExamClassificationStuds.SETRANGE("Student Number", Coregcs."Student No.");
                                    ACAExamClassificationStuds.SETRANGE(Programme, Coregcs.Programmes);
                                    ACAExamClassificationStuds.SETRANGE("Academic Year", Coregcs."Academic Year");
                                    // ACAExamClassificationStuds.SETRANGE("Reporting Academic Year",GradAcademicYear);
                                    IF NOT ACAExamClassificationStuds.FIND('-') THEN BEGIN
                                        ACAExamClassificationStuds.INIT;
                                        ACAExamClassificationStuds."Student Number" := Coregcs."Student No.";
                                        ACAExamClassificationStuds."Reporting Academic Year" := Coregcs."Academic Year";
                                        ACAExamClassificationStuds."School Code" := Progyz."School Code";
                                        ACAExamClassificationStuds.Department := Progyz."Department Code";
                                        ACAExamClassificationStuds."Programme Option" := Coregcs.Options;
                                        ACAExamClassificationStuds.Programme := Coregcs.Programmes;
                                        ACAExamClassificationStuds."Academic Year" := Coregcs."Academic Year";
                                        ACAExamClassificationStuds."Year of Study" := Coregcs."Year Of Study";
                                        //ACAExamClassificationStuds."Department Name":=GetDepartmentNameOrSchool(Progyz."Department Code");
                                        ACAExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
                                        ACAExamClassificationStuds."Student Name" := GetStudentName(Coregcs."Student No.");
                                        ACAExamClassificationStuds.Cohort := GetCohort(Coregcs."Student No.", Coregcs.Programmes);
                                        ACAExamClassificationStuds."Final Stage" := GetFinalStage(Coregcs.Programmes);
                                        ACAExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(Coregcs."Student No.", Coregcs.Programmes);
                                        ACAExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(Coregcs.Programmes);
                                        ACAExamClassificationStuds."Admission Date" := GetAdmissionDate(Coregcs."Student No.", Coregcs.Programmes);
                                        ACAExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(Coregcs."Student No.", Coregcs.Programmes);
                                        ACAExamClassificationStuds.Graduating := FALSE;
                                        ACAExamClassificationStuds.Classification := '';
                                        IF ACAExamClassificationStuds.INSERT THEN;

                                    END;
                                    /////////////////////////////////////// YoS Tracker
                                    Progyz.RESET;
                                    IF Progyz.GET(Coregcs.Programmes) THEN;
                                    ACAExamCourseRegistration.RESET;
                                    ACAExamCourseRegistration.SETRANGE("Student Number", Coregcs."Student No.");
                                    ACAExamCourseRegistration.SETRANGE(Programme, Coregcs.Programmes);
                                    ACAExamCourseRegistration.SETRANGE("Year of Study", Coregcs."Year Of Study");
                                    ACAExamCourseRegistration.SETRANGE("Academic Year", Coregcs."Academic Year");
                                    IF NOT ACAExamCourseRegistration.FIND('-') THEN BEGIN
                                        ACAExamCourseRegistration.INIT;
                                        ACAExamCourseRegistration."Student Number" := Coregcs."Student No.";
                                        ACAExamCourseRegistration.Programme := Coregcs.Programmes;
                                        ACAExamCourseRegistration."Year of Study" := Coregcs."Year Of Study";
                                        ACAExamCourseRegistration."Reporting Academic Year" := Coregcs."Academic Year";
                                        ACAExamCourseRegistration."Academic Year" := Coregcs."Academic Year";
                                        ACAExamCourseRegistration."School Code" := Progyz."School Code";
                                        ACAExamCourseRegistration."Programme Option" := Coregcs.Options;
                                        ACAExamCourseRegistration."School Name" := ACAExamClassificationStuds."School Name";
                                        ACAExamCourseRegistration."Student Name" := ACAExamClassificationStuds."Student Name";
                                        ACAExamCourseRegistration.Cohort := ACAExamClassificationStuds.Cohort;
                                        ACAExamCourseRegistration."Final Stage" := ACAExamClassificationStuds."Final Stage";
                                        ACAExamCourseRegistration."Final Academic Year" := ACAExamClassificationStuds."Final Academic Year";
                                        ACAExamCourseRegistration."Final Year of Study" := ACAExamClassificationStuds."Final Year of Study";
                                        ACAExamCourseRegistration."Admission Date" := ACAExamClassificationStuds."Admission Date";
                                        ACAExamCourseRegistration."Admission Academic Year" := ACAExamClassificationStuds."Admission Academic Year";

                                        IF ((Progyz.Category = Progyz.Category::"Certificate") OR
                                           (Progyz.Category = Progyz.Category::"Course List") OR
                                           (Progyz.Category = Progyz.Category::Professional)) THEN BEGIN
                                            ACAExamCourseRegistration."Category Order" := 2;
                                        END ELSE IF (Progyz.Category = Progyz.Category::Diploma) THEN BEGIN
                                            ACAExamCourseRegistration."Category Order" := 3;
                                        END ELSE IF (Progyz.Category = Progyz.Category::Postgraduate) THEN BEGIN
                                            ACAExamCourseRegistration."Category Order" := 4;
                                        END ELSE IF (Progyz.Category = Progyz.Category::Undergraduate) THEN BEGIN
                                            ACAExamCourseRegistration."Category Order" := 1;
                                        END;

                                        ACAExamCourseRegistration.Graduating := FALSE;
                                        ACAExamCourseRegistration.Classification := '';
                                        IF ACAExamCourseRegistration.INSERT(TRUE) THEN;
                                    END;
                                    /////////////////////////////////////// end of YoS Tracker

                                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    IF StudentUnits.FIND('-') THEN BEGIN

                                        REPEAT
                                        BEGIN
                                            StudentUnits.CALCFIELDS(StudentUnits."CATs Marks Exists");
                                            IF StudentUnits."CATs Marks Exists" = FALSE THEN BEGIN

                                                UnitsSubjects.RESET;
                                                UnitsSubjects.SETRANGE("Programme Code", StudentUnits.Programme);
                                                UnitsSubjects.SETRANGE(Code, StudentUnits.Unit);
                                                UnitsSubjects.SETRANGE("Exempt CAT", TRUE);
                                                IF UnitsSubjects.FIND('-') THEN BEGIN
                                                    ExamResults.INIT;
                                                    ExamResults."Student No." := StudentUnits."Student No.";
                                                    ExamResults.Programmes := StudentUnits.Programme;
                                                    ExamResults.Stage := StudentUnits.Stage;
                                                    ExamResults.Unit := StudentUnits.Unit;
                                                    ExamResults.Semester := StudentUnits.Semester;
                                                    ExamResults."Academic Year" := StudentUnits."Academic Year";
                                                    ExamResults."Reg. Transaction ID" := StudentUnits."Reg. Transacton ID";
                                                    ExamResults.ExamType := 'CAT';
                                                    ExamResults.Exam := 'CAT';
                                                    ExamResults."Exam Category" := Progyz."Exam Category";
                                                    ExamResults.Score := 0;
                                                    ExamResults."User Name" := 'AUTOPOST';
                                                    IF ExamResults.INSERT THEN;
                                                END;
                                            END;
                                            // END;
                                            CLEAR(ExamResults);
                                            ExamResults.RESET;
                                            ExamResults.SETRANGE("Student No.", StudentUnits."Student No.");
                                            ExamResults.SETRANGE(Unit, StudentUnits.Unit);
                                            IF ExamResults.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    IF ExamResults.ExamType <> '' THEN BEGIN
                                                        ExamResults.Exam := ExamResults.ExamType;
                                                        ExamResults.MODIFY;
                                                    END ELSE IF ExamResults.Exam <> '' THEN BEGIN
                                                        IF ExamResults.ExamType = '' THEN BEGIN
                                                            ExamResults.RENAME(ExamResults."Student No.", ExamResults.Programmes, ExamResults.Stage,
                                                            ExamResults.Unit, ExamResults.Semester, ExamResults.Exam, ExamResults."Reg. Transaction ID", ExamResults."Entry No");
                                                        END;
                                                    END;
                                                END;
                                                UNTIL ExamResults.NEXT = 0;
                                            END;
                                            ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii Update Units
                                            CLEAR(ExamResults);
                                            ExamResults.RESET;
                                            ExamResults.SETFILTER("Counted Occurances", '>%1', 1);
                                            ExamResults.SETRANGE("Student No.", StudentUnits."Student No.");
                                            ExamResults.SETRANGE(Unit, StudentUnits.Unit);
                                            IF ExamResults.FIND('-') THEN BEGIN
                                                REPEAT
                                                BEGIN
                                                    ACAExamResultsFin.RESET;
                                                    ACAExamResultsFin.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    ACAExamResultsFin.SETRANGE(Programmes, StudentUnits.Programme);
                                                    ACAExamResultsFin.SETRANGE(Unit, StudentUnits.Unit);
                                                    ACAExamResultsFin.SETRANGE(Semester, StudentUnits.Semester);
                                                    ACAExamResultsFin.SETRANGE(ExamType, ExamResults.ExamType);
                                                    IF ACAExamResultsFin.FIND('-') THEN BEGIN
                                                        ACAExamResultsFin.CALCFIELDS("Counted Occurances");
                                                        IF ACAExamResultsFin."Counted Occurances" > 1 THEN BEGIN
                                                            ACAExamResultsFin.DELETE;
                                                        END;
                                                    END;
                                                END;
                                                UNTIL ExamResults.NEXT = 0;
                                            END;
                                            ////////////////////////////////// Remove Multiple Occurances of a Mark
                                            // Deleted Header Creation here
                                            //Get best CAT Marks
                                            StudentUnits."Unit not in Catalogue" := FALSE;

                                            UnitsSubjects.RESET;
                                            UnitsSubjects.SETRANGE("Programme Code", StudentUnits.Programme);
                                            UnitsSubjects.SETRANGE(Code, StudentUnits.Unit);
                                            IF UnitsSubjects.FIND('-') THEN BEGIN
                                                IF UnitsSubjects."Default Exam Category" = '' THEN BEGIN
                                                    UnitsSubjects."Default Exam Category" := Progyz."Exam Category";
                                                    UnitsSubjects.MODIFY;
                                                END;
                                                IF UnitsSubjects."Exam Category" = '' THEN BEGIN
                                                    UnitsSubjects."Exam Category" := Progyz."Exam Category";
                                                    UnitsSubjects.MODIFY;
                                                END;
                                                ACAExamClassificationUnits.RESET;
                                                ACAExamClassificationUnits.SETRANGE("Student No.", Coregcs."Student No.");
                                                ACAExamClassificationUnits.SETRANGE(Programme, Coregcs.Programmes);
                                                ACAExamClassificationUnits.SETRANGE("Unit Code", StudentUnits.Unit);
                                                ACAExamClassificationUnits.SETRANGE("Academic Year", Coregcs."Academic Year");
                                                IF NOT ACAExamClassificationUnits.FIND('-') THEN BEGIN
                                                    ACAExamClassificationUnits.INIT;
                                                    ACAExamClassificationUnits."Student No." := Coregcs."Student No.";
                                                    ACAExamClassificationUnits.Programme := Coregcs.Programmes;
                                                    ACAExamClassificationUnits."Reporting Academic Year" := Coregcs."Academic Year";
                                                    ACAExamClassificationUnits."School Code" := Progyz."School Code";
                                                    ACAExamClassificationUnits."Unit Code" := StudentUnits.Unit;
                                                    ACAExamClassificationUnits."Credit Hours" := UnitsSubjects."No. Units";
                                                    ACAExamClassificationUnits."Unit Type" := FORMAT(UnitsSubjects."Unit Type");
                                                    ACAExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                                    ACAExamClassificationUnits."Year of Study" := ACAExamCourseRegistration."Year of Study";
                                                    ACAExamClassificationUnits."Academic Year" := Coregcs."Academic Year";

                                                    CLEAR(ExamResults);
                                                    ExamResults.RESET;
                                                    ExamResults.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    ExamResults.SETRANGE(Unit, StudentUnits.Unit);
                                                    IF ExamResults.FIND('-') THEN BEGIN
                                                        ExamResults.CALCFIELDS("Number of Repeats", "Number of Resits");
                                                        IF ExamResults."Number of Repeats" > 0 THEN
                                                            ACAExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                                        IF ExamResults."Number of Resits" > 0 THEN
                                                            ACAExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                                    END;

                                                    IF ACAExamClassificationUnits.INSERT THEN;
                                                END;

                                                /////////////////////////// Update Unit Score
                                                ACAExamClassificationUnits.RESET;
                                                ACAExamClassificationUnits.SETRANGE("Student No.", Coregcs."Student No.");
                                                ACAExamClassificationUnits.SETRANGE(Programme, Coregcs.Programmes);
                                                ACAExamClassificationUnits.SETRANGE("Unit Code", StudentUnits.Unit);
                                                ACAExamClassificationUnits.SETRANGE("Academic Year", Coregcs."Academic Year");
                                                ACAExamClassificationUnits.SETRANGE("Reporting Academic Year", Coregcs."Academic Year");
                                                IF ACAExamClassificationUnits.FIND('-') THEN BEGIN
                                                    CLEAR(ACAExamResults_Fin);
                                                    ACAExamResults_Fin.RESET;
                                                    ACAExamResults_Fin.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    ACAExamResults_Fin.SETRANGE(Unit, StudentUnits.Unit);
                                                    ACAExamResults_Fin.SETRANGE(Semester, StudentUnits.Semester);
                                                    ACAExamResults_Fin.SETFILTER(Exam, '%1|%2|%3|%4', 'EXAM', 'EXAM100', 'EXAMS', 'FINAL EXAM');
                                                    ACAExamResults_Fin.SETCURRENTKEY(Score);
                                                    IF ACAExamResults_Fin.FIND('+') THEN BEGIN
                                                        ACAExamClassificationUnits."Exam Score" := FORMAT(ROUND(ACAExamResults_Fin.Score, 0.01, '='));
                                                        ACAExamClassificationUnits."Exam Score Decimal" := ROUND(ACAExamResults_Fin.Score, 0.01, '=');
                                                    END;
                                                    //     END;

                                                    //   IF ACAExamClassificationUnits."CAT Score"='' THEN BEGIN
                                                    CLEAR(ACAExamResults_Fin);
                                                    ACAExamResults_Fin.RESET;
                                                    ACAExamResults_Fin.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    ACAExamResults_Fin.SETRANGE(Unit, StudentUnits.Unit);
                                                    ACAExamResults_Fin.SETRANGE(Semester, StudentUnits.Semester);
                                                    ACAExamResults_Fin.SETFILTER(Exam, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                                                    ACAExamResults_Fin.SETCURRENTKEY(Score);
                                                    IF ACAExamResults_Fin.FIND('+') THEN BEGIN
                                                        ACAExamClassificationUnits."CAT Score" := FORMAT(ROUND(ACAExamResults_Fin.Score, 0.01, '='));
                                                        ACAExamClassificationUnits."CAT Score Decimal" := ROUND(ACAExamResults_Fin.Score, 0.01, '=');
                                                    END;
                                                    // END;

                                                    //Update Total Marks
                                                    IF ((ACAExamClassificationUnits."Exam Score" = '') AND (ACAExamClassificationUnits."CAT Score" = '')) THEN BEGIN
                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                                    END ELSE IF ((ACAExamClassificationUnits."Exam Score" = '') AND (ACAExamClassificationUnits."CAT Score" <> '')) THEN BEGIN
                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                                    END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (ACAExamClassificationUnits."CAT Score" = '')) THEN BEGIN
                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                                    END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (ACAExamClassificationUnits."CAT Score" <> '')) THEN BEGIN
                                                        ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                                    END;

                                                    IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (ACAExamClassificationUnits."CAT Score" <> '')) THEN BEGIN
                                                        ACAExamClassificationUnits."Total Score" := FORMAT(ROUND(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal", 0.01, '='));
                                                        ACAExamClassificationUnits."Total Score Decimal" := ROUND(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                                        ACAExamClassificationUnits."Weighted Total Score" := ROUND(ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');
                                                    END ELSE BEGIN
                                                        ACAExamClassificationUnits."Total Score" := FORMAT(ROUND(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal", 0.01, '='));
                                                        ACAExamClassificationUnits."Total Score Decimal" := ROUND(ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                                        ACAExamClassificationUnits."Weighted Total Score" := ROUND(ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');
                                                    END;
                                                    ACAExamClassificationUnits."Allow In Graduate" := TRUE;
                                                    CLEAR(AcaSpecialExamsDetailsz);
                                                    AcaSpecialExamsDetailsz.RESET;
                                                    AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                    AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                    AcaSpecialExamsDetailsz.SETFILTER(Occurance, '>%1', 1);
                                                    IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                        REPEAT
                                                        BEGIN
                                                            AcaSpecialExamsDetailsz.CALCFIELDS(Occurance);
                                                            IF ((AcaSpecialExamsDetailsz."Exam Marks" = 0) AND (AcaSpecialExamsDetailsz."Special Exam Reason" = '')) THEN AcaSpecialExamsDetailsz.DELETE;
                                                        END;
                                                        UNTIL ((AcaSpecialExamsDetailsz.NEXT = 0) OR (AcaSpecialExamsDetailsz.Occurance = 1));
                                                    END;
                                                    /// Update Cummulative Resit
                                                    CLEAR(AcaSpecialExamsDetailsz);
                                                    AcaSpecialExamsDetailsz.RESET;
                                                    AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                    AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                    IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                        CLEAR(AcaSpecialExamsDetails7);
                                                        AcaSpecialExamsDetails7.RESET;
                                                        AcaSpecialExamsDetails7.SETRANGE("Student No.", AcaSpecialExamsDetailsz."Student No.");
                                                        AcaSpecialExamsDetails7.SETRANGE("Unit Code", AcaSpecialExamsDetailsz."Unit Code");
                                                        AcaSpecialExamsDetails7.SETRANGE(Semester, StudentUnits.Semester);
                                                        IF AcaSpecialExamsDetails7.FIND('-') THEN BEGIN
                                                            IF AcaSpecialExamsDetails7."Exam Marks" = 0 THEN BEGIN
                                                            END;
                                                        END ELSE
                                                            //  IF StudentUnits.Semester <> AcaSpecialExamsDetailsz.Semester THEN
                                                            IF AcaSpecialExamsDetailsz.RENAME(AcaSpecialExamsDetailsz."Student No.", AcaSpecialExamsDetailsz."Unit Code",
                                                             AcaSpecialExamsDetailsz."Academic Year", StudentUnits.Semester, AcaSpecialExamsDetailsz.Sequence,
                                                             AcaSpecialExamsDetailsz.Category, AcaSpecialExamsDetailsz.Programme) THEN;
                                                    END;

                                                    AcaSpecialExamsDetailsz.RESET;
                                                    AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                    AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                    AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                    AcaSpecialExamsDetailsz.SETRANGE(Status, AcaSpecialExamsDetailsz.Status::New);
                                                    //AcaSpecialExamsDetailsz.SETRANGE(Semester,StudentUnits.Semester);
                                                    AcaSpecialExamsDetailsz.SETRANGE("Exam Marks", 0);
                                                    IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                        IF (AcaSpecialExamsDetailsz."Special Exam Reason" = '') THEN
                                                            AcaSpecialExamsDetailsz.DELETEALL;
                                                    END;


                                                    ACAExamCummulativeResit.RESET;
                                                    ACAExamCummulativeResit.SETRANGE("Student Number", StudentUnits."Student No.");
                                                    ACAExamCummulativeResit.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                    //    ACAExamCummulativeResit.SETRANGE("Academic Year",Coregcs."Academic Year");
                                                    IF ACAExamCummulativeResit.FIND('-') THEN ACAExamCummulativeResit.DELETEALL;
                                                    ACAExamClassificationUnits.CALCFIELDS(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                                                    IF ACAExamClassificationUnits.Pass = FALSE THEN BEGIN
                                                        // ERROR('%1%2%3%4','The unit is ',ACAExamClassificationUnits."Unit Code" , ' academic Year is ', ACAExamClassificationUnits."Academic Year");
                                                        //Populate Supplementary Here
                                                        BEGIN
                                                            ACAExamCummulativeResit.INIT;
                                                            ACAExamCummulativeResit."Student Number" := StudentUnits."Student No.";
                                                            ACAExamCummulativeResit."School Code" := ACAExamClassificationStuds."School Code";
                                                            ACAExamCummulativeResit."Academic Year" := Coregcs."Academic Year";
                                                            ACAExamCummulativeResit."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                                            ACAExamCummulativeResit."Student Name" := ACAExamClassificationStuds."Student Name";
                                                            ACAExamCummulativeResit.Programme := StudentUnits.Programme;
                                                            ACAExamCummulativeResit."School Name" := ACAExamClassificationStuds."School Name";
                                                            ACAExamCummulativeResit."Unit Description" := UnitsSubjects.Desription;
                                                            ACAExamCummulativeResit."Credit Hours" := UnitsSubjects."No. Units";
                                                            ACAExamCummulativeResit."Unit Type" := ACAExamClassificationUnits."Unit Type";

                                                            ACAExamCummulativeResit.Score := ROUND(ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');
                                                            ACAExamCummulativeResit.Grade := ACAExamClassificationUnits.Grade;
                                                            IF ACAExamCummulativeResit.INSERT THEN;

                                                            CLEAR(AcaSpecialExamsDetailsz);


                                                            AcaSpecialExamsDetailsz.RESET;
                                                            // AcaSpecialExamsDetailsz.SETRANGE("Academic Year",Coregcs."Academic Year");
                                                            AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                            AcaSpecialExamsDetailsz.SETRANGE(Programme, StudentUnits.Programme);
                                                            AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                            //AcaSpecialExamsDetailsz.SETRANGE(Semester,StudentUnits.Semester);
                                                            //AcaSpecialExamsDetailsz.SETRANGE(Category,AcaSpecialExamsDetailsz.Category::Supplementary);
                                                            IF NOT (AcaSpecialExamsDetailsz.FIND('-')) THEN BEGIN
                                                                //AcaSpecialExamsDetailsz.DELETEALL;
                                                                AcaSpecialExamsDetailsz.INIT;
                                                                AcaSpecialExamsDetailsz."Academic Year" := Coregcs."Academic Year";
                                                                AcaSpecialExamsDetailsz.Semester := StudentUnits.Semester;
                                                                AcaSpecialExamsDetailsz."Student No." := StudentUnits."Student No.";
                                                                AcaSpecialExamsDetailsz.VALIDATE("Student No.");
                                                                AcaSpecialExamsDetailsz.Stage := StudentUnits.Stage;
                                                                AcaSpecialExamsDetailsz.Programme := StudentUnits.Programme;
                                                                AcaSpecialExamsDetailsz."Unit Code" := StudentUnits.Unit;  //
                                                                                                                           //AcaSpecialExamsDetailsz.Status:=AcaSpecialExamsDetailsz.Status::Approved;
                                                                AcaSpecialExamsDetailsz.Category := AcaSpecialExamsDetailsz.Category::Supplementary;


                                                                CLEAR(AcaSpecialExamsDetails6);
                                                                AcaSpecialExamsDetails6.RESET;
                                                                AcaSpecialExamsDetails6.SETRANGE("Student No.", StudentUnits."Student No.");
                                                                AcaSpecialExamsDetails6.SETRANGE(Programme, StudentUnits.Programme);
                                                                AcaSpecialExamsDetails6.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                                AcaSpecialExamsDetails6.SETRANGE(Category, AcaSpecialExamsDetails6.Category::Special);
                                                                AcaSpecialExamsDetails6.SETRANGE("Exam Marks", 0);
                                                                IF NOT (AcaSpecialExamsDetails6.FIND('-')) THEN BEGIN

                                                                    // Check if the Rubric allows for supp creation
                                                                    IF AcaSpecialExamsDetailsz.INSERT(TRUE) THEN;
                                                                    ;
                                                                END;
                                                            END
                                                            ELSE BEGIN

                                                                CLEAR(AcaSpecialExamsDetailsz);
                                                                AcaSpecialExamsDetailsz.RESET;
                                                                AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                                AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                                AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                                AcaSpecialExamsDetailsz.SETFILTER(Occurance, '>%1', 1);
                                                                IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                                    REPEAT
                                                                    BEGIN
                                                                        AcaSpecialExamsDetailsz.CALCFIELDS(Occurance);
                                                                        IF ((AcaSpecialExamsDetailsz."Exam Marks" = 0) AND (AcaSpecialExamsDetailsz."Special Exam Reason" = '')) THEN AcaSpecialExamsDetailsz.DELETE;
                                                                    END;
                                                                    UNTIL ((AcaSpecialExamsDetailsz.NEXT = 0) OR (AcaSpecialExamsDetailsz.Occurance = 1));
                                                                END;
                                                                CLEAR(AcaSpecialExamsDetailsz);
                                                                AcaSpecialExamsDetailsz.RESET;
                                                                AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                                AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                                AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                                IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                                    //    IF StudentUnits.Semester <> AcaSpecialExamsDetailsz.Semester THEN

                                                                    CLEAR(AcaSpecialExamsDetails7);
                                                                    AcaSpecialExamsDetails7.RESET;
                                                                    AcaSpecialExamsDetails7.SETRANGE("Student No.", AcaSpecialExamsDetailsz."Student No.");
                                                                    AcaSpecialExamsDetails7.SETRANGE("Unit Code", AcaSpecialExamsDetailsz."Unit Code");
                                                                    AcaSpecialExamsDetails7.SETRANGE(Semester, StudentUnits.Semester);
                                                                    IF AcaSpecialExamsDetails7.FIND('-') THEN BEGIN
                                                                        IF AcaSpecialExamsDetails7."Exam Marks" = 0 THEN BEGIN
                                                                        END;
                                                                    END ELSE
                                                                        IF AcaSpecialExamsDetailsz.RENAME(AcaSpecialExamsDetailsz."Student No.", AcaSpecialExamsDetailsz."Unit Code",
                                                                          AcaSpecialExamsDetailsz."Academic Year", StudentUnits.Semester, AcaSpecialExamsDetailsz.Sequence,
                                                                                 AcaSpecialExamsDetailsz.Category, AcaSpecialExamsDetailsz.Programme) THEN;
                                                                END;
                                                            END;
                                                        END;
                                                    END ELSE BEGIN
                                                        AcaSpecialExamsDetailsz.RESET;
                                                        AcaSpecialExamsDetailsz.SETRANGE("Student No.", StudentUnits."Student No.");
                                                        AcaSpecialExamsDetailsz.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                                        AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                        AcaSpecialExamsDetailsz.SETRANGE(Status, AcaSpecialExamsDetailsz.Status::New);
                                                        AcaSpecialExamsDetailsz.SETRANGE(Semester, StudentUnits.Semester);
                                                        AcaSpecialExamsDetailsz.SETRANGE("Exam Marks", 0);
                                                        IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                            IF (AcaSpecialExamsDetailsz."Special Exam Reason" = '') THEN AcaSpecialExamsDetailsz.DELETEALL;
                                                        END;
                                                    END;
                                                    IF ACAExamClassificationUnits.MODIFY THEN;
                                                    //////////////////////////// Update Units Scores.. End
                                                END ELSE BEGIN
                                                    StudentUnits."Unit not in Catalogue" := TRUE;
                                                END;
                                            END;
                                            StudentUnits.MODIFY;
                                            ///////////////////////////////////////////////////////////////// iiiiiiiiiiiiiiiiiiiiiiii End of Finalize Units
                                        END;

                                        UNTIL StudentUnits.NEXT = 0;
                                    END;

                                END;
                                UNTIL Coregcs.NEXT = 0;
                                Progressbar.CLOSE;
                            END;


                            // Update Averages
                            CLEAR(TotalRecs);
                            CLEAR(CountedRecs);
                            CLEAR(RemeiningRecs);
                            CLEAR(ACAExamClassificationStuds);
                            ACAExamCourseRegistration.RESET;
                            ACAExamCourseRegistration.SETFILTER("Reporting Academic Year", AcadYear);
                            IF StudNos <> '' THEN
                                ACAExamCourseRegistration.SETFILTER("Student Number", StudNos) ELSE
                                ACAExamCourseRegistration.SETFILTER(Programme, ProgFIls);// Only Apply Prog & School if Student FIlter is not Applied
                            IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
                                TotalRecs := ACAExamCourseRegistration.COUNT;
                                RemeiningRecs := TotalRecs;
                                ProgBar2.OPEN('#1#####################################################\' +
                                '#2############################################################\' +
                                '#3###########################################################\' +
                                '#4############################################################\' +
                                '#5###########################################################\' +
                                '#6############################################################');
                                ProgBar2.UPDATE(1, '3 of 3 Updating Class Items');
                                ProgBar2.UPDATE(2, 'Total Recs.: ' + FORMAT(TotalRecs));
                                REPEAT
                                BEGIN
                                    /////////////////////////////////////////////// Delete All Supplementary Related Entries from All Supplementary Tables and Repopulate

                                    CLEAR(Coregcs);
                                    Coregcs.RESET;
                                    Coregcs.SETFILTER("Academic Year", ACAExamCourseRegistration."Academic Year");
                                    Coregcs.SETRANGE("Exclude from Computation", FALSE);
                                    IF StudNos <> '' THEN BEGIN
                                        Coregcs.SETFILTER("Student No.", ACAExamCourseRegistration."Student Number");
                                    END ELSE BEGIN
                                    END;
                                    IF Coregcs.FIND('-') THEN Coregcs.CALCFIELDS("Stopage Yearly Remark");
                                    Progyz.RESET;
                                    Progyz.SETRANGE(Code, ACAExamCourseRegistration.Programme);
                                    IF Progyz.FIND('-') THEN;
                                    CountedRecs += 1;
                                    RemeiningRecs -= 1;
                                    ProgBar2.UPDATE(3, '.....................................................');
                                    ProgBar2.UPDATE(4, 'Processed: ' + FORMAT(CountedRecs));
                                    ProgBar2.UPDATE(5, 'Remaining: ' + FORMAT(RemeiningRecs));
                                    ProgBar2.UPDATE(6, '----------------------------------------------------');
                                    ACAExamCourseRegistration.CALCFIELDS("Total Marks", "Total Courses", "Total Weighted Marks",
                                  "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Weighted Average");
                                    ACAExamCourseRegistration."Normal Average" := ROUND((ACAExamCourseRegistration.Average), 0.01, '=');
                                    IF ACAExamCourseRegistration."Total Units" > 0 THEN
                                        ACAExamCourseRegistration."Weighted Average" := ROUND((ACAExamCourseRegistration."Total Weighted Marks" / ACAExamCourseRegistration."Total Units"), 0.01, '=');
                                    IF ACAExamCourseRegistration."Total Classified C. Count" <> 0 THEN
                                        ACAExamCourseRegistration."Classified Average" := ROUND((ACAExamCourseRegistration."Classified Total Marks" / ACAExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                                    IF ACAExamCourseRegistration."Total Classified Units" <> 0 THEN
                                        ACAExamCourseRegistration."Classified W. Average" := ROUND((ACAExamCourseRegistration."Classified W. Total" / ACAExamCourseRegistration."Total Classified Units"), 0.01, '=');
                                    ACAExamCourseRegistration.CALCFIELDS("Defined Units (Flow)");
                                    ACAExamCourseRegistration."Required Stage Units" := ACAExamCourseRegistration."Defined Units (Flow)";//RequiredStageUnits(ACAExamCourseRegistration.Programme,
                                                                                                                                         // ACAExamCourseRegistration."Year of Study",ACAExamCourseRegistration."Student Number");
                                    IF ACAExamCourseRegistration."Required Stage Units" > ACAExamCourseRegistration."Attained Stage Units" THEN
                                        ACAExamCourseRegistration."Units Deficit" := ACAExamCourseRegistration."Required Stage Units" - ACAExamCourseRegistration."Attained Stage Units";
                                    ACAExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Academic Year");
                                    ACAExamCourseRegistration."Final Classification" := GetRubRicsKaru(Progyz, ACAExamCourseRegistration, Coregcs.Semester);
                                    IF Coregcs."Stopage Yearly Remark" <> '' THEN
                                        ACAExamCourseRegistration."Final Classification" := Coregcs."Stopage Yearly Remark";
                                    ACAExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                    ACAExamCourseRegistration."Academic Year", Progyz);
                                    ACAExamCourseRegistration."Final Classification Order" := GetRubricOrder(ACAExamCourseRegistration."Final Classification");
                                    ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                    ACAExamCourseRegistration."Academic Year", Progyz);
                                    ACAExamCourseRegistration.Classification := ACAExamCourseRegistration."Final Classification";
                                    ACAExamCourseRegistration.CALCFIELDS("Attained Stage Units");
                                    IF ((ACAExamCourseRegistration.Classification = 'PASS') AND (ACAExamCourseRegistration."Attained Stage Units" = 0)) THEN BEGIN
                                        ACAExamCourseRegistration.Classification := 'DTSC';
                                        ACAExamCourseRegistration."Final Classification" := 'DTSC';
                                        ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                        ACAExamCourseRegistration."Academic Year", Progyz);
                                    END;
                                    ACAExamCourseRegistration.CALCFIELDS("Total Marks",
                       "Total Weighted Marks",
                       "Total Failed Courses",
                       "Total Failed Units",
                       "Failed Courses",
                       "Failed Units",
                       "Failed Cores",
                       "Failed Required",
                       "Failed Electives",
                       "Total Cores Done",
                       "Total Cores Passed",
                       "Total Required Done",
                       "Total Electives Done",
                       "Tota Electives Passed");
                                    ACAExamCourseRegistration.CALCFIELDS(
                                    "Classified Electives C. Count",
                                    "Classified Electives Units",
                                    "Total Classified C. Count",
                                    "Total Classified Units",
                                    "Classified Total Marks",
                                    "Classified W. Total",
                                    "Total Failed Core Units");

                                    // Check Multiple Occurances on Rubrics
                                    ACAExamCourseRegistration.CALCFIELDS("Skip Supplementary Generation", "Yearly Rubric Occurances",
                                    "Total Rubric Occurances", "Maximum Allowable Occurances", "Alternate Rubric");
                                    IF ACAExamCourseRegistration."Maximum Allowable Occurances" > 0 THEN BEGIN
                                        IF ((ACAExamCourseRegistration."Yearly Rubric Occurances" > ACAExamCourseRegistration."Maximum Allowable Occurances")
                                          OR (ACAExamCourseRegistration."Yearly Rubric Occurances" = ACAExamCourseRegistration."Maximum Allowable Occurances")) THEN BEGIN
                                            // Pick Alternate
                                            ACAExamCourseRegistration."Final Classification" := ACAExamCourseRegistration."Alternate Rubric";
                                            ACAExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                            ACAExamCourseRegistration."Academic Year", Progyz);
                                            ACAExamCourseRegistration."Final Classification Order" := GetRubricOrder(ACAExamCourseRegistration."Final Classification");
                                            ACAExamCourseRegistration.Graduating := GetRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                                            ACAExamCourseRegistration."Academic Year", Progyz);
                                            ACAExamCourseRegistration.Classification := ACAExamCourseRegistration."Final Classification";
                                        END;
                                    END;
                                    IF ACAExamCourseRegistration."Total Courses" = 0 THEN BEGIN
                                        // ACAExamCourseRegistration."Final Classification":='HALT';
                                        ACAExamCourseRegistration."Final Classification Pass" := FALSE;
                                        ACAExamCourseRegistration."Final Classification Order" := 10;
                                        ACAExamCourseRegistration.Graduating := FALSE;
                                        // ACAExamCourseRegistration.Classification:='HALT';
                                    END;
                                    IF Coregcs."Stopage Yearly Remark" <> '' THEN
                                        ACAExamCourseRegistration.Classification := Coregcs."Stopage Yearly Remark";

                                    ACAExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study");
                                    ACAExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACAExamCourseRegistration.Programme, ACAExamCourseRegistration."Year of Study",
                                    ACAExamCourseRegistration."Programme Option", ACAExamCourseRegistration."Academic Year");
                                    ACAExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration.Programme);
                                    ACAExamCourseRegistration.MODIFY(TRUE);
                                    ACAExamCourseRegistration.CALCFIELDS("Skip Supplementary Generation");
                                    IF ACAExamCourseRegistration."Skip Supplementary Generation" = TRUE THEN BEGIN
                                        // Delete all Supp Registrations here
                                        DeleteSuppPreviousEntries(ACAExamCourseRegistration);
                                        IF Coregcs.FIND('-') THEN BEGIN
                                            REPEAT
                                            BEGIN
                                                CLEAR(AcaSpecialExamsDetailsz);
                                                AcaSpecialExamsDetailsz.RESET;
                                                AcaSpecialExamsDetailsz.SETRANGE("Student No.", ACAExamCourseRegistration."Student Number");
                                                AcaSpecialExamsDetailsz.SETRANGE(Category, AcaSpecialExamsDetailsz.Category::Supplementary);
                                                AcaSpecialExamsDetailsz.SETRANGE(Semester, Coregcs.Semester);
                                                AcaSpecialExamsDetailsz.SETRANGE(Status, AcaSpecialExamsDetailsz.Status::New);
                                                AcaSpecialExamsDetailsz.SETRANGE("Exam Marks", 0);
                                                IF AcaSpecialExamsDetailsz.FIND('-') THEN BEGIN
                                                    IF (AcaSpecialExamsDetailsz."Special Exam Reason" = '') THEN AcaSpecialExamsDetailsz.DELETEALL;
                                                END;
                                            END;
                                            UNTIL Coregcs.NEXT = 0;
                                        END;
                                    END ELSE BEGIN
                                        // If Rubric is a Fail, Generate a Supplementary Registration
                                        // ERROR(ACAExamCourseRegistration."Student Number");
                                        UpdateSupplementaryMarks(ACAExamCourseRegistration);
                                    END;
                                END;
                                UNTIL ACAExamCourseRegistration.NEXT = 0;
                                ProgBar2.CLOSE;
                            END;

                            ACASenateReportsHeader.RESET;
                            ACASenateReportsHeader.SETFILTER("Programme Code", ProgFIls);
                            ACASenateReportsHeader.SETFILTER("Reporting Academic Year", Coregcs."Academic Year");
                            IF ACASenateReportsHeader.FIND('-') THEN BEGIN
                                ProgBar22.OPEN('#1##########################################');
                                REPEAT
                                BEGIN
                                    ProgBar22.UPDATE(1, 'Student Number: ' + ACASenateReportsHeader."Programme Code" + ' Class: ' + ACASenateReportsHeader."Classification Code");
                                    WITH ACASenateReportsHeader DO BEGIN
                                        ACASenateReportsHeader.CALCFIELDS("School Classification Count", "School Total Passed", "School Total Passed",
                                        "School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
                                        "Prog. Total Count");

                                        CALCFIELDS("School Classification Count", "School Total Passed", "School Total Failed", "School Total Count",
                                        "Programme Classification Count", "Prog. Total Count", "Programme Total Failed", "Programme Total Passed");
                                        IF "School Total Count" > 0 THEN
                                            "Sch. Class % Value" := ROUND((("School Classification Count" / "School Total Count") * 100), 0.01, '=');
                                        IF "School Total Count" > 0 THEN
                                            "School % Failed" := ROUND((("School Total Failed" / "School Total Count") * 100), 0.01, '=');
                                        IF "School Total Count" > 0 THEN
                                            "School % Passed" := ROUND((("School Total Passed" / "School Total Count") * 100), 0.01, '=');
                                        IF "Prog. Total Count" > 0 THEN
                                            "Prog. Class % Value" := ROUND((("Programme Classification Count" / "Prog. Total Count") * 100), 0.01, '=');
                                        IF "Prog. Total Count" > 0 THEN
                                            "Programme % Failed" := ROUND((("Programme Total Failed" / "Prog. Total Count") * 100), 0.01, '=');
                                        IF "Prog. Total Count" > 0 THEN
                                            "Programme % Passed" := ROUND((("Programme Total Passed" / "Prog. Total Count") * 100), 0.01, '=');
                                    END;
                                    ACASenateReportsHeader.MODIFY;
                                END;
                                UNTIL ACASenateReportsHeader.NEXT = 0;
                                ProgBar22.CLOSE;
                            END;


                        END;
                        UNTIL ProgForFilters.NEXT = 0;
                    END;
                    // Update Supp Summaries
                    /////????????????????????????????????????????????????

                    CLEAR(ACASenateReportsHeaderSupps);
                    ACASenateReportsHeaderSupps.RESET;
                    ACASenateReportsHeaderSupps.SETFILTER("Programme Code", ProgFIls);
                    ACASenateReportsHeaderSupps.SETFILTER("Reporting Academic Year", AcadYear);
                    IF ACASenateReportsHeaderSupps.FIND('-') THEN BEGIN
                        ProgBar22.OPEN('#1##########################################');
                        REPEAT
                        BEGIN
                            ProgBar22.UPDATE(1, 'Student Number: ' + ACASenateReportsHeaderSupps."Programme Code" + ' Class: ' + ACASenateReportsHeaderSupps."Classification Code");
                            WITH ACASenateReportsHeaderSupps DO BEGIN
                                ACASenateReportsHeaderSupps.CALCFIELDS("School Classification Count", "School Total Passed", "School Total Passed",
                                "School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
                                "Prog. Total Count");

                                CALCFIELDS("School Classification Count", "School Total Passed", "School Total Failed", "School Total Count",
                                "Programme Classification Count", "Prog. Total Count", "Programme Total Failed", "Programme Total Passed");
                                IF "School Total Count" > 0 THEN
                                    "Sch. Class % Value" := ROUND((("School Classification Count" / "School Total Count") * 100), 0.01, '=');
                                IF "School Total Count" > 0 THEN
                                    "School % Failed" := ROUND((("School Total Failed" / "School Total Count") * 100), 0.01, '=');
                                IF "School Total Count" > 0 THEN
                                    "School % Passed" := ROUND((("School Total Passed" / "School Total Count") * 100), 0.01, '=');
                                IF "Prog. Total Count" > 0 THEN
                                    "Prog. Class % Value" := ROUND((("Programme Classification Count" / "Prog. Total Count") * 100), 0.01, '=');
                                IF "Prog. Total Count" > 0 THEN
                                    "Programme % Failed" := ROUND((("Programme Total Failed" / "Prog. Total Count") * 100), 0.01, '=');
                                IF "Prog. Total Count" > 0 THEN
                                    "Programme % Passed" := ROUND((("Programme Total Passed" / "Prog. Total Count") * 100), 0.01, '=');
                            END;
                            ACASenateReportsHeaderSupps.MODIFY;
                        END;
                        UNTIL ACASenateReportsHeaderSupps.NEXT = 0;
                        ProgBar22.CLOSE;
                    END;
                    ////???????????????????????????????????????????????????????????
                    // Supp Updates
                    CLEAR(ACA2NDSenateReportsHeader);
                    ACA2NDSenateReportsHeader.RESET;
                    ACA2NDSenateReportsHeader.SETFILTER("Programme Code", ProgFIls);
                    ACA2NDSenateReportsHeader.SETFILTER("Reporting Academic Year", Coregcs."Academic Year");
                    IF ACA2NDSenateReportsHeader.FIND('-') THEN BEGIN
                        ProgBar22.OPEN('#1##########################################');
                        REPEAT
                        BEGIN
                            ProgBar22.UPDATE(1, 'Student Number: ' + ACA2NDSenateReportsHeader."Programme Code" + ' Class: ' + ACA2NDSenateReportsHeader."Classification Code");
                            WITH ACA2NDSenateReportsHeader DO BEGIN
                                ACA2NDSenateReportsHeader.CALCFIELDS("School Classification Count", "School Total Passed", "School Total Passed",
                                "School Total Failed", "Programme Classification Count", "Programme Total Passed", "Programme Total Failed", "School Total Count",
                                "Prog. Total Count");

                                CALCFIELDS("School Classification Count", "School Total Passed", "School Total Failed", "School Total Count",
                                "Programme Classification Count", "Prog. Total Count", "Programme Total Failed", "Programme Total Passed");
                                IF "School Total Count" > 0 THEN
                                    "Sch. Class % Value" := ROUND((("School Classification Count" / "School Total Count") * 100), 0.01, '=');
                                IF "School Total Count" > 0 THEN
                                    "School % Failed" := ROUND((("School Total Failed" / "School Total Count") * 100), 0.01, '=');
                                IF "School Total Count" > 0 THEN
                                    "School % Passed" := ROUND((("School Total Passed" / "School Total Count") * 100), 0.01, '=');
                                IF "Prog. Total Count" > 0 THEN
                                    "Prog. Class % Value" := ROUND((("Programme Classification Count" / "Prog. Total Count") * 100), 0.01, '=');
                                IF "Prog. Total Count" > 0 THEN
                                    "Programme % Failed" := ROUND((("Programme Total Failed" / "Prog. Total Count") * 100), 0.01, '=');
                                IF "Prog. Total Count" > 0 THEN
                                    "Programme % Passed" := ROUND((("Programme Total Passed" / "Prog. Total Count") * 100), 0.01, '=');
                            END;
                            ACA2NDSenateReportsHeader.MODIFY;
                        END;
                        UNTIL ACA2NDSenateReportsHeader.NEXT = 0;
                        ProgBar22.CLOSE;
                    END;


                    MESSAGE('Processing completed successfully!');
                    IF STRLEN(programs) > 249 THEN programs := COPYSTR(programs, 1, 249);
                    IF STRLEN(AcadYear) > 249 THEN AcadYear := COPYSTR(AcadYear, 1, 249) ELSE AcadYear := AcadYear;
                    IF STRLEN(Schools) > 249 THEN Schools := COPYSTR(Schools, 1, 249);

                    UpdateFilters(USERID, programs, AcadYear, Schools);

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        ACAExamProcessingFilterLog: Record "ACA-Exam Processing Filter Log";
    begin
        ACAExamProcessingFilterLog.Reset;
        ACAExamProcessingFilterLog.SetRange("User ID", UserId);
        if ACAExamProcessingFilterLog.Find('-') then begin
            // //    Semesters:=ACAExamProcessingFilterLog."Semester Code";
            programs := ACAExamProcessingFilterLog."Programme Code";
            Schools := ACAExamProcessingFilterLog."School Filters"
            //GradAcademicYear:=ACAExamProcessingFilterLog."Graduation Year";
        end;
        ACAAcademicYear963.Reset;
        ACAAcademicYear963.SetRange("Graduating Group", true);
        if not ACAAcademicYear963.Find('-') then Error('Graduating group is not defined!');
        GradAcademicYear := ACAAcademicYear963.Code;
    end;

    var
        programs: Code[1024];
        semesterz: Code[20];
        AcadYear: Code[1024];
        Stages: Code[1024];
        StudNos: Code[1024];
        ACAExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
        ACAExamResults: Record "ACA-Exam Results";
        SemesterFilter: Text[1024];
        AcaSpecialExamsResults: Record "Aca-Special Exams Results";
        GradAcademicYear: Code[1024];
        ACACourseRegistration5: Record "ACA-Course Registration";
        Progrezz: Dialog;
        ACAProgramme963: Record "ACA-Programme";
        ACAAcademicYear963: Record "ACA-Academic Year";
        Schools: Code[1024];
        UnitCode: Code[1024];
        ACAProgrammeStages: Record "ACA-Programme Stages";
        ProgFIls: Text[1024];
        Progressbar: Dialog;
        ToGraduate: Boolean;
        AcademicYear_Finz: Record "ACA-Academic Year";
        YosStages: Text[150];

    procedure GetMultipleProgramExists(StudNoz: Code[250]; AcadYearsz: Code[250]) Multiples: Boolean
    var
        ACAExamClassificationStuds: Record "ACA-Exam Classification Studs";
        ClassClassificationCourseReg: Record "ACA-Classification Course Reg.";
        ClassClassificationUnits: Record "ACA-Classification Units";
    begin
        ACAExamClassificationStuds.RESET;
        ACAExamClassificationStuds.SETRANGE("Student Number", StudNoz);
        ACAExamClassificationStuds.SETRANGE("Academic Year", AcadYearsz);
        IF ACAExamClassificationStuds.FIND('-') THEN
            IF ACAExamClassificationStuds.COUNT > 1 THEN Multiples := TRUE ELSE Multiples := FALSE;
    end;

    local procedure UpdateFilters(UserCode: Code[50]; ProgCodes: Code[1024]; GradYearOfStudy: Code[1024]; Schoolscodes: Code[250])
    var
        ACAExamProcessingFilterLog: Record "ACA-Exam Processing Filter Log";
    begin
        ACAExamProcessingFilterLog.Reset;
        ACAExamProcessingFilterLog.SetRange("User ID", UserCode);
        if ACAExamProcessingFilterLog.Find('-') then begin
            //Exists, Update
            ACAExamProcessingFilterLog."Programme Code" := ProgCodes;
            // //  ACAExamProcessingFilterLog."Graduation Year":=GradAcademicYear;
            ACAExamProcessingFilterLog."School Filters" := Schoolscodes;
            ACAExamProcessingFilterLog.Modify;
        end else begin
            // Doesent Exists, Insert
            ACAExamProcessingFilterLog.Init;
            ACAExamProcessingFilterLog."User ID" := UserCode;
            ACAExamProcessingFilterLog."Programme Code" := ProgCodes;
            // //  ACAExamProcessingFilterLog."Semester Code":=Semesters;
            // //  ACAExamProcessingFilterLog."Graduation Year":=GradAcademicYear;
            ACAExamProcessingFilterLog."School Filters" := Schoolscodes;
            ACAExamProcessingFilterLog.Insert;
        end;
    end;

    local procedure GetStudentName(StudNo: Code[20]) StudName: Text[250]
    var
        Customer: Record Customer;
    begin
        Customer.Reset;
        Customer.SetRange("No.", StudNo);
        if Customer.Find('-') then begin
            if StrLen(Customer.Name) > 100 then Customer.Name := CopyStr(Customer.Name, 1, 100);
            Customer.Name := Customer.Name;
            Customer.Modify;
            StudName := Customer.Name;
        end;
    end;

    local procedure GetDepartmentNameOrSchool(DimCode: Code[20]) DimName: Text[150]
    var
        dimVal: Record "Dimension Value";
    begin
        dimVal.Reset;
        dimVal.SetRange(Code, DimCode);
        if dimVal.Find('-') then DimName := dimVal.Name;
    end;

    local procedure GetFinalStage(ProgCode: Code[20]) FinStage: Code[20]
    var
        ACAProgrammeStages: Record "ACA-Programme Stages";
    begin
        Clear(FinStage);
        ACAProgrammeStages.Reset;
        ACAProgrammeStages.SetRange("Programme Code", ProgCode);
        ACAProgrammeStages.SetRange("Final Stage", true);
        if ACAProgrammeStages.Find('-') then begin
            FinStage := ACAProgrammeStages.Code;
        end;
    end;

    local procedure GetFinalYearOfStudy(ProgCode: Code[20]) FinYearOfStudy: Integer
    var
        ACAProgrammeStages: Record "ACA-Programme Stages";
    begin
        Clear(FinYearOfStudy);
        ACAProgrammeStages.Reset;
        ACAProgrammeStages.SetRange("Programme Code", ProgCode);
        ACAProgrammeStages.SetRange("Final Stage", true);
        if ACAProgrammeStages.Find('-') then begin
            if StrLen(ACAProgrammeStages.Code) > 2 then begin
                if Evaluate(FinYearOfStudy, CopyStr(ACAProgrammeStages.Code, 2, 1)) then;
            end;
        end;
    end;

    local procedure GetAdmissionDate(StudNo: Code[20]; ProgCode: Code[20]) AdmissionDate: Date
    var
        coregz: Record "ACA-Course Registration";
    begin
        Clear(AdmissionDate);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('-') then begin
            AdmissionDate := coregz."Registration Date";
        end;
    end;

    local procedure GetAdmissionAcademicYear(StudNo: Code[20]; ProgCode: Code[20]) AdmissionAcadYear: Code[20]
    var
        coregz: Record "ACA-Course Registration";
    begin
        Clear(AdmissionAcadYear);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('-') then begin
            AdmissionAcadYear := coregz."Academic Year";
        end;
    end;

    local procedure GetFinalAcademicYear(StudNo: Code[20]; ProgCode: Code[20]) FinalAcadYear: Code[20]
    var
        coregz: Record "ACA-Course Registration";
    begin
        Clear(FinalAcadYear);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('+') then begin
            FinalAcadYear := coregz."Academic Year";
        end;
    end;

    local procedure GetMultipleProgramExists(StudNoz: Code[20]) Multiples: Boolean
    var
        ACAExamClassificationStuds: Record "ACA-Exam Classification Studs";
        ClassClassificationCourseReg: Record "ACA-Classification Course Reg.";
        ClassClassificationUnits: Record "ACA-Classification Units";
    begin
        ACAExamClassificationStuds.Reset;
        ACAExamClassificationStuds.SetRange("Student Number", StudNoz);
        if ACAExamClassificationStuds.Find('-') then
            if ACAExamClassificationStuds.Count > 1 then Multiples := true else Multiples := false;
    end;

    local procedure GetCohort(StudNo: Code[20]; ProgCode: Code[20]) Cohort: Code[20]
    var
        coregz: Record "ACA-Course Registration";
        ACAProgrammeGraduationGroup: Record "ACA-Programme Graduation Group";
    begin
        Clear(Cohort);
        coregz.Reset;
        coregz.SetRange("Student No.", StudNo);
        coregz.SetRange(Programmes, ProgCode);
        coregz.SetRange(Reversed, false);
        if coregz.Find('-') then begin
            ACAProgrammeGraduationGroup.Reset;
            ACAProgrammeGraduationGroup.SetRange("Programme Code", ProgCode);
            ACAProgrammeGraduationGroup.SetRange("Admission Academic Year", coregz."Academic Year");
            if ACAProgrammeGraduationGroup.Find('-') then
                ACAProgrammeGraduationGroup.TestField("Graduation Academic Year");
            Cohort := ACAProgrammeGraduationGroup."Admission Academic Year";
        end;
    end;

    local procedure RequiredStageUnits(ProgCode: Code[20]; YoS: Integer; StudNo: Code[20]) ExpectedUnits: Decimal
    var
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
        AcacourseReg: Record "ACA-Course Registration";
    begin
        ACADefinedUnitsperYoS.Reset;
        ACADefinedUnitsperYoS.SetRange("Year of Study", YoS);
        ACADefinedUnitsperYoS.SetRange(Programmes, ProgCode);
        AcacourseReg.Reset;
        AcacourseReg.SetRange("Student No.", StudNo);
        AcacourseReg.SetRange(Programmes, ProgCode);
        AcacourseReg.SetRange("Year Of Study", YoS);
        if AcacourseReg.Find('-') then
            if AcacourseReg.Options <> '-' then
                ACADefinedUnitsperYoS.SetRange(Options, AcacourseReg.Options);
        if ACADefinedUnitsperYoS.Find('-') then ExpectedUnits := ACADefinedUnitsperYoS."Number of Units";
    end;

    local procedure GetClassification(ProgramCode: Code[100]; AverageScore: Decimal; HasIrregularity: Boolean) Classification: Code[100]
    var
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ACAProgramme123: Record "ACA-Programme";
        ACAGradingSystemSetup: Record "ACA-Exam Gradding Setup";
    begin
        Clear(Classification);
        ACAProgramme123.Reset;
        ACAProgramme123.SetRange(Code, ProgramCode);
        if ACAProgramme123.Find('-') then begin
            ACAGradingSystemSetup.Reset;
            ACAGradingSystemSetup.SetRange(Category, ACAProgramme123."Exam Category");
            ACAGradingSystemSetup.SetFilter("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
            ACAGradingSystemSetup.SetFilter("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
            if ACAGradingSystemSetup.Find('-') then begin
                if HasIrregularity then begin
                    ACAClassGradRubrics.Reset;
                    ACAClassGradRubrics.SetRange(Code, ACAGradingSystemSetup.Remarks);
                    if ACAClassGradRubrics.Find('-') then begin
                        if ACAClassGradRubrics."Alternate Rubric" <> '' then begin
                            Classification := ACAClassGradRubrics."Alternate Rubric";
                        end else begin
                            Classification := ACAGradingSystemSetup.Remarks;
                        end;
                    end else begin
                        Classification := ACAGradingSystemSetup.Remarks;
                    end;
                end else begin
                    Classification := ACAGradingSystemSetup.Remarks;
                end;
            end;
        end;
    end;

    procedure GetClassificationGrade(EXAMMark: Decimal; Proga: Code[20]) xGrade: Text[100]
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        Gradings2: Record "ACA-Exam Gradding Setup";
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        Marks: Decimal;
    begin
        Clear(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        ProgrammeRec.Reset;
        if ProgrammeRec.Get(Proga) then
            GradeCategory := ProgrammeRec."Exam Category";
        if GradeCategory = '' then GradeCategory := 'DEFAULT';
        xGrade := '';
        if Marks > 0 then begin
            Gradings.Reset;
            Gradings.SetRange(Gradings.Category, GradeCategory);
            Gradings.SetFilter(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
            Gradings.SetFilter(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            if Gradings.Find('-') then begin
                ExitDo := false;
                //REPEAT
                LastScore := Gradings."Up to";
                if Marks < LastScore then begin
                    if ExitDo = false then begin
                        xGrade := Gradings.Grade;
                        if Gradings.Failed = false then
                            LastRemark := 'PASS'
                        else
                            LastRemark := 'FAIL';
                        ExitDo := true;
                    end;
                end;


            end;

        end;
    end;

    procedure GetClassPassStatus(EXAMMark: Decimal; Proga: Code[20]) Passed: Boolean
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record "ACA-Exam Gradding Setup";
        Gradings2: Record "ACA-Exam Gradding Setup";
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        Marks: Decimal;
    begin
        Clear(Marks);
        Marks := EXAMMark;
        GradeCategory := '';
        ProgrammeRec.Reset;
        if ProgrammeRec.Get(Proga) then
            GradeCategory := ProgrammeRec."Exam Category";
        if GradeCategory = '' then GradeCategory := 'DEFAULT';

        Passed := false;
        if Marks > 0 then begin
            Gradings.Reset;
            Gradings.SetRange(Gradings.Category, GradeCategory);
            Gradings.SetFilter(Gradings."Lower Limit", '<%1|=%2', Marks, Marks);
            Gradings.SetFilter(Gradings."Upper Limit", '>%1|=%2', Marks, Marks);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            if Gradings.Find('-') then begin
                ExitDo := false;
                //REPEAT
                LastScore := Gradings."Up to";
                if Marks < LastScore then begin
                    if ExitDo = false then begin
                        if Gradings.Failed then
                            Passed := false else
                            Passed := true;
                        if Gradings.Failed = false then
                            LastRemark := 'PASS'
                        else
                            LastRemark := 'FAIL';
                        ExitDo := true;
                    end;
                end;


            end;

        end;
    end;

    local procedure GetClassificationOrder(ProgramCode: Code[100]; AverageScore: Decimal; HasIrregularity: Boolean) ClassOrder: Integer
    var
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ACAProgramme123: Record "ACA-Programme";
        ACAGradingSystemSetup: Record "ACA-Exam Gradding Setup";
        Classification: Code[50];
    begin
        Clear(Classification);
        ACAProgramme123.Reset;
        ACAProgramme123.SetRange(Code, ProgramCode);
        if ACAProgramme123.Find('-') then begin
            ACAGradingSystemSetup.Reset;
            ACAGradingSystemSetup.SetRange(Category, ACAProgramme123."Exam Category");
            ACAGradingSystemSetup.SetFilter("Lower Limit", '=%1|<%2', AverageScore, AverageScore);
            ACAGradingSystemSetup.SetFilter("Upper Limit", '>%2|=%1', AverageScore, AverageScore);
            if ACAGradingSystemSetup.Find('-') then begin
                if HasIrregularity then begin
                    ACAClassGradRubrics.Reset;
                    ACAClassGradRubrics.SetRange(Code, ACAGradingSystemSetup.Remarks);
                    if ACAClassGradRubrics.Find('-') then begin
                        if ACAClassGradRubrics."Alternate Rubric" <> '' then begin
                            Classification := ACAClassGradRubrics."Alternate Rubric";
                        end else begin
                            Classification := ACAGradingSystemSetup.Remarks;
                        end;
                    end else begin
                        Classification := ACAGradingSystemSetup.Remarks;
                    end;
                end else begin
                    Classification := ACAGradingSystemSetup.Remarks;
                end;
            end;
        end;
        Clear(ClassOrder);
        ACAClassGradRubrics.Reset;
        ACAClassGradRubrics.SetRange(Code, Classification);
        if ACAClassGradRubrics.Find('-') then
            ClassOrder := ACAClassGradRubrics."Order No";
    end;

    local procedure GetYearOfStudy(StageCode: Code[20]) YearOfStudy: Integer
    var
        ACAProgrammeStages: Record "ACA-Programme Stages";
    begin
        Clear(YearOfStudy);

        if StrLen(StageCode) > 2 then begin
            if Evaluate(YearOfStudy, CopyStr(StageCode, 2, 1)) then;
        end;
    end;

    local procedure GetRubric(ACAProgramme: Record "ACA-Programme"; CoursesRegz: Record "ACA-Exam. Course Registration") StatusRemarks: Text[150]
    var
        Customer: Record Customer;
        LubricIdentified: Boolean;
        ACAResultsStatus: Record "ACA-Results Status";
        YearlyReMarks: Text[250];
    begin
        Clear(StatusRemarks);
        Clear(YearlyReMarks);
        Customer.Reset;
        Customer.SetRange("No.", CoursesRegz."Student Number");
        if Customer.Find('-') then begin
            if ((Customer.Status = Customer.Status::Registration) or (Customer.Status = Customer.Status::Current)) then begin
                Clear(LubricIdentified);
                CoursesRegz.CalcFields("Attained Stage Units", "Failed Cores", "Failed Courses", "Failed Electives", "Failed Required", "Failed Units",
                "Total Failed Units", "Total Marks", "Total Required Done",
                "Total Required Passed", "Total Units", "Total Weighted Marks");
                CoursesRegz.CalcFields("Total Cores Done", "Total Cores Passed", "Total Courses", "Total Electives Done", "Total Failed Courses",
                "Tota Electives Passed", "Total Classified C. Count", "Total Classified Units", "Total Classified Units");
                // // // //          IF CoursesRegz."Units Deficit">0 THEN BEGIN
                // // // //            CoursesRegz."Failed Cores":=CoursesRegz."Failed Cores"+CoursesRegz."Units Deficit";
                // // // //            CoursesRegz."Failed Courses":=CoursesRegz."Failed Courses"+CoursesRegz."Units Deficit";
                // // // //            CoursesRegz."Total Failed Courses":=CoursesRegz."Total Failed Courses"+CoursesRegz."Units Deficit";
                // // // //            CoursesRegz."Total Courses":=CoursesRegz."Total Courses"+CoursesRegz."Units Deficit";
                // // // //            END;
                if CoursesRegz."Total Courses" > 0 then
                    CoursesRegz."% Failed Courses" := (CoursesRegz."Failed Courses" / CoursesRegz."Total Courses") * 100;
                CoursesRegz."% Failed Courses" := Round(CoursesRegz."% Failed Courses", 0.01, '=');
                if CoursesRegz."% Failed Courses" > 100 then CoursesRegz."% Failed Courses" := 100;
                if CoursesRegz."Total Cores Done" > 0 then
                    CoursesRegz."% Failed Cores" := ((CoursesRegz."Failed Cores" / CoursesRegz."Total Cores Done") * 100);
                CoursesRegz."% Failed Cores" := Round(CoursesRegz."% Failed Cores", 0.01, '=');
                if CoursesRegz."% Failed Cores" > 100 then CoursesRegz."% Failed Cores" := 100;
                if CoursesRegz."Total Units" > 0 then
                    CoursesRegz."% Failed Units" := (CoursesRegz."Failed Units" / CoursesRegz."Total Units") * 100;
                CoursesRegz."% Failed Units" := Round(CoursesRegz."% Failed Units", 0.01, '=');
                if CoursesRegz."% Failed Units" > 100 then CoursesRegz."% Failed Units" := 100;
                if CoursesRegz."Total Electives Done" > 0 then
                    CoursesRegz."% Failed Electives" := (CoursesRegz."Failed Electives" / CoursesRegz."Total Electives Done") * 100;
                CoursesRegz."% Failed Electives" := Round(CoursesRegz."% Failed Electives", 0.01, '=');
                if CoursesRegz."% Failed Electives" > 100 then CoursesRegz."% Failed Electives" := 100;
                CoursesRegz.Modify;
                if (CoursesRegz."Student Number" = 'MML/00110/019') then
                    ACAResultsStatus.Reset;
                ACAResultsStatus.Reset;
                ACAResultsStatus.SetFilter("Manual Status Processing", '%1', false);
                ACAResultsStatus.SetRange("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SetRange("Special Programme Class", ACAProgramme."Special Programme Class");
                // ACAResultsStatus.SETFILTER("Min. Unit Repeat Counts",'=%1|<%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                // ACAResultsStatus.SETFILTER("Max. Unit Repeat Counts",'=%1|>%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                if ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" then begin
                    if CoursesRegz."% Failed Cores" > 0 then begin
                        ACAResultsStatus.SetFilter("Minimum Core Fails", '=%1|<%2', CoursesRegz."% Failed Cores", CoursesRegz."% Failed Cores");
                        ACAResultsStatus.SetFilter("Maximum Core Fails", '=%1|>%2', CoursesRegz."% Failed Cores", CoursesRegz."% Failed Cores");
                    end else begin
                        ACAResultsStatus.SetFilter("Minimum Units Failed", '=%1|<%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                        ACAResultsStatus.SetFilter("Maximum Units Failed", '=%1|>%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                    end;
                    //  ACAResultsStatus.SETFILTER("Minimum None-Core Fails",'=%1|<%2',CoursesRegz."Failed Required",CoursesRegz."Failed Required");
                    // ACAResultsStatus.SETFILTER("Maximum None-Core Fails",'=%1|>%2',CoursesRegz."Failed Required",CoursesRegz."Failed Required");
                end
                else begin
                    ACAResultsStatus.SetFilter("Minimum Units Failed", '=%1|<%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                    ACAResultsStatus.SetFilter("Maximum Units Failed", '=%1|>%2', CoursesRegz."Failed Courses", CoursesRegz."Failed Courses");
                end;
                // // // // // ELSE BEGIN
                // // // // // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',YearlyFailedUnits,YearlyFailedUnits);
                // // // // // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',YearlyFailedUnits,YearlyFailedUnits);
                // // // // //  END;
                ACAResultsStatus.SetCurrentKey("Order No");
                if ACAResultsStatus.Find('-') then begin
                    repeat
                    begin
                        StatusRemarks := ACAResultsStatus.Code;
                        if ACAResultsStatus."Lead Status" <> '' then
                            StatusRemarks := ACAResultsStatus."Lead Status";
                        YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        LubricIdentified := true;
                    end;
                    until ((ACAResultsStatus.Next = 0) or (LubricIdentified = true))
                end;
            end else begin

                ACAResultsStatus.Reset;
                ACAResultsStatus.SetRange(Status, Customer.Status);
                ACAResultsStatus.SetRange("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SetRange("Special Programme Class", ACAProgramme."Special Programme Class");
                if ACAResultsStatus.Find('-') then begin
                    StatusRemarks := ACAResultsStatus.Code;
                    YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                end else begin
                    StatusRemarks := UpperCase(Format(Customer.Status));
                    YearlyReMarks := StatusRemarks;
                end;
            end;
        end;
    end;

    procedure GetRubRicsKaru(AcaProg: Record "ACA-Programme"; CoursesRegz: Record "ACA-exam. Course Registration"; Semesz: Code[10]) StatusRemarks: Text[150]
    var
        Customer: Record "Aca-Course Registration";
        LubricIdentified: Boolean;
        ACAResultsStatus: Record "ACA-Results Status";
        YearlyReMarks: Text[150];
        ACAProgramme: Record "ACA-Programme";
        StudCoregcs24: Record "ACA-Course Registration";
        ACARegStoppageReasons: Record "ACA-Reg. Stoppage Reasons";
        StudCoregcs2: Record "ACA-Course Registration";
        StudCoregcs: Record "ACA-Course Registration";
        AcaSpecialExamsDetails: Record "ACA-Special Exams Details";
        ObjCourseReg: Record "ACA-exam. Course Registration";
        CurrentYear: Integer;
        AcaStoppage: Record "ACA-Reg. Stoppage Reasons";
    begin
        CLEAR(StatusRemarks);
        CLEAR(YearlyReMarks);
        Customer.RESET;
        Customer.SETRANGE("Student No.", CoursesRegz."Student Number");
        Customer.SETRANGE("Academic Year", CoursesRegz."Academic Year");
        IF Customer.FIND('+') THEN BEGIN
            IF ((Customer.Status = Customer.Status::Registration) OR (Customer.Status = Customer.Status::Current)) THEN BEGIN
                CLEAR(LubricIdentified);
                CoursesRegz.CALCFIELDS("Attained Stage Units", "Failed Cores", "Failed Courses", "Failed Electives", "Failed Required", "Failed Units",
                "Total Failed Units", "Total Marks", "Total Required Done",
                "Total Required Passed", "Total Units", "Total Weighted Marks", "Exists DTSC Prefix");
                CoursesRegz.CALCFIELDS("Total Cores Done", "Total Cores Passed", "Total Courses", "Total Electives Done", "Total Failed Courses",
                "Tota Electives Passed", "Total Classified C. Count", "Total Classified Units", "Total Classified Units");
                IF CoursesRegz."Total Courses" > 0 THEN
                    CoursesRegz."% Failed Courses" := (CoursesRegz."Failed Courses" / CoursesRegz."Total Courses") * 100;
                CoursesRegz."% Failed Courses" := ROUND(CoursesRegz."% Failed Courses", 0.01, '>');
                IF CoursesRegz."% Failed Courses" > 100 THEN CoursesRegz."% Failed Courses" := 100;
                IF CoursesRegz."Total Cores Done" > 0 THEN
                    CoursesRegz."% Failed Cores" := ((CoursesRegz."Failed Cores" / CoursesRegz."Total Cores Done") * 100);
                CoursesRegz."% Failed Cores" := ROUND(CoursesRegz."% Failed Cores", 0.01, '>');
                IF CoursesRegz."% Failed Cores" > 100 THEN CoursesRegz."% Failed Cores" := 100;
                IF CoursesRegz."Total Units" > 0 THEN
                    CoursesRegz."% Failed Units" := (CoursesRegz."Failed Units" / CoursesRegz."Total Units") * 100;
                CoursesRegz."% Failed Units" := ROUND(CoursesRegz."% Failed Units", 0.01, '>');
                IF CoursesRegz."% Failed Units" > 100 THEN CoursesRegz."% Failed Units" := 100;
                IF CoursesRegz."Total Electives Done" > 0 THEN
                    CoursesRegz."% Failed Electives" := (CoursesRegz."Failed Electives" / CoursesRegz."Total Electives Done") * 100;
                CoursesRegz."% Failed Electives" := ROUND(CoursesRegz."% Failed Electives", 0.01, '>');
                IF CoursesRegz."% Failed Electives" > 100 THEN CoursesRegz."% Failed Electives" := 100;
                // CoursesRegz.MODIFY;
                ACAResultsStatus.RESET;
                ACAResultsStatus.SETFILTER("Manual Status Processing", '%1', FALSE);
                ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                IF ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" THEN BEGIN
                    ACAResultsStatus.SETFILTER("Special Programme Class", '=%1', ACAResultsStatus."Special Programme Class"::"Medicine & Nursing");
                END ELSE BEGIN
                    ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                    ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                END;
                ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                ACAResultsStatus.SETCURRENTKEY("Order No");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        StatusRemarks := ACAResultsStatus.Code;
                        IF ACAResultsStatus."Lead Status" <> '' THEN
                            StatusRemarks := ACAResultsStatus."Lead Status";
                        YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        LubricIdentified := TRUE;
                    END;
                    UNTIL ((ACAResultsStatus.NEXT = 0) OR (LubricIdentified = TRUE))
                END;
                CoursesRegz.CALCFIELDS("Supp/Special Exists", "Attained Stage Units", "Special Registration Exists");
                IF CoursesRegz."Required Stage Units" > CoursesRegz."Attained Stage Units" THEN StatusRemarks := 'DTSC';
                IF CoursesRegz."Exists DTSC Prefix" THEN StatusRemarks := 'DTSC';
                IF CoursesRegz."Special Registration Exists" THEN StatusRemarks := 'Special';

                IF CoursesRegz."Exists DTSC Prefix" AND (NOT CoursesRegz."Special Registration Exists") THEN BEGIN
                    EVALUATE(CurrentYear, COPYSTR(CoursesRegz."Academic Year", 6, 4));
                    //get last aca year record
                    ObjCourseReg.RESET;
                    ObjCourseReg.SETRANGE("Student Number", CoursesRegz."Student Number");
                    ObjCourseReg.SETRANGE("Academic Year", (FORMAT(CurrentYear - 2) + '/' + FORMAT(CurrentYear - 1)));
                    IF ObjCourseReg.FINDFIRST THEN BEGIN
                        AcaStoppage.RESET;
                        AcaStoppage.SETRANGE("Reason Code", ObjCourseReg.Classification);
                        AcaStoppage.SETRANGE("Combine Discordant Semesters", TRUE);
                        IF AcaStoppage.FINDFIRST THEN BEGIN
                            ObjCourseReg.CALCFIELDS("Special Registration Exists");
                            IF ObjCourseReg."Special Registration Exists" THEN StatusRemarks := 'Special';
                        END;
                    END;
                END;
                ////////////////////////////////////////////////////////////////////////////////////////////////
                // Check if exists a stopped Semester for the Academic Years and Pick the Status on the lines as the rightful Status
                CLEAR(StudCoregcs24);
                StudCoregcs24.RESET;
                StudCoregcs24.SETRANGE("Student No.", CoursesRegz."Student Number");
                StudCoregcs24.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                StudCoregcs24.SETRANGE(Reversed, TRUE);
                IF StudCoregcs24.FIND('-') THEN BEGIN

                    CLEAR(ACARegStoppageReasons);
                    ACARegStoppageReasons.RESET;
                    ACARegStoppageReasons.SETRANGE("Reason Code", StudCoregcs24."Stoppage Reason");
                    IF ACARegStoppageReasons.FIND('-') THEN BEGIN

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETRANGE(Status, ACARegStoppageReasons."Global Status");
                        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            StatusRemarks := ACAResultsStatus.Code;
                            YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        END ELSE BEGIN
                            // StatusRemarks:=UPPERCASE(FORMAT(Customer.Status));
                            StatusRemarks := UPPERCASE(FORMAT(StudCoregcs24."Stoppage Reason"));
                            YearlyReMarks := StatusRemarks;
                        END;
                    END;
                END;
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

            END ELSE BEGIN

                CoursesRegz.CALCFIELDS("Attained Stage Units");
                IF CoursesRegz."Attained Stage Units" = 0 THEN StatusRemarks := 'DTSC';
                CLEAR(StudCoregcs);
                StudCoregcs.CalcFields("Stoppage Exists In Acad. Year");
                StudCoregcs.RESET;
                StudCoregcs.SETRANGE("Student No.", CoursesRegz."Student Number");
                StudCoregcs.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                StudCoregcs.SETRANGE("Stoppage Exists In Acad. Year", TRUE);
                IF StudCoregcs.FIND('-') THEN BEGIN
                    CLEAR(StudCoregcs2);
                    StudCoregcs2.RESET;
                    StudCoregcs2.SETRANGE("Student No.", CoursesRegz."Student Number");
                    StudCoregcs2.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                    StudCoregcs2.SETRANGE("Stoppage Exists In Acad. Year", TRUE);
                    StudCoregcs2.SETRANGE(Reversed, TRUE);
                    IF StudCoregcs2.FIND('-') THEN BEGIN
                        StatusRemarks := UPPERCASE(FORMAT(StudCoregcs2."Stoppage Reason"));
                        YearlyReMarks := StatusRemarks;
                    END;
                END;

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Status, Customer.Status);
                ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    StatusRemarks := ACAResultsStatus.Code;
                    YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                END ELSE BEGIN
                    StatusRemarks := UPPERCASE(FORMAT(Customer.Status));
                    YearlyReMarks := StatusRemarks;
                END;
            END;
        END;

        CLEAR(ACAResultsStatus);
        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, StatusRemarks);
        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            // Check if the Ststus does not allow Supp. Generation and delete
            IF ACAResultsStatus."Skip Supp Generation" = TRUE THEN BEGIN
                // Delete Entries from Supp Registration for the Semester
                CLEAR(AcaSpecialExamsDetails);
                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE("Student No.", CoursesRegz."Student Number");
                AcaSpecialExamsDetails.SETRANGE("Year of Study", CoursesRegz."Year of Study");
                AcaSpecialExamsDetails.SETRANGE("Exam Marks", 0);
                AcaSpecialExamsDetails.SETRANGE(Semester, Semesz);
                AcaSpecialExamsDetails.SETRANGE(Status, AcaSpecialExamsDetails.Status::New);
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails.Category, AcaSpecialExamsDetails.Category::Supplementary
                );
                IF AcaSpecialExamsDetails.FIND('-') THEN AcaSpecialExamsDetails.DELETEALL;
            END;
        END;
    end;

    local procedure GetRubricPassStatus(RubricCode: Code[50]; AcademicYears: Code[20]; Progyz: Record "ACA-Programme") PassStatus: Boolean
    var
        ACAResultsStatus: Record "ACA-Results Status";
    begin

        ACAResultsStatus.Reset;
        ACAResultsStatus.SetRange(Code, RubricCode);
        ACAResultsStatus.SetRange("Academic Year", AcademicYears);
        ACAResultsStatus.SetRange("Special Programme Class", Progyz."Special Programme Class");
        if ACAResultsStatus.Find('-') then begin
            PassStatus := ACAResultsStatus.Pass;
        end;
    end;

    local procedure GetRubricOrder(RubricCode: Code[50]) RubricOrder: Integer
    var
        ACAResultsStatus: Record "ACA-Results Status";
    begin

        ACAResultsStatus.Reset;
        ACAResultsStatus.SetRange(Code, RubricCode);
        if ACAResultsStatus.Find('-') then begin
            RubricOrder := ACAResultsStatus."Order No";
        end;
    end;

    local procedure GetProgFilters1(Programs: Code[1024]; Schools: Code[1024]) ProgFilters: Code[1024]
    var
        ACAProgramme963: Record "ACA-Programme";
        Progs2: Code[1024];
        exitLoop: Boolean;
    begin
        Clear(Progs2);
        Clear(ProgFilters);
        if ((Schools = '') and (Programs = '')) then Error('Specify a Programme and/or a School filter');
        Clear(exitLoop);
        if Schools <> '' then begin
            ACAProgramme963.Reset;
            ACAProgramme963.SetFilter(ACAProgramme963."School Code", Schools);
            if ACAProgramme963.Find('-') then begin
                repeat
                begin
                    if ACAProgramme963.Code <> '' then begin
                        if ProgFilters = '' then
                            ProgFilters := ACAProgramme963.Code
                        else begin
                            if (StrLen(ProgFilters) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                ProgFilters := ProgFilters + '|' + ACAProgramme963.Code;
                            end else begin
                                // //                IF Progs2='' THEN Progs2:=ACAProgramme963.Code ELSE BEGIN
                                // //                 IF (STRLEN(Progs2)+STRLEN(ACAProgramme963.Code)) < 1024 THEN BEGIN
                                // //                   Progs2:=Progs2+'|'+ACAProgramme963.Code;
                                // //                   END;
                                // //                  END;

                            end;
                        end;
                    end;
                end;
                until ((ACAProgramme963.Next = 0) or (exitLoop = true));
            end;
        end else
            if Programs <> '' then begin
                ProgFilters := Programs;
            end;
    end;

    local procedure GetProgFilters2(Programs: Code[1024]; Schools: Code[1024]) Progs2: Code[1024]
    var
        ACAProgramme963: Record "ACA-Programme";
        ProgFilters: Code[1024];
    begin
        Clear(Progs2);
        Clear(ProgFilters);
        if ((Schools = '') and (Programs = '')) then Error('Specify a Programme and/or a School filter');

        if Schools <> '' then begin
            ACAProgramme963.Reset;
            ACAProgramme963.SetFilter(ACAProgramme963."School Code", Schools);
            if ACAProgramme963.Find('-') then begin
                repeat
                begin
                    if ACAProgramme963.Code <> '' then begin
                        if ProgFilters = '' then
                            ProgFilters := ACAProgramme963.Code
                        else begin
                            if (StrLen(ProgFilters) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                ProgFilters := ProgFilters + '|' + ACAProgramme963.Code;
                            end else begin
                                if Progs2 = '' then
                                    Progs2 := ACAProgramme963.Code else begin
                                    if (StrLen(Progs2) + StrLen(ACAProgramme963.Code)) < 1024 then begin
                                        Progs2 := Progs2 + '|' + ACAProgramme963.Code;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
                until ACAProgramme963.Next = 0;
            end;
        end else
            if Programs <> '' then begin
                ProgFilters := Programs;
            end;
    end;

    local procedure GetUnitAcademicYear(ACAExamClassificationUnits9: Record "ACA-Exam Classification Units") AcademicYear: Code[20]
    var
        ACACourseRegistration9: Record "ACA-Course Registration";
    begin
        Clear(AcademicYear);
        ACACourseRegistration9.Reset;
        ACACourseRegistration9.SetRange("Student No.", ACAExamClassificationUnits9."Student No.");
        ACACourseRegistration9.SetRange(Programmes, ACAExamClassificationUnits9.Programme);
        ACACourseRegistration9.SetRange("Year Of Study", ACAExamClassificationUnits9."Year of Study");
        ACACourseRegistration9.SetRange(Reversed, false);
        ACACourseRegistration9.SetFilter("Academic Year", '<>%1', '');
        if ACACourseRegistration9.Find('-') then AcademicYear := ACACourseRegistration9."Academic Year"
    end;

    local procedure FormatNames(CommonName: Text[250]) NewName: Text[250]
    var
        NamesSmall: Text[250];
        FirsName: Text[250];
        SpaceCount: Integer;
        SpaceFound: Boolean;
        Counts: Integer;
        Strlegnth: Integer;
        OtherNames: Text[250];
        FormerCommonName: Text[250];
        OneSpaceFound: Boolean;
        Countings: Integer;
    begin
        Clear(OneSpaceFound);
        Clear(Countings);
        CommonName := ConvertStr(CommonName, ',', ' ');
        FormerCommonName := '';
        repeat
        begin
            Countings += 1;
            if CopyStr(CommonName, Countings, 1) = ' ' then begin
                if OneSpaceFound = false then FormerCommonName := FormerCommonName + CopyStr(CommonName, Countings, 1);
                OneSpaceFound := true
            end else begin
                OneSpaceFound := false;
                FormerCommonName := FormerCommonName + CopyStr(CommonName, Countings, 1)
            end;
        end;
        until Countings = StrLen(CommonName);
        CommonName := FormerCommonName;
        Clear(NamesSmall);
        Clear(FirsName);
        Clear(SpaceCount);
        Clear(SpaceFound);
        Clear(OtherNames);
        if StrLen(CommonName) > 100 then CommonName := CopyStr(CommonName, 1, 100);
        Strlegnth := StrLen(CommonName);
        if StrLen(CommonName) > 4 then begin
            NamesSmall := LowerCase(CommonName);
            repeat
            begin
                SpaceCount += 1;
                if ((CopyStr(NamesSmall, SpaceCount, 1) = '') or (CopyStr(NamesSmall, SpaceCount, 1) = ' ') or (CopyStr(NamesSmall, SpaceCount, 1) = ',')) then SpaceFound := true;
                if not SpaceFound then begin
                    FirsName := FirsName + UpperCase(CopyStr(NamesSmall, SpaceCount, 1));
                end else begin
                    if StrLen(OtherNames) < 150 then begin
                        if ((CopyStr(NamesSmall, SpaceCount, 1) = '') or (CopyStr(NamesSmall, SpaceCount, 1) = ' ') or (CopyStr(NamesSmall, SpaceCount, 1) = ',')) then begin
                            OtherNames := OtherNames + ' ';
                            SpaceCount += 1;
                            OtherNames := OtherNames + UpperCase(CopyStr(NamesSmall, SpaceCount, 1));
                        end else begin
                            OtherNames := OtherNames + CopyStr(NamesSmall, SpaceCount, 1);
                        end;

                    end;
                end;
            end;
            until ((SpaceCount = Strlegnth))
        end;
        Clear(NewName);
        NewName := FirsName + ',' + OtherNames;
    end;

    local procedure GetCummulativeFails(StudNo: Code[20]; YoS: Integer) CumFails: Integer
    var
        AcadClassUnits: Record "ACA-Exam Classification Units";
    begin
        AcadClassUnits.Reset;
        AcadClassUnits.SetRange("Student No.", StudNo);
        AcadClassUnits.SetFilter("Year of Study", '..%1', YoS);
        AcadClassUnits.SetRange(Pass, false);
        if AcadClassUnits.Find('-') then CumFails := AcadClassUnits.Count;
    end;

    local procedure GetCummulativeReqStageUnitrs(Programmez: Code[20]; YoS: Integer; ProgOption: Code[20]) CummReqUNits: Decimal
    var
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
    begin
        Clear(CummReqUNits);
        ACADefinedUnitsperYoS.Reset;
        ACADefinedUnitsperYoS.SetRange(Programmes, Programmez);
        ACADefinedUnitsperYoS.SetRange(Options, ProgOption);
        ACADefinedUnitsperYoS.SetFilter("Year of Study", '..%1', YoS);
        if ACADefinedUnitsperYoS.Find('-') then begin
            repeat
            begin
                CummReqUNits := CummReqUNits + ACADefinedUnitsperYoS."Number of Units";
            end;
            until ACADefinedUnitsperYoS.Next = 0;
        end;
    end;

    local procedure GetCummAttainedUnits(StudNo: Code[20]; YoS: Integer; Programmesz: Code[20]) CummAttained: Integer
    var
        AcadClassUnits: Record "ACA-Exam Classification Units";
    begin
        AcadClassUnits.Reset;
        AcadClassUnits.SetRange("Student No.", StudNo);
        AcadClassUnits.SetFilter("Year of Study", '..%1', YoS);
        AcadClassUnits.SetFilter(Programme, '%1', Programmesz);
        if AcadClassUnits.Find('-') then CummAttained := AcadClassUnits.Count;
    end;

    procedure GetCummulativeReqStageUnitrs(Programmez: Code[250]; YoS: Integer; ProgOption: Code[250]; AcademicYearssss: Code[250]) CummReqUNits: Decimal
    var
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
    begin
        CLEAR(CummReqUNits);
        ACADefinedUnitsperYoS.RESET;
        ACADefinedUnitsperYoS.SETRANGE(Programmes, Programmez);
        ACADefinedUnitsperYoS.SETRANGE(Options, ProgOption);
        ACADefinedUnitsperYoS.SETRANGE("Academic Year", AcademicYearssss);
        ACADefinedUnitsperYoS.SETFILTER("Year of Study", '..%1', YoS);
        IF ACADefinedUnitsperYoS.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                CummReqUNits := CummReqUNits + ACADefinedUnitsperYoS."Number of Units";
            END;
            UNTIL ACADefinedUnitsperYoS.NEXT = 0;
        END;
    end;

    procedure DeleteSuppPreviousEntries(RefRegularCoRegcs: Record "ACA-Exam. Course Registration")
    var
        ACAExamClassificationStuds: Record "ACA-SuppExam Class. Studs";
        ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
        ACAExamClassificationUnits: Record "ACA-Exam Classification Units";
        ACAExamSuppUnits: Record "ACA-Exam Supp. Units";
    begin
        ProgFIls := RefRegularCoRegcs.Programme;

        CLEAR(ACAExamClassificationStuds);
        CLEAR(ACAExamCourseRegistration);
        CLEAR(ACAExamClassificationUnits);
        CLEAR(ACAExamSuppUnits);
        ACAExamClassificationStuds.RESET;
        ACAExamCourseRegistration.RESET;
        ACAExamClassificationUnits.RESET;
        ACAExamSuppUnits.RESET;
        ACAExamClassificationStuds.SETFILTER("Student Number", RefRegularCoRegcs."Student Number");
        ACAExamCourseRegistration.SETRANGE("Student Number", RefRegularCoRegcs."Student Number");
        ACAExamClassificationUnits.SETRANGE("Student No.", RefRegularCoRegcs."Student Number");
        ACAExamSuppUnits.SETRANGE("Student No.", RefRegularCoRegcs."Student Number");
        ACAExamClassificationStuds.SETFILTER("Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamCourseRegistration.SETFILTER("Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamClassificationUnits.SETFILTER("Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamSuppUnits.SETFILTER("Academic Year", AcadYear);

        ACAExamClassificationStuds.SETFILTER(Programme, ProgFIls);
        ACAExamCourseRegistration.SETFILTER(Programme, ProgFIls);
        ACAExamClassificationUnits.SETFILTER(Programme, ProgFIls);
        ACAExamSuppUnits.SETFILTER(Programme, ProgFIls);
        IF ACAExamClassificationStuds.FIND('-') THEN ACAExamClassificationStuds.DELETEALL;
        IF ACAExamCourseRegistration.FIND('-') THEN ACAExamCourseRegistration.DELETEALL;
        IF ACAExamClassificationUnits.FIND('-') THEN ACAExamClassificationUnits.DELETEALL;
        IF ACAExamSuppUnits.FIND('-') THEN ACAExamSuppUnits.DELETEALL;
    end;

    procedure UpdateSupplementaryMarks(RefRegularCoRegcs: Record "ACA-Exam. Course Registration")
    var
        ACAExamCourseRegistration888: Record "ACA-Exam. Course Registration";
        Aca2ndSuppExamsDetailsforSupps: Record "Aca-2nd Supp. Exams Details";
        RegularExamUnitsRegForSupp: Record "ACA-Exam Classification Units";
        ACAResultsStatus: Record "ACA-Supp. Results Status";
        ACAExamCourseRegistration4SuppGeneration: Record "ACA-Exam. Course Registration";
        CATExists: Boolean;
        CountedSeq: Integer;
        ACAExamCategory: Record "ACA-Exam Category";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        AcaSpecialExamsDetails3: Record "Aca-Special Exams Details";
        ACAExamSuppUnits: Record "ACA-Exam Supp. Units";
        AcdYrs: Record "ACA-Academic Year";
        Custos: Record Customer;
        StudentUnits: Record "ACA-Student Units";
        Coregcsz10: Record "ACA-Course Registration";
        CountedRegistrations: Integer;
        UnitsSubjects: Record "ACA-Units/Subjects";
        Programme_Fin: Record "ACA-Programme";
        ProgrammeStages_Fin: Record "ACA-Programme Stages";
        AcademicYear_Fin: Record "ACA-Academic Year";
        Semesters_Fin: Record "ACA-Semesters";
        ExamResults: Record "ACA-Exam Results";
        ClassCustomer: Record Customer;
        ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
        ClassDimensionValue: Record "Dimension Value";
        ClassGradingSystem: Record "ACA-Grading System";
        ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ClassExamResults2: Record "ACA-Exam Results";
        TotalRecs: Integer;
        CountedRecs: Integer;
        RemeiningRecs: Integer;
        ExpectedElectives: Integer;
        CountedElectives: Integer;
        Progyz: Record "ACA-Programme";
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
        ACAExamClassificationUnits: Record "ACA-SuppExam Class. Units";
        ACAExamCourseRegistration: Record "ACA-SuppExam. Co. Reg.";
        ACAExamFailedReasons: Record "ACA-SuppExam Fail Reasons";
        ACASenateReportsHeader: Record "ACA-SuppSenate Repo. Header";
        ACAExamClassificationStuds: Record "ACA-SuppExam Class. Studs";
        ACAExamClassificationStudsCheck: Record "ACA-SuppExam Class. Studs";
        ACAExamResultsFin: Record "ACA-Exam Results";
        ACAResultsStatusSuppGen: Record "ACA-Results Status";
        ProgressForCoReg: Dialog;
        Tens: Text;
        ACASemesters: Record "ACA-Semesters";
        ACAExamResults_Fin: Record "ACA-Exam Results";
        Coregcs: Record "ACA-Course Registration";
        ACAExamCummulativeResit: Record "ACA-SuppExam Cumm. Resit";
        ACAStudentUnitsForResits: Record "ACA-Student Units";
        SEQUENCES: Integer;
        CurrStudentNo: Code[250];
        CountedNos: Integer;
        CurrSchool: Code[250];
        Aca2ndSuppExamsDetails: Record "Aca-2nd Supp. Exams Details";
        Aca2ndSuppExamsResults: Record "Aca-2nd Supp. Exams Results";
        Aca2ndSuppExamsDetails3: Record "Aca-2nd Supp. Exams Details";
        Aca2ndSuppExamsDetails4: Record "Aca-2nd Supp. Exams Details";
        AcaSpecialExamsDetails4: Record "Aca-Special Exams Details";
        ACAResultsStatusSupp: Record "ACA-Supp. Results Status";
    begin
        ProgFIls := RefRegularCoRegcs.Programme;

        CLEAR(ACAExamClassificationStuds);
        CLEAR(ACAExamCourseRegistration);
        CLEAR(ACAExamClassificationUnits);
        CLEAR(ACAExamSuppUnits);
        ACAExamClassificationStuds.RESET;
        ACAExamCourseRegistration.RESET;
        ACAExamClassificationUnits.RESET;
        ACAExamSuppUnits.RESET;
        ACAExamClassificationStuds.SETFILTER("Student Number", RefRegularCoRegcs."Student Number");
        ACAExamCourseRegistration.SETRANGE("Student Number", RefRegularCoRegcs."Student Number");
        ACAExamClassificationUnits.SETRANGE("Student No.", RefRegularCoRegcs."Student Number");
        ACAExamSuppUnits.SETRANGE("Student No.", RefRegularCoRegcs."Student Number");
        ACAExamClassificationStuds.SETFILTER("Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamCourseRegistration.SETFILTER("Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamClassificationUnits.SETFILTER("Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamSuppUnits.SETFILTER("Academic Year", AcadYear);

        ACAExamClassificationStuds.SETFILTER(Programme, ProgFIls);
        ACAExamCourseRegistration.SETFILTER(Programme, ProgFIls);
        ACAExamClassificationUnits.SETFILTER(Programme, ProgFIls);
        ACAExamSuppUnits.SETFILTER(Programme, ProgFIls);
        IF ACAExamClassificationStuds.FIND('-') THEN ACAExamClassificationStuds.DELETEALL;
        IF ACAExamCourseRegistration.FIND('-') THEN ACAExamCourseRegistration.DELETEALL;
        IF ACAExamClassificationUnits.FIND('-') THEN ACAExamClassificationUnits.DELETEALL;
        IF ACAExamSuppUnits.FIND('-') THEN ACAExamSuppUnits.DELETEALL;

        ///// Create Supp. Entries Here
        ////////////////////////////////////////////////////////////////////////////
        //  Supp. Headers

        Progyz.RESET;
        IF Progyz.GET(RefRegularCoRegcs.Programme) THEN;

        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE("Special Programme Class", Progyz."Special Programme Class");
        ACAResultsStatus.SETRANGE("Academic Year", RefRegularCoRegcs."Academic Year");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                ACASenateReportsHeader.RESET;
                ACASenateReportsHeader.SETRANGE("Academic Year", RefRegularCoRegcs."Academic Year");
                ACASenateReportsHeader.SETRANGE("School Code", Progyz."School Code");
                ACASenateReportsHeader.SETRANGE("Classification Code", ACAResultsStatus.Code);
                ACASenateReportsHeader.SETRANGE("Programme Code", Progyz.Code);
                ACASenateReportsHeader.SETRANGE("Year of Study", RefRegularCoRegcs."Year of Study");
                IF NOT (ACASenateReportsHeader.FIND('-')) THEN BEGIN
                    ACASenateReportsHeader.INIT;
                    ACASenateReportsHeader."Academic Year" := RefRegularCoRegcs."Academic Year";
                    ACASenateReportsHeader."Reporting Academic Year" := RefRegularCoRegcs."Academic Year";
                    ACASenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                    ACASenateReportsHeader."Programme Code" := Progyz.Code;
                    ACASenateReportsHeader."School Code" := Progyz."School Code";
                    ACASenateReportsHeader."Year of Study" := RefRegularCoRegcs."Year of Study";
                    ACASenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                    ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                    ACASenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                    ACASenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                    ACASenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                    ACASenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                    ACASenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                    ACASenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                    ACASenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                    ACASenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                    ACASenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                    ACASenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                    ACASenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                    ACASenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                    ACASenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                    ACASenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                    ACASenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                    ACASenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                    ACASenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                    ACASenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                    ACASenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                    ACASenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                    ACASenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                    ACASenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                    ACASenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                    ACASenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                    ACASenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                    ACASenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                    ACASenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                    ACASenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                    ACASenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                    ACASenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                    IF ACASenateReportsHeader.INSERT THEN;
                END;
            END;
            UNTIL ACAResultsStatus.NEXT = 0;
        END;
        ////////////////////////////////////////////////////////////////////////////
        ACAExamClassificationStuds.RESET;
        ACAExamClassificationStuds.SETRANGE("Student Number", RefRegularCoRegcs."Student Number");
        ACAExamClassificationStuds.SETRANGE(Programme, RefRegularCoRegcs.Programme);
        ACAExamClassificationStuds.SETRANGE("Academic Year", RefRegularCoRegcs."Academic Year");
        IF NOT ACAExamClassificationStuds.FIND('-') THEN BEGIN
            ACAExamClassificationStuds.INIT;
            ACAExamClassificationStuds."Student Number" := RefRegularCoRegcs."Student Number";
            ACAExamClassificationStuds."Reporting Academic Year" := RefRegularCoRegcs."Academic Year";
            ACAExamClassificationStuds."School Code" := Progyz."School Code";
            ACAExamClassificationStuds.Department := Progyz."Department Code";
            ACAExamClassificationStuds."Programme Option" := RefRegularCoRegcs."Programme Option";
            ACAExamClassificationStuds.Programme := RefRegularCoRegcs.Programme;
            ACAExamClassificationStuds."Academic Year" := RefRegularCoRegcs."Academic Year";
            ACAExamClassificationStuds."Year of Study" := RefRegularCoRegcs."Year of Study";
            ACAExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
            ACAExamClassificationStuds."Student Name" := GetStudentName(RefRegularCoRegcs."Student Number");
            ACAExamClassificationStuds.Cohort := GetCohort(RefRegularCoRegcs."Student Number", RefRegularCoRegcs.Programme);
            ACAExamClassificationStuds."Final Stage" := GetFinalStage(RefRegularCoRegcs.Programme);
            ACAExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(RefRegularCoRegcs."Student Number", RefRegularCoRegcs.Programme);
            ACAExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(RefRegularCoRegcs.Programme);
            ACAExamClassificationStuds."Admission Date" := GetAdmissionDate(RefRegularCoRegcs."Student Number", RefRegularCoRegcs.Programme);
            ACAExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(RefRegularCoRegcs."Student Number", RefRegularCoRegcs.Programme);
            ACAExamClassificationStuds.Graduating := FALSE;
            ACAExamClassificationStuds.Classification := '';
            IF ACAExamClassificationStuds.INSERT THEN;
        END;
        /////////////////////////////////////// YoS Tracker
        ACAExamCourseRegistration.RESET;
        ACAExamCourseRegistration.SETRANGE("Student Number", RefRegularCoRegcs."Student Number");
        ACAExamCourseRegistration.SETRANGE(Programme, RefRegularCoRegcs.Programme);
        ACAExamCourseRegistration.SETRANGE("Year of Study", RefRegularCoRegcs."Year of Study");
        ACAExamCourseRegistration.SETRANGE("Academic Year", RefRegularCoRegcs."Academic Year");
        IF NOT ACAExamCourseRegistration.FIND('-') THEN BEGIN
            ACAExamCourseRegistration.INIT;
            ACAExamCourseRegistration."Student Number" := RefRegularCoRegcs."Student Number";
            ACAExamCourseRegistration.Programme := RefRegularCoRegcs.Programme;
            ACAExamCourseRegistration."Year of Study" := RefRegularCoRegcs."Year of Study";
            ACAExamCourseRegistration."Reporting Academic Year" := RefRegularCoRegcs."Academic Year";
            ACAExamCourseRegistration."Academic Year" := RefRegularCoRegcs."Academic Year";
            ACAExamCourseRegistration."School Code" := Progyz."School Code";
            ACAExamCourseRegistration."Programme Option" := RefRegularCoRegcs."Programme Option";
            ACAExamCourseRegistration."School Name" := ACAExamClassificationStuds."School Name";
            ACAExamCourseRegistration."Student Name" := ACAExamClassificationStuds."Student Name";
            ACAExamCourseRegistration.Cohort := ACAExamClassificationStuds.Cohort;
            ACAExamCourseRegistration."Final Stage" := ACAExamClassificationStuds."Final Stage";
            ACAExamCourseRegistration."Final Academic Year" := ACAExamClassificationStuds."Final Academic Year";
            ACAExamCourseRegistration."Final Year of Study" := ACAExamClassificationStuds."Final Year of Study";
            ACAExamCourseRegistration."Admission Date" := ACAExamClassificationStuds."Admission Date";
            ACAExamCourseRegistration."Admission Academic Year" := ACAExamClassificationStuds."Admission Academic Year";

            IF ((Progyz.Category = Progyz.Category::"Certificate") OR
               (Progyz.Category = Progyz.Category::"Course List") OR
               (Progyz.Category = Progyz.Category::Professional)) THEN BEGIN
                ACAExamCourseRegistration."Category Order" := 2;
            END ELSE IF (Progyz.Category = Progyz.Category::Diploma) THEN BEGIN
                ACAExamCourseRegistration."Category Order" := 3;
            END ELSE IF (Progyz.Category = Progyz.Category::Postgraduate) THEN BEGIN
                ACAExamCourseRegistration."Category Order" := 4;
            END ELSE IF (Progyz.Category = Progyz.Category::Undergraduate) THEN BEGIN
                ACAExamCourseRegistration."Category Order" := 1;
            END;

            ACAExamCourseRegistration.Graduating := FALSE;
            ACAExamCourseRegistration.Classification := '';
            CLEAR(ACAExamCourseRegistration888);
            ACAExamCourseRegistration888.RESET;
            ACAExamCourseRegistration888.SETRANGE("Skip Supplementary Generation", FALSE);
            ACAExamCourseRegistration888.SETRANGE("Student Number", RefRegularCoRegcs."Student Number");
            ACAExamCourseRegistration888.SETRANGE("Academic Year", RefRegularCoRegcs."Academic Year");
            IF ACAExamCourseRegistration888.FIND('-') THEN
                IF ACAExamCourseRegistration.INSERT(TRUE) THEN;
        END;

        // Create Units for the Supp Registration ***********************************
        CLEAR(RegularExamUnitsRegForSupp);
        RegularExamUnitsRegForSupp.RESET;
        RegularExamUnitsRegForSupp.SETRANGE(RegularExamUnitsRegForSupp."Student No.", RefRegularCoRegcs."Student Number");
        RegularExamUnitsRegForSupp.SETRANGE(RegularExamUnitsRegForSupp.Programme, RefRegularCoRegcs.Programme);
        RegularExamUnitsRegForSupp.SETRANGE(RegularExamUnitsRegForSupp."Academic Year", RefRegularCoRegcs."Academic Year");
        IF RegularExamUnitsRegForSupp.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                IF ((RegularExamUnitsRegForSupp."Unit Code" = 'BHR 315') AND (RefRegularCoRegcs."Academic Year" = '2022/2023')) THEN
                    CLEAR(StudentUnits);
                CLEAR(StudentUnits);
                StudentUnits.RESET;
                StudentUnits.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                StudentUnits.SETRANGE(Unit, RegularExamUnitsRegForSupp."Unit Code");
                StudentUnits.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                StudentUnits.SETRANGE("Reg. Reversed", FALSE);
                // StudentUnits.SETRANGE("Academic Year (Flow)",RegularExamUnitsRegForSupp."Academic Year");
                IF StudentUnits.FIND('-') THEN BEGIN

                    CLEAR(CATExists);
                    CLEAR(ACAExamResults_Fin);
                    ACAExamResults_Fin.RESET;
                    ACAExamResults_Fin.SETRANGE("Student No.", StudentUnits."Student No.");
                    ACAExamResults_Fin.SETRANGE(Unit, StudentUnits.Unit);
                    ACAExamResults_Fin.SETRANGE(Semester, StudentUnits.Semester);
                    ACAExamResults_Fin.SETFILTER(Exam, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                    ACAExamResults_Fin.SETCURRENTKEY(Score);
                    IF ACAExamResults_Fin.FIND('+') THEN BEGIN
                        CATExists := TRUE;
                    END;
                    Coregcs.RESET;
                    Coregcs.SETFILTER(Programmes, StudentUnits.Programme);
                    //Coregcs.SETFILTER("Academic Year",RegularExamUnitsRegForSupp."Academic Year");
                    Coregcs.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                    Coregcs.SETRANGE(Semester, StudentUnits.Semester);
                    IF Coregcs.FIND('-') THEN BEGIN
                        RegularExamUnitsRegForSupp.CALCFIELDS(Pass, "Exam Category");

                        CLEAR(UnitsSubjects);
                        UnitsSubjects.RESET;
                        UnitsSubjects.SETRANGE("Programme Code", RefRegularCoRegcs.Programme);
                        UnitsSubjects.SETRANGE(Code, RegularExamUnitsRegForSupp."Unit Code");
                        IF UnitsSubjects.FIND('-') THEN BEGIN

                            IF UnitsSubjects."Default Exam Category" = '' THEN UnitsSubjects."Default Exam Category" := Progyz."Exam Category";
                            IF UnitsSubjects."Exam Category" = '' THEN UnitsSubjects."Exam Category" := Progyz."Exam Category";
                            UnitsSubjects.MODIFY;
                            CLEAR(ACAExamClassificationUnits);
                            ACAExamClassificationUnits.RESET;
                            ACAExamClassificationUnits.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                            ACAExamClassificationUnits.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                            ACAExamClassificationUnits.SETRANGE("Unit Code", RegularExamUnitsRegForSupp."Unit Code");
                            ACAExamClassificationUnits.SETRANGE("Academic Year", RegularExamUnitsRegForSupp."Academic Year");
                            IF NOT ACAExamClassificationUnits.FIND('-') THEN BEGIN
                                ACAExamClassificationUnits.INIT;
                                ACAExamClassificationUnits."Student No." := RegularExamUnitsRegForSupp."Student No.";
                                ACAExamClassificationUnits.Programme := RegularExamUnitsRegForSupp.Programme;
                                ACAExamClassificationUnits."Reporting Academic Year" := RegularExamUnitsRegForSupp."Academic Year";
                                ACAExamClassificationUnits."School Code" := Progyz."School Code";
                                ACAExamClassificationUnits."Unit Code" := RegularExamUnitsRegForSupp."Unit Code";
                                ACAExamClassificationUnits."Credit Hours" := UnitsSubjects."No. Units";
                                ACAExamClassificationUnits."Unit Type" := FORMAT(UnitsSubjects."Unit Type");
                                ACAExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                ACAExamClassificationUnits."Year of Study" := RegularExamUnitsRegForSupp."Year of Study";
                                ACAExamClassificationUnits."Academic Year" := RegularExamUnitsRegForSupp."Academic Year";
                                ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";

                                CLEAR(ExamResults);
                                ExamResults.RESET;
                                ExamResults.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                                ExamResults.SETRANGE(Unit, StudentUnits.Unit);
                                IF ExamResults.FIND('-') THEN BEGIN
                                    ExamResults.CALCFIELDS("Number of Repeats", "Number of Resits");
                                    IF ExamResults."Number of Repeats" > 0 THEN
                                        ACAExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                    IF ExamResults."Number of Resits" > 0 THEN
                                        ACAExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                END;

                                IF ACAExamClassificationUnits.INSERT THEN;
                            END;

                            /////////////////////////// Update Unit Score
                            CLEAR(ACAExamClassificationUnits);
                            ACAExamClassificationUnits.RESET;
                            ACAExamClassificationUnits.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                            ACAExamClassificationUnits.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                            ACAExamClassificationUnits.SETRANGE("Unit Code", RegularExamUnitsRegForSupp."Unit Code");
                            ACAExamClassificationUnits.SETRANGE("Academic Year", RegularExamUnitsRegForSupp."Academic Year");
                            IF ACAExamClassificationUnits.FIND('-') THEN BEGIN
                                ACAExamClassificationUnits.CALCFIELDS("Is Supp. Unit", "Is Special Unit");

                                IF ACAExamClassificationUnits."Is Special Unit" = TRUE THEN BEGIN
                                    //  Pick Special Marks here and leave value of Sore to Zero if Mark does not exist
                                    // Check for Special Marks if exists
                                    CLEAR(AcaSpecialExamsDetails);
                                    AcaSpecialExamsDetails.RESET;
                                    AcaSpecialExamsDetails.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                                    AcaSpecialExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                    AcaSpecialExamsDetails.SETRANGE(Category, AcaSpecialExamsDetails.Category::Special);
                                    AcaSpecialExamsDetails.SETFILTER("Exam Marks", '<>%1', 0);
                                    IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                                        ACAExamClassificationUnits."Exam Score" := FORMAT(ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '='));
                                        ACAExamClassificationUnits."Exam Score Decimal" := ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '=');
                                        ACAExamClassificationUnits."Total Score" := FORMAT(ACAExamClassificationUnits."Exam Score Decimal" +
                                        ACAExamClassificationUnits."CAT Score Decimal");
                                        ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal" + ACAExamClassificationUnits."CAT Score Decimal";
                                        ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Total Score Decimal" *
                                        RegularExamUnitsRegForSupp."Credit Hours";
                                        //Update Total Marks
                                        IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = FALSE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                        END ELSE IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = TRUE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                        END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = FALSE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                        END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = TRUE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                        END;
                                        ACAExamClassificationUnits."Total Score Decimal" := ROUND(ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');
                                        ACAExamClassificationUnits."Total Score" := FORMAT(ACAExamClassificationUnits."Total Score Decimal");
                                        ACAExamClassificationUnits."Weighted Total Score" := ROUND(ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');

                                    END;
                                    // //                  ACAExamClassificationUnits."Total Score Decimal":=ROUND(ACAExamClassificationUnits."Exam Score Decimal",0.01,'=');
                                    // //                  ACAExamClassificationUnits."Total Score Decimal":=GetSuppMaxScore(AcaSpecialExamsDetails,Progyz."Exam Category",ACAExamClassificationUnits."Total Score Decimal");
                                    // //                  ACAExamClassificationUnits."Total Score":=FORMAT(ROUND(ACAExamClassificationUnits."Total Score Decimal",0.01,'='));
                                    // //                  ACAExamClassificationUnits."Weighted Total Score":=ROUND(ACAExamClassificationUnits."Credit Hours"*ACAExamClassificationUnits."Total Score Decimal",0.01,'=');

                                END;
                                IF ACAExamClassificationUnits."Is Supp. Unit" THEN BEGIN
                                    /////////////////////////////////////////////////////////////////////////////////////////

                                    //  Pick Supp Marks here and leave value of Sore to Zero if Mark does not exist
                                    // Check for Supp Marks if exists
                                    CLEAR(AcaSpecialExamsDetails);
                                    AcaSpecialExamsDetails.RESET;
                                    AcaSpecialExamsDetails.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                                    AcaSpecialExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                    AcaSpecialExamsDetails.SETRANGE(Category, AcaSpecialExamsDetails.Category::Supplementary);
                                    // AcaSpecialExamsDetails.SETRANGE(Semester,StudentUnits.Semester);
                                    AcaSpecialExamsDetails.SETFILTER("Exam Marks", '<>%1', 0);
                                    IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                                        ACAExamClassificationUnits."Exam Score" := FORMAT(ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '='));
                                        ACAExamClassificationUnits."Exam Score Decimal" := ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '=');
                                        ACAExamClassificationUnits."CAT Score" := '0';
                                        ACAExamClassificationUnits."CAT Score Decimal" := 0;
                                        ACAExamClassificationUnits."Total Score" := ACAExamClassificationUnits."Exam Score";
                                        ACAExamClassificationUnits."Total Score Decimal" := ACAExamClassificationUnits."Exam Score Decimal";
                                        ACAExamClassificationUnits."Weighted Total Score" := ACAExamClassificationUnits."Exam Score Decimal" * RegularExamUnitsRegForSupp."Credit Hours";
                                        //Update Total Marks
                                        IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = FALSE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                        END ELSE IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = TRUE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                        END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = FALSE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                        END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = TRUE)) THEN BEGIN
                                            ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                        END;
                                        ACAExamClassificationUnits."Total Score Decimal" := ROUND(ACAExamClassificationUnits."Exam Score Decimal", 0.01, '=');
                                        ACAExamClassificationUnits."Total Score Decimal" := GetSuppMaxScore(Progyz."Exam Category", ACAExamClassificationUnits."Total Score Decimal");
                                        ACAExamClassificationUnits."Total Score" := FORMAT(ROUND(ACAExamClassificationUnits."Total Score Decimal", 0.01, '='));
                                        ACAExamClassificationUnits."Weighted Total Score" := ROUND(ACAExamClassificationUnits."Credit Hours" * ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');

                                    END;
                                    //////////////////////////////////////////////////////////////////////////////////////////////////
                                END;
                                IF RegularExamUnitsRegForSupp.Pass THEN BEGIN
                                    // Capture Regular Marks here Since the Unit was Passed by the Student
                                    ACAExamClassificationUnits."CAT Score" := RegularExamUnitsRegForSupp."CAT Score";
                                    ACAExamClassificationUnits."CAT Score Decimal" := RegularExamUnitsRegForSupp."CAT Score Decimal";
                                    ACAExamClassificationUnits."Results Exists Status" := RegularExamUnitsRegForSupp."Results Exists Status";
                                    ACAExamClassificationUnits."Exam Score" := RegularExamUnitsRegForSupp."Exam Score";
                                    ACAExamClassificationUnits."Exam Score Decimal" := RegularExamUnitsRegForSupp."Exam Score Decimal";
                                    ACAExamClassificationUnits."Total Score" := RegularExamUnitsRegForSupp."Total Score";
                                    ACAExamClassificationUnits."Total Score Decimal" := RegularExamUnitsRegForSupp."Total Score Decimal";
                                    ACAExamClassificationUnits."Weighted Total Score" := RegularExamUnitsRegForSupp."Weighted Total Score";
                                END;
                                ACAExamClassificationUnits.MODIFY;
                            END;
                            ////////////*********************************************
                            //////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                            // Check for Special Exams Score if Exists

                            CLEAR(AcaSpecialExamsDetails);
                            AcaSpecialExamsDetails.RESET;
                            AcaSpecialExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                            AcaSpecialExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                            AcaSpecialExamsDetails.SETRANGE(Category, AcaSpecialExamsDetails.Category::Special);
                            // AcaSpecialExamsDetails.SETRANGE(Semester,StudentUnits.Semester);
                            AcaSpecialExamsDetails.SETFILTER("Exam Marks", '<>%1', 0);
                            IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                                IF AcaSpecialExamsDetails."Exam Marks" <> 0 THEN
                                    ACAExamClassificationUnits."Exam Score" := FORMAT(ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '='))
                                ELSE
                                    ACAExamClassificationUnits."Exam Score" := '';
                                ACAExamClassificationUnits."Exam Score Decimal" := ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '=');
                                IF ACAExamResults_Fin.Score <> 0 THEN
                                    ACAExamClassificationUnits."CAT Score" := FORMAT(ROUND(ACAExamResults_Fin.Score, 0.01, '='))
                                ELSE
                                    ACAExamClassificationUnits."CAT Score" := '';
                                ACAExamClassificationUnits."CAT Score Decimal" := ROUND(ACAExamResults_Fin.Score, 0.01, '=');
                                //Update Total Marks
                                IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = FALSE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                END ELSE IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = TRUE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = FALSE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = TRUE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                END;
                                ACAExamClassificationUnits."Total Score Decimal" := ROUND(ACAExamClassificationUnits."Exam Score Decimal" +
                                ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                ACAExamClassificationUnits."Total Score" := FORMAT(ROUND(ACAExamClassificationUnits."Total Score Decimal", 0.01, '='));
                                ACAExamClassificationUnits."Weighted Total Score" := ROUND(ACAExamClassificationUnits."Credit Hours" *
                                ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');

                            END;

                            ///////////////////////////////////////////////////////// End of Supps Score Updates
                            CLEAR(AcaSpecialExamsDetails);
                            AcaSpecialExamsDetails.RESET;
                            AcaSpecialExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                            AcaSpecialExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                            AcaSpecialExamsDetails.SETFILTER("Exam Marks", '<>%1', 0);
                            //  AcaSpecialExamsDetails.SETRANGE(Semester,StudentUnits.Semester);
                            IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                                ACAExamSuppUnits.INIT;
                                ACAExamSuppUnits."Student No." := StudentUnits."Student No.";
                                ACAExamSuppUnits."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                ACAExamSuppUnits."Unit Description" := ACAExamClassificationUnits."Unit Description";
                                ACAExamSuppUnits."Unit Type" := ACAExamClassificationUnits."Unit Type";
                                ACAExamSuppUnits.Programme := ACAExamClassificationUnits.Programme;
                                ACAExamSuppUnits."Academic Year" := ACAExamClassificationUnits."Academic Year";
                                ACAExamSuppUnits."Credit Hours" := ACAExamClassificationUnits."Credit Hours";
                                IF AcaSpecialExamsDetails.Category = AcaSpecialExamsDetails.Category::Supplementary THEN BEGIN
                                    ACAExamSuppUnits."Exam Score" := FORMAT(ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '='));
                                    ACAExamSuppUnits."Exam Score Decimal" := ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '=');
                                    ACAExamSuppUnits."CAT Score" := FORMAT(ROUND(ACAExamClassificationUnits."CAT Score Decimal", 0.01, '='));
                                    ACAExamSuppUnits."CAT Score Decimal" := ROUND(ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                    ACAExamSuppUnits."Total Score Decimal" := ROUND((GetSuppMaxScore(Progyz."Exam Category", (ROUND(ACAExamSuppUnits."Exam Score Decimal", 0.01, '=')))), 0.01, '=');
                                    ACAExamSuppUnits."Total Score" := FORMAT(ACAExamSuppUnits."Total Score Decimal");
                                END ELSE IF AcaSpecialExamsDetails.Category = AcaSpecialExamsDetails.Category::Special THEN BEGIN
                                    ACAExamSuppUnits."Exam Score Decimal" := ROUND(AcaSpecialExamsDetails."Exam Marks", 0.01, '=');
                                    ACAExamSuppUnits."Exam Score" := FORMAT(ROUND(AcaSpecialExamsDetails."Exam Marks", 0.01, '='));
                                    ACAExamSuppUnits."CAT Score" := FORMAT(ROUND(ACAExamClassificationUnits."CAT Score Decimal", 0.01, '='));
                                    ACAExamSuppUnits."CAT Score Decimal" := ROUND(ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                    ACAExamSuppUnits."Total Score Decimal" := GetSuppMaxScore(Progyz."Exam Category", (ROUND(AcaSpecialExamsDetails."Exam Marks" + ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=')));
                                    ACAExamSuppUnits."Total Score" := FORMAT(ACAExamSuppUnits."Total Score Decimal");
                                END;
                                ACAExamSuppUnits."Exam Category" := ACAExamClassificationUnits."Exam Category";
                                ACAExamSuppUnits."Allow In Graduate" := TRUE;
                                ACAExamSuppUnits."Year of Study" := ACAExamClassificationUnits."Year of Study";
                                ACAExamSuppUnits.Cohort := ACAExamClassificationUnits.Cohort;
                                ACAExamSuppUnits."School Code" := ACAExamClassificationUnits."School Code";
                                ACAExamSuppUnits."Department Code" := ACAExamClassificationUnits."Department Code";
                                IF ACAExamSuppUnits.INSERT THEN;
                                ACAExamClassificationUnits.MODIFY;
                                //  END;
                            END;
                            //////////////////******************************************************

                            // Check for Special Exams Score if Exists

                            CLEAR(AcaSpecialExamsDetails);
                            AcaSpecialExamsDetails.RESET;
                            AcaSpecialExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                            AcaSpecialExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                            AcaSpecialExamsDetails.SETRANGE(Category, AcaSpecialExamsDetails.Category::Supplementary);
                            // AcaSpecialExamsDetails.SETRANGE(Semester,StudentUnits.Semester);
                            AcaSpecialExamsDetails.SETFILTER("Exam Marks", '<>%1', 0);
                            IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                                IF AcaSpecialExamsDetails."Exam Marks" <> 0 THEN
                                    ACAExamClassificationUnits."Exam Score" := FORMAT(ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '='))
                                ELSE
                                    ACAExamClassificationUnits."Exam Score" := '';
                                ACAExamClassificationUnits."Exam Score Decimal" := ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '=');
                                IF ACAExamResults_Fin.Score <> 0 THEN
                                    ACAExamClassificationUnits."CAT Score" := ''
                                //                  ACAExamClassificationUnits."CAT Score":=FORMAT(ROUND(ACAExamResults_Fin.Score,0.01,'='))
                                ELSE
                                    ACAExamClassificationUnits."CAT Score" := '';
                                // ACAExamClassificationUnits."CAT Score Decimal":=ROUND(ACAExamResults_Fin.Score,0.01,'=');
                                ACAExamClassificationUnits."CAT Score Decimal" := 0;
                                //Update Total Marks
                                IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = FALSE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"None Exists";
                                END ELSE IF ((ACAExamClassificationUnits."Exam Score" = '') AND (CATExists = TRUE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"CAT Only";
                                END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = FALSE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Exam Only";
                                END ELSE IF ((ACAExamClassificationUnits."Exam Score" <> '') AND (CATExists = TRUE)) THEN BEGIN
                                    ACAExamClassificationUnits."Results Exists Status" := ACAExamClassificationUnits."Results Exists Status"::"Both Exists";
                                END;
                                ACAExamClassificationUnits."Total Score Decimal" := ROUND(ACAExamClassificationUnits."Exam Score Decimal" +
                                ACAExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                ACAExamClassificationUnits."Total Score" := FORMAT(ROUND(ACAExamClassificationUnits."Total Score Decimal", 0.01, '='));
                                ACAExamClassificationUnits."Weighted Total Score" := ROUND(ACAExamClassificationUnits."Credit Hours" *
                                ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');

                            END;
                            //////////////////////*******************************************************
                            ACAExamClassificationUnits."Allow In Graduate" := TRUE;
                            ACAExamClassificationUnits.MODIFY;
                            /// Update Cummulative Resit
                            ACAExamClassificationUnits.CALCFIELDS(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                            IF ACAExamClassificationUnits.Pass THEN BEGIN
                                // Remove from Cummulative Resits
                                ACAExamCummulativeResit.RESET;
                                ACAExamCummulativeResit.SETRANGE("Student Number", StudentUnits."Student No.");
                                ACAExamCummulativeResit.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                ACAExamCummulativeResit.SETRANGE("Academic Year", Coregcs."Academic Year");
                                IF ACAExamCummulativeResit.FIND('-') THEN ACAExamCummulativeResit.DELETEALL;
                                // //
                                // //            CLEAR(AcaSpecialExamsDetails);
                                // //                    AcaSpecialExamsDetails.RESET;
                                // //                    AcaSpecialExamsDetails.SETRANGE("Student No.",StudentUnits."Student No.");
                                // //                    AcaSpecialExamsDetails.SETRANGE("Unit Code",ACAExamClassificationUnits."Unit Code");
                                // //                    AcaSpecialExamsDetails.SETRANGE(Category,AcaSpecialExamsDetails.Category::Supplementary);
                                // //                    AcaSpecialExamsDetails.SETFILTER("Exam Marks",'%1',0);
                                // //                    IF AcaSpecialExamsDetails.FIND('-') THEN AcaSpecialExamsDetails.DELETEALL;

                                CLEAR(Aca2ndSuppExamsDetails);
                                Aca2ndSuppExamsDetails.RESET;
                                Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                Aca2ndSuppExamsDetails.SETFILTER("Exam Marks", '%1', 0);
                                IF Aca2ndSuppExamsDetails.FIND('-') THEN Aca2ndSuppExamsDetails.DELETEALL;
                            END ELSE BEGIN
                                // Student Failed Supp or Special. Register for the second Supp if first Supp Failed and 1st Supp if Special Failed

                                CLEAR(Aca2ndSuppExamsDetails);
                                Aca2ndSuppExamsDetails.RESET;
                                Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                Aca2ndSuppExamsDetails.SETFILTER("Exam Marks", '%1', 0);
                                IF Aca2ndSuppExamsDetails.FIND('-') THEN Aca2ndSuppExamsDetails.DELETEALL;
                                //Aca2ndSuppExamsDetails3
                                CLEAR(AcaSpecialExamsDetails);
                                AcaSpecialExamsDetails.RESET;
                                AcaSpecialExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                AcaSpecialExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                AcaSpecialExamsDetails.SETRANGE(Category, AcaSpecialExamsDetails.Category::Supplementary);
                                AcaSpecialExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                IF NOT (AcaSpecialExamsDetails.FIND('-')) THEN BEGIN
                                    //  Register Supp for Special that is Failed
                                    // The Failed Unit is not in Supp Special, Register The Unit here
                                    CLEAR(CountedSeq);
                                    CLEAR(AcaSpecialExamsDetails3);
                                    AcaSpecialExamsDetails3.RESET;
                                    AcaSpecialExamsDetails3.SETRANGE("Student No.", StudentUnits."Student No.");
                                    AcaSpecialExamsDetails3.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                    AcaSpecialExamsDetails3.SETCURRENTKEY(Sequence);
                                    IF AcaSpecialExamsDetails3.FIND('+') THEN BEGIN
                                        CountedSeq := AcaSpecialExamsDetails3.Sequence;
                                    END ELSE BEGIN
                                        CountedSeq := 0;
                                    END;
                                    CountedSeq += 1;
                                    AcaSpecialExamsDetails.INIT;
                                    AcaSpecialExamsDetails.Stage := StudentUnits.Stage;
                                    AcaSpecialExamsDetails.Status := AcaSpecialExamsDetails.Status::New;
                                    AcaSpecialExamsDetails."Student No." := StudentUnits."Student No.";
                                    AcaSpecialExamsDetails."Academic Year" := Coregcs."Academic Year";
                                    AcaSpecialExamsDetails."Unit Code" := StudentUnits.Unit;
                                    AcaSpecialExamsDetails.Semester := StudentUnits.Semester;
                                    AcaSpecialExamsDetails.Sequence := CountedSeq;
                                    AcaSpecialExamsDetails."Current Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                    AcaSpecialExamsDetails.Category := AcaSpecialExamsDetails.Category::Supplementary;
                                    AcaSpecialExamsDetails.Programme := StudentUnits.Programme;

                                    CLEAR(Aca2ndSuppExamsDetails4);
                                    Aca2ndSuppExamsDetails4.RESET;
                                    Aca2ndSuppExamsDetails4.SETRANGE("Student No.", StudentUnits."Student No.");
                                    Aca2ndSuppExamsDetails4.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                    AcaSpecialExamsDetails4.SETRANGE(Category, AcaSpecialExamsDetails4.Category::Special);
                                    AcaSpecialExamsDetails4.SETRANGE(Semester, StudentUnits.Semester);
                                    AcaSpecialExamsDetails4.SETRANGE("Exam Marks", 0);
                                    IF (Aca2ndSuppExamsDetails4.FIND('-')) THEN BEGIN
                                        // Check if Allows Creation of Supp

                                        IF AcaSpecialExamsDetails.INSERT THEN;
                                    END ELSE BEGIN
                                    END;
                                END ELSE BEGIN
                                    // Failed 1st Supplementary, Create Second Supplementary Registration Entry here
                                    CLEAR(Aca2ndSuppExamsDetails);
                                    Aca2ndSuppExamsDetails.RESET;
                                    Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                    Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                    Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                    Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                    IF NOT (Aca2ndSuppExamsDetails.FIND('-')) THEN BEGIN //  Register 2nd Supp for 1st Supp that is Failed
                                        CLEAR(CountedSeq);
                                        CLEAR(Aca2ndSuppExamsDetails3);
                                        Aca2ndSuppExamsDetails3.RESET;
                                        Aca2ndSuppExamsDetails3.SETRANGE("Student No.", StudentUnits."Student No.");
                                        Aca2ndSuppExamsDetails3.SETRANGE("Unit Code", ACAExamClassificationUnits."Unit Code");
                                        Aca2ndSuppExamsDetails3.SETRANGE(Semester, StudentUnits.Semester);
                                        Aca2ndSuppExamsDetails3.SETCURRENTKEY(Sequence);
                                        IF Aca2ndSuppExamsDetails3.FIND('+') THEN BEGIN
                                            CountedSeq := Aca2ndSuppExamsDetails3.Sequence;
                                        END ELSE BEGIN
                                            CountedSeq := 0;
                                        END;
                                        CountedSeq += 1;
                                        Aca2ndSuppExamsDetails.INIT;
                                        Aca2ndSuppExamsDetails.Stage := StudentUnits.Stage;
                                        Aca2ndSuppExamsDetails.Status := Aca2ndSuppExamsDetails.Status::New;
                                        Aca2ndSuppExamsDetails."Student No." := StudentUnits."Student No.";
                                        Aca2ndSuppExamsDetails."Academic Year" := Coregcs."Academic Year";
                                        Aca2ndSuppExamsDetails."Unit Code" := StudentUnits.Unit;
                                        Aca2ndSuppExamsDetails.Semester := StudentUnits.Semester;
                                        Aca2ndSuppExamsDetails.Sequence := CountedSeq;
                                        Aca2ndSuppExamsDetails."Current Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                        Aca2ndSuppExamsDetails.Category := Aca2ndSuppExamsDetails.Category::Supplementary;
                                        Aca2ndSuppExamsDetails.Programme := StudentUnits.Programme;

                                        IF Aca2ndSuppExamsDetails.INSERT THEN;
                                    END;

                                END;
                                BEGIN
                                    ACAExamCummulativeResit.INIT;
                                    ACAExamCummulativeResit."Student Number" := StudentUnits."Student No.";
                                    ACAExamCummulativeResit."School Code" := ACAExamClassificationStuds."School Code";
                                    ACAExamCummulativeResit."Academic Year" := StudentUnits."Academic Year";
                                    ACAExamCummulativeResit."Unit Code" := ACAExamClassificationUnits."Unit Code";
                                    ACAExamCummulativeResit."Student Name" := ACAExamClassificationStuds."Student Name";
                                    ACAExamCummulativeResit.Programme := StudentUnits.Programme;
                                    ACAExamCummulativeResit."School Name" := ACAExamClassificationStuds."School Name";
                                    ACAExamCummulativeResit."Unit Description" := UnitsSubjects.Desription;
                                    ACAExamCummulativeResit."Credit Hours" := UnitsSubjects."No. Units";
                                    ACAExamCummulativeResit."Unit Type" := ACAExamClassificationUnits."Unit Type";
                                    ACAExamCummulativeResit.Score := ROUND(ACAExamClassificationUnits."Total Score Decimal", 0.01, '=');
                                    ACAExamCummulativeResit.Grade := ACAExamClassificationUnits.Grade;
                                    IF ACAExamCummulativeResit.INSERT THEN;
                                END;
                            END;
                            /////////////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        END;
                    END;
                END;
            END;
            UNTIL RegularExamUnitsRegForSupp.NEXT = 0;
        END;

        // Update Averages
        CLEAR(TotalRecs);
        CLEAR(CountedRecs);
        CLEAR(RemeiningRecs);
        CLEAR(ACAExamClassificationStuds);
        CLEAR(ACAExamCourseRegistration);
        ACAExamCourseRegistration.RESET;
        ACAExamCourseRegistration.SETFILTER("Reporting Academic Year", RefRegularCoRegcs."Academic Year");
        ACAExamCourseRegistration.SETFILTER("Student Number", RefRegularCoRegcs."Student Number");
        IF ACAExamCourseRegistration.FIND('-') THEN BEGIN
            TotalRecs := ACAExamCourseRegistration.COUNT;
            RemeiningRecs := TotalRecs;
            REPEAT
            BEGIN
                CLEAR(Coregcs);
                Coregcs.RESET;
                Coregcs.SETRANGE("Student No.", ACAExamCourseRegistration."Student Number");
                Coregcs.SETRANGE(Programmes, ACAExamCourseRegistration.Programme);
                Coregcs.SETRANGE("Year Of Study", ACAExamCourseRegistration."Year of Study");
                Coregcs.SETFILTER("Stopage Yearly Remark", '<>%1', '');
                IF Coregcs.FIND('+') THEN;
                Progyz.RESET;
                Progyz.SETRANGE(Code, ACAExamCourseRegistration.Programme);
                IF Progyz.FIND('-') THEN; 
                ACAExamCourseRegistration.CALCFIELDS("Total Marks", "Total Courses", "Total Weighted Marks",
              "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Weighted Average");
                ACAExamCourseRegistration."Normal Average" := ROUND((ACAExamCourseRegistration.Average), 0.01, '=');
                IF ACAExamCourseRegistration."Total Units" > 0 THEN
                    ACAExamCourseRegistration."Weighted Average" := ROUND((ACAExamCourseRegistration."Total Weighted Marks" / ACAExamCourseRegistration."Total Units"), 0.01, '=');
                IF ACAExamCourseRegistration."Total Classified C. Count" <> 0 THEN
                    ACAExamCourseRegistration."Classified Average" := ROUND((ACAExamCourseRegistration."Classified Total Marks" / ACAExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                IF ACAExamCourseRegistration."Total Classified Units" <> 0 THEN
                    ACAExamCourseRegistration."Classified W. Average" := ROUND((ACAExamCourseRegistration."Classified W. Total" / ACAExamCourseRegistration."Total Classified Units"), 0.01, '=');
                ACAExamCourseRegistration.CALCFIELDS("Defined Units (Flow)");
                ACAExamCourseRegistration."Required Stage Units" := ACAExamCourseRegistration."Defined Units (Flow)";
                IF ACAExamCourseRegistration."Required Stage Units" > ACAExamCourseRegistration."Attained Stage Units" THEN
                    ACAExamCourseRegistration."Units Deficit" := ACAExamCourseRegistration."Required Stage Units" - ACAExamCourseRegistration."Attained Stage Units";
                ACAExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Academic Year");

                ACAExamCourseRegistration."Final Classification" := GetRubricSupp(Progyz, ACAExamCourseRegistration);
                IF Coregcs."Stopage Yearly Remark" <> '' THEN
                    ACAExamCourseRegistration."Final Classification" := Coregcs."Stopage Yearly Remark";
                ACAExamCourseRegistration."Final Classification Pass" := GetSuppRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                ACAExamCourseRegistration."Academic Year", Progyz);
                ACAExamCourseRegistration."Final Classification Order" := GetSuppRubricOrder(ACAExamCourseRegistration."Final Classification");
                ACAExamCourseRegistration.Graduating := GetSuppRubricPassStatus(ACAExamCourseRegistration."Final Classification",
                ACAExamCourseRegistration."Academic Year", Progyz);
                ACAExamCourseRegistration.Classification := ACAExamCourseRegistration."Final Classification";
                IF ACAExamCourseRegistration."Total Courses" = 0 THEN BEGIN
                    ACAExamCourseRegistration."Final Classification Pass" := FALSE;
                    ACAExamCourseRegistration."Final Classification Order" := 10;
                    ACAExamCourseRegistration.Graduating := FALSE;
                END;
                IF Coregcs."Stopage Yearly Remark" <> '' THEN
                    ACAExamCourseRegistration.Classification := Coregcs."Stopage Yearly Remark";
                ACAExamCourseRegistration.CALCFIELDS("Total Marks",
   "Total Weighted Marks",
   "Total Failed Courses",
   "Total Failed Units",
   "Failed Courses",
   "Failed Units",
   "Failed Cores",
   "Failed Required",
   "Failed Electives",
   "Total Cores Done",
   "Total Cores Passed",
   "Total Required Done",
   "Total Electives Done",
   "Tota Electives Passed");
                ACAExamCourseRegistration.CALCFIELDS(
                "Classified Electives C. Count",
                "Classified Electives Units",
                "Total Classified C. Count",
                "Total Classified Units",
                "Classified Total Marks",
                "Classified W. Total",
                "Total Failed Core Units");
                ACAExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study");
                ACAExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACAExamCourseRegistration.Programme, ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration."Programme Option",
                ACAExamCourseRegistration."Academic Year");
                ACAExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACAExamCourseRegistration."Student Number", ACAExamCourseRegistration."Year of Study", ACAExamCourseRegistration.Programme);
                ACAExamCourseRegistration.MODIFY(TRUE);
                ACAExamCourseRegistration.CALCFIELDS("Skip Supplementary Generation");

                CLEAR(Aca2ndSuppExamsDetailsforSupps);
                Aca2ndSuppExamsDetailsforSupps.RESET;
                Aca2ndSuppExamsDetailsforSupps.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                Aca2ndSuppExamsDetailsforSupps.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                Aca2ndSuppExamsDetailsforSupps.SETRANGE("Unit Code", RegularExamUnitsRegForSupp."Unit Code");
                Aca2ndSuppExamsDetailsforSupps.SETFILTER("Exam Marks", '=%1', 0);
                IF Aca2ndSuppExamsDetailsforSupps.FIND('-') THEN Aca2ndSuppExamsDetailsforSupps.DELETEALL;
                Delete2ndSupplementaryMarks(ACAExamCourseRegistration);
                IF ACAExamCourseRegistration."Skip Supplementary Generation" = TRUE THEN BEGIN
                    // Delete all Supp Registrations here
                    IF Coregcs.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            CLEAR(Aca2ndSuppExamsDetails3);
                            Aca2ndSuppExamsDetails3.RESET;
                            Aca2ndSuppExamsDetails3.SETRANGE("Student No.", ACAExamCourseRegistration."Student Number");
                            Aca2ndSuppExamsDetails3.SETRANGE(Category, Aca2ndSuppExamsDetails3.Category::Supplementary);
                            Aca2ndSuppExamsDetails3.SETRANGE(Semester, Coregcs.Semester);
                            Aca2ndSuppExamsDetails3.SETRANGE("Exam Marks", 0);
                            IF Aca2ndSuppExamsDetails3.FIND('-') THEN Aca2ndSuppExamsDetails3.DELETEALL;
                        END;
                        UNTIL Coregcs.NEXT = 0;
                    END;
                END ELSE BEGIN
                    //ERROR(ACAExamCourseRegistration."Student Number");
                    Update2ndSupplementaryMarks(ACAExamCourseRegistration);
                    // Update 2nd Supp Registrations
                    ////////////////...................................................................
                    CLEAR(RegularExamUnitsRegForSupp);
                    RegularExamUnitsRegForSupp.RESET;
                    RegularExamUnitsRegForSupp.SETRANGE(RegularExamUnitsRegForSupp."Student No.", RefRegularCoRegcs."Student Number");
                    RegularExamUnitsRegForSupp.SETRANGE(RegularExamUnitsRegForSupp.Programme, RefRegularCoRegcs.Programme);
                    RegularExamUnitsRegForSupp.SETRANGE(RegularExamUnitsRegForSupp."Academic Year", RefRegularCoRegcs."Academic Year");
                    RegularExamUnitsRegForSupp.SETFILTER(Pass, '=%1', FALSE);
                    IF RegularExamUnitsRegForSupp.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            CLEAR(StudentUnits);
                            StudentUnits.RESET;
                            StudentUnits.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                            StudentUnits.SETRANGE(Unit, RegularExamUnitsRegForSupp."Unit Code");
                            StudentUnits.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                            StudentUnits.SETRANGE("Academic Year (Flow)", RegularExamUnitsRegForSupp."Academic Year");
                            IF StudentUnits.FIND('-') THEN BEGIN

                                CLEAR(CATExists);
                                CLEAR(ACAExamResults_Fin);
                                ACAExamResults_Fin.RESET;
                                ACAExamResults_Fin.SETRANGE("Student No.", StudentUnits."Student No.");
                                ACAExamResults_Fin.SETRANGE(Unit, StudentUnits.Unit);
                                ACAExamResults_Fin.SETRANGE(Semester, StudentUnits.Semester);
                                ACAExamResults_Fin.SETFILTER(Exam, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                                ACAExamResults_Fin.SETCURRENTKEY(Score);
                                IF ACAExamResults_Fin.FIND('+') THEN BEGIN
                                    CATExists := TRUE;
                                END;
                                Coregcs.RESET;
                                Coregcs.SETFILTER(Programmes, RegularExamUnitsRegForSupp.Programme);
                                Coregcs.SETFILTER("Academic Year", RegularExamUnitsRegForSupp."Academic Year");
                                Coregcs.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                                Coregcs.SETRANGE(Semester, StudentUnits.Semester);
                                IF Coregcs.FIND('-') THEN BEGIN
                                    CLEAR(Aca2ndSuppExamsDetailsforSupps);
                                    Aca2ndSuppExamsDetailsforSupps.RESET;
                                    Aca2ndSuppExamsDetailsforSupps.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                                    Aca2ndSuppExamsDetailsforSupps.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                                    Aca2ndSuppExamsDetailsforSupps.SETRANGE("Unit Code", RegularExamUnitsRegForSupp."Unit Code");
                                    Aca2ndSuppExamsDetailsforSupps.SETRANGE(Semester, StudentUnits.Semester);
                                    IF NOT (Aca2ndSuppExamsDetailsforSupps.FIND('-')) THEN BEGIN

                                        CLEAR(Aca2ndSuppExamsDetailsforSupps);
                                        Aca2ndSuppExamsDetailsforSupps.RESET;
                                        Aca2ndSuppExamsDetailsforSupps.SETRANGE("Student No.", RegularExamUnitsRegForSupp."Student No.");
                                        Aca2ndSuppExamsDetailsforSupps.SETRANGE(Programme, RegularExamUnitsRegForSupp.Programme);
                                        Aca2ndSuppExamsDetailsforSupps.SETRANGE("Unit Code", RegularExamUnitsRegForSupp."Unit Code");
                                        IF Aca2ndSuppExamsDetailsforSupps.FIND('-') THEN BEGIN
                                            IF Aca2ndSuppExamsDetailsforSupps.RENAME(Aca2ndSuppExamsDetailsforSupps."Student No.", Aca2ndSuppExamsDetailsforSupps."Unit Code",
                                            Aca2ndSuppExamsDetailsforSupps."Academic Year", StudentUnits.Semester, Aca2ndSuppExamsDetailsforSupps.Sequence) THEN;
                                        END ELSE BEGIN
                                            Aca2ndSuppExamsDetailsforSupps.INIT;
                                            Aca2ndSuppExamsDetailsforSupps."Student No." := RegularExamUnitsRegForSupp."Student No.";
                                            Aca2ndSuppExamsDetailsforSupps."Unit Code" := StudentUnits.Unit;
                                            Aca2ndSuppExamsDetailsforSupps."Academic Year" := RegularExamUnitsRegForSupp."Academic Year";
                                            Aca2ndSuppExamsDetailsforSupps.Semester := StudentUnits.Semester;
                                            Aca2ndSuppExamsDetailsforSupps.Stage := Coregcs.Stage;
                                            Aca2ndSuppExamsDetailsforSupps.Programme := RegularExamUnitsRegForSupp.Programme;
                                            IF Aca2ndSuppExamsDetailsforSupps.INSERT THEN;
                                        END;
                                    END;
                                END; //Coregcs
                            END; //StudentUnits
                        END; //Repeat
                        UNTIL RegularExamUnitsRegForSupp.NEXT = 0;
                    END;

                    //...........................................................................................

                END;

            END;
            UNTIL ACAExamCourseRegistration.NEXT = 0;
        END;

        // Update2ndSupplementaryMarks;        
    end;

    procedure GetSuppMaxScore(Categoryz: Code[250]; Scorezs: Decimal) SuppScoreNormalized: Decimal
    var
        ACAExamCategory: Record "ACA-Exam Category";
    begin
        SuppScoreNormalized := Scorezs;
        //IF SuppDets.Category = SuppDets.Category::Supplementary THEN BEGIN
        ACAExamCategory.RESET;
        ACAExamCategory.SETRANGE(Code, Categoryz);
        IF ACAExamCategory.FIND('-') THEN BEGIN
            IF ACAExamCategory."Supplementary Max. Score" <> 0 THEN BEGIN
                IF Scorezs > ACAExamCategory."Supplementary Max. Score" THEN
                    SuppScoreNormalized := ACAExamCategory."Supplementary Max. Score";
            END;
        END;
    end;

    procedure GetRubricSupp(ACAProgramme: Record "ACA-Programme"; VAR CoursesRegz: Record "ACA-SuppExam. Co. Reg.") StatusRemarks: Text[150]
    var
        Customer: Record "ACA-Course Registration";
        LubricIdentified: Boolean;
        ACAResultsStatus: Record "ACA-Supp. Results Status";
        YearlyReMarks: Text[250];
        StudCoregcs2: Record "ACA-Course Registration";
        StudCoregcs24: Record "ACA-Course Registration";
        Customersz: Record Customer;
        ACARegStoppageReasons: Record "ACA-Reg. Stoppage Reasons";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        StudCoregcs: Record "ACA-Course Registration";
    begin
        CLEAR(StatusRemarks);
        CLEAR(YearlyReMarks);
        Customer.RESET;
        Customer.SETRANGE("Student No.", CoursesRegz."Student Number");
        Customer.SETRANGE("Academic Year", CoursesRegz."Academic Year");
        IF Customer.FIND('+') THEN BEGIN
            IF ((Customer.Status = Customer.Status::Registration) OR (Customer.Status = Customer.Status::Current)) THEN BEGIN
                CLEAR(LubricIdentified);
                CoursesRegz.CALCFIELDS("Attained Stage Units", "Failed Cores", "Failed Courses", "Failed Electives", "Failed Required", "Failed Units",
                "Total Failed Units", "Total Marks", "Total Required Done",
                "Total Required Passed", "Total Units", "Total Weighted Marks", "Exists DTSC Prefix");
                CoursesRegz.CALCFIELDS("Total Cores Done", "Total Cores Passed", "Total Courses", "Total Electives Done", "Total Failed Courses",
                "Tota Electives Passed", "Total Classified C. Count", "Total Classified Units", "Total Classified Units");
                IF CoursesRegz."Total Courses" > 0 THEN
                    CoursesRegz."% Failed Courses" := (CoursesRegz."Failed Courses" / CoursesRegz."Total Courses") * 100;
                CoursesRegz."% Failed Courses" := ROUND(CoursesRegz."% Failed Courses", 0.01, '>');
                IF CoursesRegz."% Failed Courses" > 100 THEN CoursesRegz."% Failed Courses" := 100;
                IF CoursesRegz."Total Cores Done" > 0 THEN
                    CoursesRegz."% Failed Cores" := ((CoursesRegz."Failed Cores" / CoursesRegz."Total Cores Done") * 100);
                CoursesRegz."% Failed Cores" := ROUND(CoursesRegz."% Failed Cores", 0.01, '>');
                IF CoursesRegz."% Failed Cores" > 100 THEN CoursesRegz."% Failed Cores" := 100;
                IF CoursesRegz."Total Units" > 0 THEN
                    CoursesRegz."% Failed Units" := (CoursesRegz."Failed Units" / CoursesRegz."Total Units") * 100;
                CoursesRegz."% Failed Units" := ROUND(CoursesRegz."% Failed Units", 0.01, '>');
                IF CoursesRegz."% Failed Units" > 100 THEN CoursesRegz."% Failed Units" := 100;
                IF CoursesRegz."Total Electives Done" > 0 THEN
                    CoursesRegz."% Failed Electives" := (CoursesRegz."Failed Electives" / CoursesRegz."Total Electives Done") * 100;
                CoursesRegz."% Failed Electives" := ROUND(CoursesRegz."% Failed Electives", 0.01, '>');
                IF CoursesRegz."% Failed Electives" > 100 THEN CoursesRegz."% Failed Electives" := 100;
                // CoursesRegz.MODIFY;
                ACAResultsStatus.RESET;
                ACAResultsStatus.SETFILTER("Manual Status Processing", '%1', FALSE);
                ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                IF ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" THEN BEGIN
                    ACAResultsStatus.SETFILTER("Special Programme Class", '=%1', ACAResultsStatus."Special Programme Class"::"Medicine & Nursing");
                END ELSE BEGIN
                    ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                    ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                END;
                ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                ACAResultsStatus.SETCURRENTKEY("Order No");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        StatusRemarks := ACAResultsStatus.Code;
                        IF ACAResultsStatus."Lead Status" <> '' THEN
                            StatusRemarks := ACAResultsStatus."Lead Status";
                        YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        LubricIdentified := TRUE;
                    END;
                    UNTIL ((ACAResultsStatus.NEXT = 0) OR (LubricIdentified = TRUE))
                END;
                CoursesRegz.CALCFIELDS("Supp/Special Exists", "Attained Stage Units", "Special Registration Exists");
                //IF CoursesRegz."Supp/Special Exists" THEN  StatusRemarks:='SPECIAL';
                //IF CoursesRegz."Units Deficit">0 THEN StatusRemarks:='DTSC';
                IF CoursesRegz."Required Stage Units" > CoursesRegz."Attained Stage Units" THEN StatusRemarks := 'DTSC';
                IF CoursesRegz."Attained Stage Units" = 0 THEN StatusRemarks := 'DTSC';
                //IF CoursesRegz."Exists DTSC Prefix" THEN StatusRemarks:='DTSC';
                //IF CoursesRegz."Special Registration Exists" THEN StatusRemarks:='Special';

                ////////////////////////////////////////////////////////////////////////////////////////////////
                // Check if exists a stopped Semester for the Academic Years and Pick the Status on the lines as the rightful Status
                CLEAR(StudCoregcs24);
                StudCoregcs24.RESET;
                StudCoregcs24.SETRANGE("Student No.", CoursesRegz."Student Number");
                StudCoregcs24.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                StudCoregcs24.SETRANGE(Reversed, TRUE);
                IF StudCoregcs24.FIND('-') THEN BEGIN
                    CLEAR(ACARegStoppageReasons);
                    ACARegStoppageReasons.RESET;
                    ACARegStoppageReasons.SETRANGE("Reason Code", StudCoregcs24."Stoppage Reason");
                    IF ACARegStoppageReasons.FIND('-') THEN BEGIN

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETRANGE(Status, ACARegStoppageReasons."Global Status");
                        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            StatusRemarks := ACAResultsStatus.Code;
                            YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        END ELSE BEGIN
                            StatusRemarks := UPPERCASE(FORMAT(StudCoregcs24."Stoppage Reason"));
                            YearlyReMarks := StatusRemarks;
                        END;
                    END;
                END;
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

            END ELSE BEGIN

                CoursesRegz.CALCFIELDS("Attained Stage Units");
                IF CoursesRegz."Attained Stage Units" = 0 THEN StatusRemarks := 'DTSC';
                CLEAR(StudCoregcs);
                StudCoregcs.RESET;
                StudCoregcs.SETRANGE("Student No.", CoursesRegz."Student Number");
                StudCoregcs.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                StudCoregcs.SETRANGE("Stoppage Exists In Acad. Year", TRUE);
                IF StudCoregcs.FIND('-') THEN BEGIN
                    CLEAR(StudCoregcs2);
                    StudCoregcs2.RESET;
                    StudCoregcs2.SETRANGE("Student No.", CoursesRegz."Student Number");
                    StudCoregcs2.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                    StudCoregcs2.SETRANGE("Stoppage Exists In Acad. Year", TRUE);
                    StudCoregcs2.SETRANGE(Reversed, TRUE);
                    IF StudCoregcs2.FIND('-') THEN BEGIN
                        StatusRemarks := UPPERCASE(FORMAT(StudCoregcs2."Stoppage Reason"));
                        YearlyReMarks := StatusRemarks;
                    END;
                END;

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Status, Customer.Status);
                ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    StatusRemarks := ACAResultsStatus.Code;
                    YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                END ELSE BEGIN
                    StatusRemarks := UPPERCASE(FORMAT(Customer.Status));
                    YearlyReMarks := StatusRemarks;
                END;
            END;
        END;


        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, StatusRemarks);
        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            // Check if the Ststus does not allow Supp. Generation and delete
            IF ACAResultsStatus."Skip Supp Generation" = TRUE THEN BEGIN
                // Delete Entries from Supp Registration for the Semester
                CLEAR(AcaSpecialExamsDetails);
                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE("Student No.", CoursesRegz."Student Number");
                AcaSpecialExamsDetails.SETRANGE("Year of Study", CoursesRegz."Year of Study");
                AcaSpecialExamsDetails.SETRANGE("Exam Marks", 0);
                AcaSpecialExamsDetails.SETRANGE(Status, AcaSpecialExamsDetails.Status::New);
                IF AcaSpecialExamsDetails.FIND('-') THEN AcaSpecialExamsDetails.DELETEALL;
            END;
        END;
    End;

    procedure GetSuppRubricPassStatus(RubricCode: Code[50]; AcademicYears: Code[250]; Progyz: Record "ACA-Programme") PassStatus: Boolean
    var
        ACAResultsStatus: Record "ACA-Supp. Results Status";
    begin
        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, RubricCode);
        ACAResultsStatus.SETRANGE("Academic Year", AcademicYears);
        ACAResultsStatus.SETRANGE("Special Programme Class", Progyz."Special Programme Class");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            PassStatus := ACAResultsStatus.Pass;
        END;
    end;

    procedure GetSuppRubricOrder(RubricCode: Code[50]) RubricOrder: Integer
    var
        ACAResultsStatus: Record "ACA-Supp. Results Status";
    begin
        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, RubricCode);
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            RubricOrder := ACAResultsStatus."Order No";
        END;
    end;

    procedure Delete2ndSupplementaryMarks(ACASuppExamCoRegfor2ndSupp: Record "ACA-SuppExam. Co. Reg.")
    var
        CATExists: Boolean;
        Aca2ndSuppExamsDetails3: Record "Aca-2nd Supp. Exams Details";
        Aca2ndSuppExamsDetails: Record "Aca-2nd Supp. Exams Details";
        FirstSuppUnitsRegFor2ndSupp: Record "ACA-SuppExam Class. Units";
        ST1SuppExamClassificationUnits: Record "ACA-SuppExam Class. Units";
        CountedSeq: Integer;
        ACAExamCategory: Record "ACA-Exam Category";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        Aca2NDSpecialExamsDetails: Record "Aca-2nd Supp. Exams Details";
        Aca2NDSpecialExamsDetails3: Record "Aca-2nd Supp. Exams Details";
        ACAExam2NDSuppUnits: Record "ACA-2ndExam Supp. Units";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        Aca2ndSuppExamsResults: Record "Aca-2nd Supp. Exams Results";
        AcdYrs: Record "ACA-Academic Year";
        Custos: Record Customer;
        StudentUnits: Record "ACA-Student Units";
        Coregcsz10: Record "ACA-Course Registration";
        CountedRegistrations: Integer;
        UnitsSubjects: Record "ACA-Units/Subjects";
        Programme_Fin: Record "ACA-Programme";
        ProgrammeStages_Fin: Record "ACA-Programme Stages";
        AcademicYear_Fin: Record "ACA-Academic Year";
        Semesters_Fin: Record "ACA-Semesters";
        ExamResults: Record "ACA-Exam Results";
        ClassCustomer: Record Customer;
        ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
        ClassDimensionValue: Record "Dimension Value";
        ClassGradingSystem: Record "ACA-Grading System";
        ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ClassExamResults2: Record "ACA-Exam Results";
        TotalRecs: Integer;
        CountedRecs: Integer;
        RemeiningRecs: Integer;
        ExpectedElectives: Integer;
        CountedElectives: Integer;
        Progyz: Record "ACA-Programme";
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
        ACA2NDExamClassificationUnits: Record "ACA-2ndSuppExam Class. Units";
        ACA2NDExamCourseRegistration: Record "ACA-2ndSuppExam. Co. Reg.";
        ACA2NDExamFailedReasons: Record "ACA-2ndSuppExam Fail Reasons";
        ACA2NDSenateReportsHeader: Record "ACA-2ndSuppSenate Repo. Header";
        ACA2NDExamClassificationStuds: Record "ACA-2ndSuppExam Class. Studs";
        ACA2NDExamClassificationStudsCheck: Record "ACA-2ndSuppExam Class. Studs";
        ACAExamResultsFin: Record "ACA-Exam Results";
        ACAResultsStatus: Record "ACA-Results Status";
        ProgressForCoReg: Dialog;
        Tens: Text;
        ACASemesters: Record "ACA-Semesters";
        ACAExamResults_Fin: Record "ACA-Exam Results";
        ProgBar22: Dialog;
        Coregcs: Record "ACA-Course Registration";
        ACA2NDExamCummulativeResit: Record "ACA-2ndSuppExam Cumm. Resit";
        ACAStudentUnitsForResits: Record "ACA-Student Units";
        SEQUENCES: Integer;
        CurrStudentNo: Code[250];
        CountedNos: Integer;
        CurrSchool: Code[250];
        CUrrentExamScore: Decimal;
        OriginalCatScores: Decimal;
        ACASuppExamClassUnits4Supp2: Record "ACA-SuppExam Class. Units";
    begin
        ProgFIls := ACASuppExamCoRegfor2ndSupp.Programme;
        ACA2NDExamClassificationStuds.RESET;
        ACA2NDExamCourseRegistration.RESET;
        ACA2NDExamClassificationUnits.RESET;
        ACAExam2NDSuppUnits.RESET;
        IF StudNos <> '' THEN BEGIN
            ACA2NDExamClassificationStuds.SETFILTER("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
            ACA2NDExamCourseRegistration.SETRANGE("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
            ACA2NDExamClassificationUnits.SETRANGE("Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
            ACAExam2NDSuppUnits.SETFILTER("Student No.", StudNos);
        END;
        IF AcadYear <> '' THEN BEGIN
            ACA2NDExamClassificationStuds.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
            ACA2NDExamCourseRegistration.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
            ACA2NDExamClassificationUnits.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
            ACAExam2NDSuppUnits.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        END;

        ACA2NDExamClassificationStuds.SETFILTER(Programme, ProgFIls);
        ACA2NDExamCourseRegistration.SETFILTER(Programme, ProgFIls);
        ACA2NDExamClassificationUnits.SETFILTER(Programme, ProgFIls);
        ACAExam2NDSuppUnits.SETFILTER(Programme, ProgFIls);
        IF ACA2NDExamClassificationStuds.FIND('-') THEN ACA2NDExamClassificationStuds.DELETEALL;
        IF ACA2NDExamCourseRegistration.FIND('-') THEN ACA2NDExamCourseRegistration.DELETEALL;
        IF ACA2NDExamClassificationUnits.FIND('-') THEN ACA2NDExamClassificationUnits.DELETEALL;
        IF ACAExam2NDSuppUnits.FIND('-') THEN ACAExam2NDSuppUnits.DELETEALL;


        ACA2NDSenateReportsHeader.RESET;
        ACA2NDSenateReportsHeader.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACA2NDSenateReportsHeader.SETFILTER("Programme Code", ProgFIls);
        IF (ACA2NDSenateReportsHeader.FIND('-')) THEN ACA2NDSenateReportsHeader.DELETEALL;
    end;

    procedure Update2ndSupplementaryMarks(ACASuppExamCoRegfor2ndSupp: Record "ACA-SuppExam. Co. Reg.")
    var
        ACACourseRegistration777: Record "ACA-Course Registration";
        CATExists: Boolean;
        Aca2ndSuppExamsDetails3: Record "Aca-2nd Supp. Exams Details";
        Aca2ndSuppExamsDetails888: Record "Aca-2nd Supp. Exams Details";
        Aca2ndSuppExamsDetails: Record "Aca-2nd Supp. Exams Details";
        FirstSuppUnitsRegFor2ndSupp: Record "ACA-SuppExam Class. Units";
        ST1SuppExamClassificationUnits: Record "ACA-SuppExam Class. Units";
        CountedSeq: Integer;
        ACAExamCategory: Record "ACA-Exam Category";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        Aca2NDSpecialExamsDetails: Record "Aca-2nd Supp. Exams Details";
        Aca2NDSpecialExamsDetails3: Record "Aca-2nd Supp. Exams Details";
        ACAExam2NDSuppUnits: Record "ACA-2ndExam Supp. Units";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        Aca2ndSuppExamsResults: Record "Aca-2nd Supp. Exams Results";
        AcdYrs: Record "ACA-Academic Year";
        Custos: Record Customer;
        StudentUnits: Record "ACA-Student Units";
        Coregcsz10: Record "ACA-Course Registration";
        CountedRegistrations: Integer;
        UnitsSubjects: Record "ACA-Units/Subjects";
        Programme_Fin: Record "ACA-Programme";
        ProgrammeStages_Fin: Record "ACA-Programme Stages";
        AcademicYear_Fin333: Record "ACA-Academic Year";
        AcademicYear_Fin: Record "ACA-Academic Year";
        Semesters_Fin: Record "ACA-Semesters";
        ExamResults: Record "ACA-Exam Results";
        ClassCustomer: Record Customer;
        ClassExamResultsBuffer2: Record "ACA-Exam Results Buffer 2";
        ClassDimensionValue: Record "Dimension Value";
        ClassGradingSystem: Record "ACA-Grading System";
        ClassClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        ClassExamResults2: Record "ACA-Exam Results";
        TotalRecs: Integer;
        CountedRecs: Integer;
        RemeiningRecs: Integer;
        ExpectedElectives: Integer;
        CountedElectives: Integer;
        Progyz: Record "ACA-Programme";
        ACADefinedUnitsperYoS: Record "ACA-Defined Units per YoS";
        ACA2NDExamClassificationUnits: Record "ACA-2ndSuppExam Class. Units";
        ACA2NDExamCourseRegistration: Record "ACA-2ndSuppExam. Co. Reg.";
        ACA2NDExamFailedReasons: Record "ACA-2ndSuppExam Fail Reasons";
        ACA2NDSenateReportsHeader: Record "ACA-2ndSuppSenate Repo. Header";
        ACA2NDExamClassificationStuds: Record "ACA-2ndSuppExam Class. Studs";
        ACA2NDExamClassificationStudsCheck: Record "ACA-2ndSuppExam Class. Studs";
        ACAExamResultsFin: Record "ACA-Exam Results";
        ACAResultsStatus: Record "ACA-Results Status";
        ProgressForCoReg: Dialog;
        Tens: Text;
        ACASemesters: Record "ACA-Semesters";
        ACAExamResults_Fin: Record "ACA-Exam Results";
        ProgBar22: Dialog;
        Coregcs: Record "ACA-Course Registration";
        ACA2NDExamCummulativeResit: Record "ACA-2ndSuppExam Cumm. Resit";
        ACAStudentUnitsForResits: Record "ACA-Student Units";
        SEQUENCES: Integer;
        CurrStudentNo: Code[250];
        CountedNos: Integer;
        CurrSchool: Code[250];
        CUrrentExamScore: Decimal;
        OriginalCatScores: Decimal;
        ACASuppExamClassUnits4Supp2: Record "ACA-SuppExam Class. Units";
        ACA2NDExamCreg: Record "ACA-2ndSuppExam. Co. Reg.";
        SupReviewToBecreated: Boolean;
        SecSup: Record "Aca-2nd Supp. Exams Details";
    begin
        CLEAR(AcademicYear_Fin333);
        AcademicYear_Fin333.RESET;
        AcademicYear_Fin333.SETRANGE(Current, TRUE);
        IF AcademicYear_Fin333.FIND('-') THEN BEGIN
        END ELSE
            ERROR('Current is missing in the Academic Year setup.');
        IF NOT (GetAcademicYearDiff(ACASuppExamCoRegfor2ndSupp."Academic Year", AcademicYear_Fin333.Code)) THEN BEGIN
            //  MESSAGE('Esc...');
            EXIT;
        END ELSE BEGIN
            //   MESSAGE('Ins..');
        END;
        CLEAR(ACACourseRegistration777);
        ACACourseRegistration777.RESET;
        ACACourseRegistration777.SETRANGE("Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACACourseRegistration777.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACACourseRegistration777.SETRANGE("Year Of Study", ACASuppExamCoRegfor2ndSupp."Year of Study");
        ACACourseRegistration777.SETFILTER(Options, '<>%1', '');
        IF ACACourseRegistration777.FIND('-') THEN;
        ProgFIls := ACASuppExamCoRegfor2ndSupp.Programme;
        ACA2NDExamClassificationStuds.RESET;
        ACA2NDExamCourseRegistration.RESET;
        ACA2NDExamClassificationUnits.RESET;
        ACAExam2NDSuppUnits.RESET;
        // IF StudNos<>'' THEN BEGIN
        // ACA2NDExamClassificationStuds.SETFILTER("Student Number",ACASuppExamCoRegfor2ndSupp."Student Number");
        // ACA2NDExamClassificationUnits.SETRANGE("Student No.",ACASuppExamCoRegfor2ndSupp."Student Number");
        // ACAExam2NDSuppUnits.SETFILTER("Student No.",StudNos);
        // END;
        ACA2NDExamClassificationStuds.SETFILTER("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACA2NDExamClassificationUnits.SETRANGE("Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACAExam2NDSuppUnits.SETFILTER("Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACA2NDExamCourseRegistration.SETRANGE("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACA2NDExamCourseRegistration.SETRANGE("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
        //IF AcadYear<>'' THEN BEGIN
        ACA2NDExamClassificationStuds.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACA2NDExamCourseRegistration.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACA2NDExamClassificationUnits.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACAExam2NDSuppUnits.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        //END;

        ACA2NDExamClassificationStuds.SETFILTER(Programme, ProgFIls);
        ACA2NDExamCourseRegistration.SETFILTER(Programme, ProgFIls);
        ACA2NDExamClassificationUnits.SETFILTER(Programme, ProgFIls);
        ACAExam2NDSuppUnits.SETFILTER(Programme, ProgFIls);
        IF ACA2NDExamClassificationStuds.FIND('-') THEN ACA2NDExamClassificationStuds.DELETEALL;
        IF ACA2NDExamCourseRegistration.FIND('-') THEN ACA2NDExamCourseRegistration.DELETEALL;
        IF ACA2NDExamClassificationUnits.FIND('-') THEN ACA2NDExamClassificationUnits.DELETEALL;
        IF ACAExam2NDSuppUnits.FIND('-') THEN ACAExam2NDSuppUnits.DELETEALL;


        ACA2NDSenateReportsHeader.RESET;
        ACA2NDSenateReportsHeader.SETFILTER("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACA2NDSenateReportsHeader.SETFILTER("Programme Code", ProgFIls);
        IF (ACA2NDSenateReportsHeader.FIND('-')) THEN ACA2NDSenateReportsHeader.DELETEALL;

        ////////////////////////////////////////////////////////////////////////////
        // Grad Headers
        CLEAR(Progyz);
        IF Progyz.GET(ACASuppExamCoRegfor2ndSupp.Programme) THEN;
        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE("Special Programme Class", Progyz."Special Programme Class");
        ACAResultsStatus.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                ACA2NDSenateReportsHeader.RESET;
                ACA2NDSenateReportsHeader.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
                ACA2NDSenateReportsHeader.SETRANGE("School Code", Progyz."School Code");
                ACA2NDSenateReportsHeader.SETRANGE("Classification Code", ACAResultsStatus.Code);
                ACA2NDSenateReportsHeader.SETRANGE("Programme Code", Progyz.Code);
                ACA2NDSenateReportsHeader.SETRANGE("Year of Study", ACASuppExamCoRegfor2ndSupp."Year of Study");
                IF NOT (ACA2NDSenateReportsHeader.FIND('-')) THEN BEGIN
                    ACA2NDSenateReportsHeader.INIT;
                    ACA2NDSenateReportsHeader."Academic Year" := ACASuppExamCoRegfor2ndSupp."Academic Year";
                    ACA2NDSenateReportsHeader."Reporting Academic Year" := ACASuppExamCoRegfor2ndSupp."Academic Year";
                    ACA2NDSenateReportsHeader."Rubric Order" := ACAResultsStatus."Order No";
                    ACA2NDSenateReportsHeader."Programme Code" := Progyz.Code;
                    ACA2NDSenateReportsHeader."School Code" := Progyz."School Code";
                    ACA2NDSenateReportsHeader."Year of Study" := ACASuppExamCoRegfor2ndSupp."Year of Study";
                    ACA2NDSenateReportsHeader."Classification Code" := ACAResultsStatus.Code;
                    ACA2NDSenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                    ACA2NDSenateReportsHeader."IncludeVariable 1" := ACAResultsStatus."IncludeVariable 1";
                    ACA2NDSenateReportsHeader."IncludeVariable 2" := ACAResultsStatus."IncludeVariable 2";
                    ACA2NDSenateReportsHeader."IncludeVariable 3" := ACAResultsStatus."IncludeVariable 3";
                    ACA2NDSenateReportsHeader."IncludeVariable 4" := ACAResultsStatus."IncludeVariable 4";
                    ACA2NDSenateReportsHeader."IncludeVariable 5" := ACAResultsStatus."IncludeVariable 5";
                    ACA2NDSenateReportsHeader."IncludeVariable 6" := ACAResultsStatus."IncludeVariable 6";
                    ACA2NDSenateReportsHeader."Summary Page Caption" := ACAResultsStatus."Summary Page Caption";
                    ACA2NDSenateReportsHeader."Include Failed Units Headers" := ACAResultsStatus."Include Failed Units Headers";
                    ACA2NDSenateReportsHeader."Include Academic Year Caption" := ACAResultsStatus."Include Academic Year Caption";
                    ACA2NDSenateReportsHeader."Academic Year Text" := ACAResultsStatus."Academic Year Text";
                    ACA2NDSenateReportsHeader."Status Msg1" := ACAResultsStatus."Status Msg1";
                    ACA2NDSenateReportsHeader."Status Msg2" := ACAResultsStatus."Status Msg2";
                    ACA2NDSenateReportsHeader."Status Msg3" := ACAResultsStatus."Status Msg3";
                    ACA2NDSenateReportsHeader."Status Msg4" := ACAResultsStatus."Status Msg4";
                    ACA2NDSenateReportsHeader."Status Msg5" := ACAResultsStatus."Status Msg5";
                    ACA2NDSenateReportsHeader."Status Msg6" := ACAResultsStatus."Status Msg6";
                    ACA2NDSenateReportsHeader."Grad. Status Msg 1" := ACAResultsStatus."Grad. Status Msg 1";
                    ACA2NDSenateReportsHeader."Grad. Status Msg 2" := ACAResultsStatus."Grad. Status Msg 2";
                    ACA2NDSenateReportsHeader."Grad. Status Msg 3" := ACAResultsStatus."Grad. Status Msg 3";
                    ACA2NDSenateReportsHeader."Grad. Status Msg 4" := ACAResultsStatus."Grad. Status Msg 4";
                    ACA2NDSenateReportsHeader."Grad. Status Msg 5" := ACAResultsStatus."Grad. Status Msg 5";
                    ACA2NDSenateReportsHeader."Grad. Status Msg 6" := ACAResultsStatus."Grad. Status Msg 6";
                    ACA2NDSenateReportsHeader."Finalists Graduation Comments" := ACAResultsStatus."Finalists Grad. Comm. Degree";
                    ACA2NDSenateReportsHeader."1st Year Grad. Comments" := ACAResultsStatus."1st Year Grad. Comments";
                    ACA2NDSenateReportsHeader."2nd Year Grad. Comments" := ACAResultsStatus."2nd Year Grad. Comments";
                    ACA2NDSenateReportsHeader."3rd Year Grad. Comments" := ACAResultsStatus."3rd Year Grad. Comments";
                    ACA2NDSenateReportsHeader."4th Year Grad. Comments" := ACAResultsStatus."4th Year Grad. Comments";
                    ACA2NDSenateReportsHeader."5th Year Grad. Comments" := ACAResultsStatus."5th Year Grad. Comments";
                    ACA2NDSenateReportsHeader."6th Year Grad. Comments" := ACAResultsStatus."6th Year Grad. Comments";
                    ACA2NDSenateReportsHeader."7th Year Grad. Comments" := ACAResultsStatus."7th Year Grad. Comments";
                    IF ACA2NDSenateReportsHeader.INSERT THEN;
                END;
            END;
            UNTIL ACAResultsStatus.NEXT = 0;
        END;
        ////////////////////////////////////////////////////////////////////////////
        ACA2NDExamClassificationStuds.RESET;
        ACA2NDExamClassificationStuds.SETRANGE("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACA2NDExamClassificationStuds.SETRANGE(Programme, Coregcs.Programmes);
        ACA2NDExamClassificationStuds.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        IF NOT ACA2NDExamClassificationStuds.FIND('-') THEN BEGIN
            ACA2NDExamClassificationStuds.INIT;
            ACA2NDExamClassificationStuds."Student Number" := ACASuppExamCoRegfor2ndSupp."Student Number";
            ACA2NDExamClassificationStuds."Reporting Academic Year" := ACASuppExamCoRegfor2ndSupp."Academic Year";
            ACA2NDExamClassificationStuds."School Code" := Progyz."School Code";
            ACA2NDExamClassificationStuds.Department := Progyz."Department Code";
            ACA2NDExamClassificationStuds."Programme Option" := ACACourseRegistration777.Options;
            ACA2NDExamClassificationStuds.Programme := ACASuppExamCoRegfor2ndSupp.Programme;
            ACA2NDExamClassificationStuds."Academic Year" := ACASuppExamCoRegfor2ndSupp."Academic Year";
            ACA2NDExamClassificationStuds."Year of Study" := ACASuppExamCoRegfor2ndSupp."Year of Study";
            ACA2NDExamClassificationStuds."School Name" := GetDepartmentNameOrSchool(Progyz."School Code");
            ACA2NDExamClassificationStuds."Student Name" := GetStudentName(ACASuppExamCoRegfor2ndSupp."Student Number");
            ACA2NDExamClassificationStuds.Cohort := GetCohort(Coregcs."Student No.", ACASuppExamCoRegfor2ndSupp.Programme);
            ACA2NDExamClassificationStuds."Final Stage" := GetFinalStage(ACASuppExamCoRegfor2ndSupp.Programme);
            ACA2NDExamClassificationStuds."Final Academic Year" := GetFinalAcademicYear(Coregcs."Student No.", ACASuppExamCoRegfor2ndSupp.Programme);
            ACA2NDExamClassificationStuds."Final Year of Study" := GetFinalYearOfStudy(ACASuppExamCoRegfor2ndSupp.Programme);
            ACA2NDExamClassificationStuds."Admission Date" := GetAdmissionDate(Coregcs."Student No.", ACASuppExamCoRegfor2ndSupp.Programme);
            ACA2NDExamClassificationStuds."Admission Academic Year" := GetAdmissionAcademicYear(Coregcs."Student No.", ACASuppExamCoRegfor2ndSupp.Programme);
            ACA2NDExamClassificationStuds.Graduating := FALSE;
            ACA2NDExamClassificationStuds.Classification := '';

            CLEAR(ACASuppExamClassUnits4Supp2);
            ACASuppExamClassUnits4Supp2.RESET;
            ACASuppExamClassUnits4Supp2.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
            ACASuppExamClassUnits4Supp2.SETRANGE(Programme, ACASuppExamCoRegfor2ndSupp.Programme);
            ACASuppExamClassUnits4Supp2.SETRANGE("Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
            ACASuppExamClassUnits4Supp2.SETRANGE("Year of Study", ACASuppExamCoRegfor2ndSupp."Year of Study");
            ACASuppExamClassUnits4Supp2.SETRANGE(Pass, FALSE);
            IF ACASuppExamClassUnits4Supp2.FIND('-') THEN
                IF ACA2NDExamClassificationStuds.INSERT THEN;

        END;
        /////////////////////////////////////// YoS Tracker
        //        ACA2NDExamCourseRegistration.RESET;
        //        //ACA2NDExamCourseRegistration.SETRANGE("Student Number",ACASuppExamCoRegfor2ndSupp."Student Number");
        //        ACA2NDExamCourseRegistration.SETRANGE("Student Number",ACACourseRegistration777."Student No.");
        //        ACA2NDExamCourseRegistration.SETRANGE(Programme,ACASuppExamCoRegfor2ndSupp.Programme);
        //        ACA2NDExamCourseRegistration.SETRANGE("Year of Study",ACASuppExamCoRegfor2ndSupp."Year of Study");
        //        ACA2NDExamCourseRegistration.SETRANGE("Academic Year",ACASuppExamCoRegfor2ndSupp."Academic Year");
        //        IF NOT ACA2NDExamCourseRegistration.FIND('-') THEN BEGIN
        ACA2NDExamCourseRegistration.INIT;
        ACA2NDExamCourseRegistration."Student Number" := ACASuppExamCoRegfor2ndSupp."Student Number";
        //ERROR(ACASuppExamCoRegfor2ndSupp."Student Number");
        ACA2NDExamCourseRegistration.Programme := ACASuppExamCoRegfor2ndSupp.Programme;
        ACA2NDExamCourseRegistration."Year of Study" := ACASuppExamCoRegfor2ndSupp."Year of Study";
        ACA2NDExamCourseRegistration."Reporting Academic Year" := ACASuppExamCoRegfor2ndSupp."Academic Year";
        ACA2NDExamCourseRegistration."Academic Year" := ACASuppExamCoRegfor2ndSupp."Academic Year";
        ACA2NDExamCourseRegistration."School Code" := Progyz."School Code";
        ACA2NDExamCourseRegistration."Programme Option" := ACACourseRegistration777.Options;
        ACA2NDExamCourseRegistration."School Name" := ACA2NDExamClassificationStuds."School Name";
        ACA2NDExamCourseRegistration."Student Name" := ACA2NDExamClassificationStuds."Student Name";
        ACA2NDExamCourseRegistration.Cohort := ACA2NDExamClassificationStuds.Cohort;
        ACA2NDExamCourseRegistration."Final Stage" := ACA2NDExamClassificationStuds."Final Stage";
        ACA2NDExamCourseRegistration."Final Academic Year" := ACA2NDExamClassificationStuds."Final Academic Year";
        ACA2NDExamCourseRegistration."Final Year of Study" := ACA2NDExamClassificationStuds."Final Year of Study";
        ACA2NDExamCourseRegistration."Admission Date" := ACA2NDExamClassificationStuds."Admission Date";
        ACA2NDExamCourseRegistration."Admission Academic Year" := ACA2NDExamClassificationStuds."Admission Academic Year";

        IF ((Progyz.Category = Progyz.Category::"Certificate") OR
           (Progyz.Category = Progyz.Category::"Course List") OR
           (Progyz.Category = Progyz.Category::Professional)) THEN BEGIN
            ACA2NDExamCourseRegistration."Category Order" := 2;
        END ELSE IF (Progyz.Category = Progyz.Category::Diploma) THEN BEGIN
            ACA2NDExamCourseRegistration."Category Order" := 3;
        END ELSE IF (Progyz.Category = Progyz.Category::Postgraduate) THEN BEGIN
            ACA2NDExamCourseRegistration."Category Order" := 4;
        END ELSE IF (Progyz.Category = Progyz.Category::Undergraduate) THEN BEGIN
            ACA2NDExamCourseRegistration."Category Order" := 1;
        END;

        ACA2NDExamCourseRegistration.Graduating := FALSE;
        ACA2NDExamCourseRegistration.Classification := '';
        // Check if failed Supp Exists then insert
        CLEAR(ACASuppExamClassUnits4Supp2);
        ACASuppExamClassUnits4Supp2.RESET;
        ACASuppExamClassUnits4Supp2.SETAUTOCALCFIELDS(Pass);
        SupReviewToBecreated := FALSE;
        ACASuppExamClassUnits4Supp2.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACASuppExamClassUnits4Supp2.SETRANGE(Programme, ACASuppExamCoRegfor2ndSupp.Programme);
        // ACASuppExamClassUnits4Supp2.SETRANGE("Student No.",ACASuppExamCoRegfor2ndSupp."Student Number");
        ACASuppExamClassUnits4Supp2.SETRANGE("Student No.", ACACourseRegistration777."Student No.");
        ACASuppExamClassUnits4Supp2.SETRANGE("Year of Study", ACASuppExamCoRegfor2ndSupp."Year of Study");
        ACASuppExamClassUnits4Supp2.SETRANGE(Pass, FALSE);
        IF ACASuppExamClassUnits4Supp2.FIND('-') THEN BEGIN
            SupReviewToBecreated := TRUE;
            //        IF ACA2NDExamCourseRegistration."Student Name"='P102/0869G/19' THEN
            //        ERROR(ACA2NDExamCourseRegistration."Student Number");
            IF ACA2NDExamCourseRegistration.INSERT THEN;
        END;
        //FORCE ACA2NDExamCourseRegistration insertion....Category Order,Student Number,Programme,Year of Study,Academic Year,School Code,Reporting Academic Year

        SecSup.RESET;
        SecSup.SETRANGE("Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
        SecSup.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        IF SecSup.FINDFIRST THEN BEGIN
            //    IF ACASuppExamCoRegfor2ndSupp."Student Number"='P102/0869G/19' THEN
            //           MESSAGE(ACA2NDExamCourseRegistration."Student Number");
            ACA2NDExamCreg.RESET;
            ACA2NDExamCreg.SETRANGE("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
            ACA2NDExamCreg.SETRANGE("Year of Study", ACASuppExamCoRegfor2ndSupp."Year of Study");
            ACA2NDExamCreg.SETRANGE("Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
            IF NOT ACA2NDExamCreg.FINDFIRST THEN BEGIN
                //          IF ACASuppExamCoRegfor2ndSupp."Student Number"='P102/0869G/19' THEN
                //           MESSAGE(ACA2NDExamCourseRegistration."Student Number");
                IF ACA2NDExamCourseRegistration.INSERT() THEN BEGIN
                    //                 IF ACASuppExamCoRegfor2ndSupp."Student Number"='P102/0869G/19' THEN
                    //       MESSAGE('inserted');
                END ELSE BEGIN
                    //                   IF ACASuppExamCoRegfor2ndSupp."Student Number"='P102/0869G/19' THEN
                    //          MESSAGE('not inserted');
                END;
            END ELSE BEGIN
                //                           IF ACASuppExamCoRegfor2ndSupp."Student Number"='P102/0869G/19' THEN
                //          MESSAGE('Exists');
            END;
        END;
        //COMMIT();
        // ACA2NDExamCourseRegistration.INSERT;
        //END;


        //  END;
        /////////////////////////////////////// end of YoS Tracker
        // Update Scores Here

        // Create Units for the Supp Registration ***********************************
        CLEAR(FirstSuppUnitsRegFor2ndSupp);
        FirstSuppUnitsRegFor2ndSupp.RESET;
        FirstSuppUnitsRegFor2ndSupp.SETRANGE(FirstSuppUnitsRegFor2ndSupp."Student No.", ACASuppExamCoRegfor2ndSupp."Student Number");
        FirstSuppUnitsRegFor2ndSupp.SETRANGE(FirstSuppUnitsRegFor2ndSupp.Programme, ACASuppExamCoRegfor2ndSupp.Programme);
        FirstSuppUnitsRegFor2ndSupp.SETRANGE(FirstSuppUnitsRegFor2ndSupp."Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        IF FirstSuppUnitsRegFor2ndSupp.FIND('-') THEN BEGIN
            REPEAT
            BEGIN
                IF FirstSuppUnitsRegFor2ndSupp."Unit Code" = 'MAT 317' THEN
                    CLEAR(StudentUnits);
                CLEAR(StudentUnits);
                StudentUnits.RESET;
                StudentUnits.SETRANGE("Student No.", FirstSuppUnitsRegFor2ndSupp."Student No.");
                StudentUnits.SETRANGE(Unit, FirstSuppUnitsRegFor2ndSupp."Unit Code");
                StudentUnits.SETRANGE(Programme, FirstSuppUnitsRegFor2ndSupp.Programme);
                StudentUnits.SETRANGE("Academic Year (Flow)", FirstSuppUnitsRegFor2ndSupp."Academic Year");
                IF StudentUnits.FIND('-') THEN BEGIN

                    CLEAR(CATExists);
                    CLEAR(ACAExamResults_Fin);
                    ACAExamResults_Fin.RESET;
                    ACAExamResults_Fin.SETRANGE("Student No.", StudentUnits."Student No.");
                    ACAExamResults_Fin.SETRANGE(Unit, StudentUnits.Unit);
                    ACAExamResults_Fin.SETRANGE(Semester, StudentUnits.Semester);
                    ACAExamResults_Fin.SETFILTER(Exam, '%1|%2|%3', 'ASSIGNMENT', 'CAT', 'CATS');
                    ACAExamResults_Fin.SETCURRENTKEY(Score);
                    IF ACAExamResults_Fin.FIND('+') THEN BEGIN
                        CATExists := TRUE;
                    END;
                    Coregcs.RESET;
                    Coregcs.SETFILTER(Programmes, StudentUnits.Programme);
                    Coregcs.SETFILTER("Academic Year", FirstSuppUnitsRegFor2ndSupp."Academic Year");
                    Coregcs.SETRANGE("Student No.", FirstSuppUnitsRegFor2ndSupp."Student No.");
                    Coregcs.SETRANGE(Semester, StudentUnits.Semester);
                    IF Coregcs.FIND('-') THEN BEGIN
                        FirstSuppUnitsRegFor2ndSupp.CALCFIELDS(Pass, "Exam Category");

                        CLEAR(UnitsSubjects);
                        UnitsSubjects.RESET;
                        UnitsSubjects.SETRANGE("Programme Code", ACASuppExamCoRegfor2ndSupp.Programme);
                        UnitsSubjects.SETRANGE(Code, FirstSuppUnitsRegFor2ndSupp."Unit Code");
                        IF UnitsSubjects.FIND('-') THEN BEGIN

                            IF UnitsSubjects."Default Exam Category" = '' THEN UnitsSubjects."Default Exam Category" := Progyz."Exam Category";
                            IF UnitsSubjects."Exam Category" = '' THEN UnitsSubjects."Exam Category" := Progyz."Exam Category";
                            UnitsSubjects.MODIFY;
                            CLEAR(ACA2NDExamClassificationUnits);
                            ACA2NDExamClassificationUnits.RESET;
                            ACA2NDExamClassificationUnits.SETRANGE("Student No.", FirstSuppUnitsRegFor2ndSupp."Student No.");
                            ACA2NDExamClassificationUnits.SETRANGE(Programme, FirstSuppUnitsRegFor2ndSupp.Programme);
                            ACA2NDExamClassificationUnits.SETRANGE("Unit Code", FirstSuppUnitsRegFor2ndSupp."Unit Code");
                            ACA2NDExamClassificationUnits.SETRANGE("Academic Year", FirstSuppUnitsRegFor2ndSupp."Academic Year");
                            IF NOT ACA2NDExamClassificationUnits.FIND('-') THEN BEGIN
                                ACA2NDExamClassificationUnits.INIT;
                                ACA2NDExamClassificationUnits."Student No." := FirstSuppUnitsRegFor2ndSupp."Student No.";
                                ACA2NDExamClassificationUnits.Programme := FirstSuppUnitsRegFor2ndSupp.Programme;
                                ACA2NDExamClassificationUnits."Reporting Academic Year" := FirstSuppUnitsRegFor2ndSupp."Academic Year";
                                ACA2NDExamClassificationUnits."School Code" := Progyz."School Code";
                                ACA2NDExamClassificationUnits."Unit Code" := FirstSuppUnitsRegFor2ndSupp."Unit Code";
                                ACA2NDExamClassificationUnits."Credit Hours" := UnitsSubjects."No. Units";
                                ACA2NDExamClassificationUnits."Unit Type" := FORMAT(UnitsSubjects."Unit Type");
                                ACA2NDExamClassificationUnits."Unit Description" := UnitsSubjects.Desription;
                                ACA2NDExamClassificationUnits."Year of Study" := FirstSuppUnitsRegFor2ndSupp."Year of Study";
                                ACA2NDExamClassificationUnits."Academic Year" := FirstSuppUnitsRegFor2ndSupp."Academic Year";
                                ACA2NDExamClassificationUnits."Results Exists Status" := ACASuppExamCoRegfor2ndSupp."Results Exists Status"::"Both Exists";

                                CLEAR(ExamResults);
                                ExamResults.RESET;
                                ExamResults.SETRANGE("Student No.", FirstSuppUnitsRegFor2ndSupp."Student No.");
                                ExamResults.SETRANGE(Unit, StudentUnits.Unit);
                                IF ExamResults.FIND('-') THEN BEGIN
                                    ExamResults.CALCFIELDS("Number of Repeats", "Number of Resits");
                                    IF ExamResults."Number of Repeats" > 0 THEN
                                        ACA2NDExamClassificationUnits."No. of Repeats" := ExamResults."Number of Repeats" - 1;
                                    IF ExamResults."Number of Resits" > 0 THEN
                                        ACA2NDExamClassificationUnits."No. of Resits" := ExamResults."Number of Resits" - 1;
                                END;

                                IF ACA2NDExamClassificationUnits.INSERT THEN;
                            END;

                            /////////////////////////// Update Unit Score
                            CLEAR(ACA2NDExamClassificationUnits);
                            ACA2NDExamClassificationUnits.RESET;
                            ACA2NDExamClassificationUnits.SETRANGE("Student No.", FirstSuppUnitsRegFor2ndSupp."Student No.");
                            ACA2NDExamClassificationUnits.SETRANGE(Programme, FirstSuppUnitsRegFor2ndSupp.Programme);
                            ACA2NDExamClassificationUnits.SETRANGE("Unit Code", FirstSuppUnitsRegFor2ndSupp."Unit Code");
                            ACA2NDExamClassificationUnits.SETRANGE("Academic Year", FirstSuppUnitsRegFor2ndSupp."Academic Year");
                            IF ACA2NDExamClassificationUnits.FIND('-') THEN BEGIN
                                FirstSuppUnitsRegFor2ndSupp.CALCFIELDS(Pass);
                                IF FirstSuppUnitsRegFor2ndSupp.Pass THEN BEGIN
                                    // Capture Regular Marks here Since the Unit was Passed by the Student
                                    ACA2NDExamClassificationUnits."CAT Score" := FirstSuppUnitsRegFor2ndSupp."CAT Score";
                                    ACA2NDExamClassificationUnits."CAT Score Decimal" := FirstSuppUnitsRegFor2ndSupp."CAT Score Decimal";
                                    ACA2NDExamClassificationUnits."Results Exists Status" := FirstSuppUnitsRegFor2ndSupp."Results Exists Status";
                                    ACA2NDExamClassificationUnits."Exam Score" := FirstSuppUnitsRegFor2ndSupp."Exam Score";
                                    ACA2NDExamClassificationUnits."Exam Score Decimal" := FirstSuppUnitsRegFor2ndSupp."Exam Score Decimal";
                                    ACA2NDExamClassificationUnits."Total Score" := FirstSuppUnitsRegFor2ndSupp."Total Score";
                                    ACA2NDExamClassificationUnits."Total Score Decimal" := FirstSuppUnitsRegFor2ndSupp."Total Score Decimal";
                                    ACA2NDExamClassificationUnits."Weighted Total Score" := FirstSuppUnitsRegFor2ndSupp."Weighted Total Score";
                                END ELSE BEGIN
                                    //  Pick Supp Marks here and leave value of Sore to Zero if Mark does not exist
                                    // Check for Supp Marks if exists
                                    CLEAR(Aca2ndSuppExamsDetails888);
                                    Aca2ndSuppExamsDetails888.RESET;
                                    Aca2ndSuppExamsDetails888.SETRANGE("Student No.", FirstSuppUnitsRegFor2ndSupp."Student No.");
                                    Aca2ndSuppExamsDetails888.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                    // Aca2ndSuppExamsDetails888.SETRANGE(Category,AcaSpecialExamsDetails.Category::Supplementary);
                                    Aca2ndSuppExamsDetails888.SETRANGE(Semester, StudentUnits.Semester);
                                    Aca2ndSuppExamsDetails888.SETFILTER("Exam Marks", '<>%1', 0);
                                    IF Aca2ndSuppExamsDetails888.FIND('-') THEN BEGIN
                                        ACA2NDExamClassificationUnits."Exam Score" := FORMAT(ROUND(((Aca2ndSuppExamsDetails888."Exam Marks")), 0.01, '='));
                                        ACA2NDExamClassificationUnits."Exam Score Decimal" := ROUND(((Aca2ndSuppExamsDetails888."Exam Marks")), 0.01, '=');
                                        ACA2NDExamClassificationUnits."CAT Score" := '0';
                                        ACA2NDExamClassificationUnits."CAT Score Decimal" := 0;
                                        ACA2NDExamClassificationUnits."Total Score" := ACA2NDExamClassificationUnits."Exam Score";
                                        ACA2NDExamClassificationUnits."Total Score Decimal" := ACA2NDExamClassificationUnits."Exam Score Decimal";
                                        ACA2NDExamClassificationUnits."Weighted Total Score" := ACA2NDExamClassificationUnits."Exam Score Decimal" * FirstSuppUnitsRegFor2ndSupp."Credit Hours";
                                        //Update Total Marks
                                        IF ((ACA2NDExamClassificationUnits."Exam Score" = '') AND (CATExists = FALSE)) THEN BEGIN
                                            ACA2NDExamClassificationUnits."Results Exists Status" := ACA2NDExamClassificationUnits."Results Exists Status"::"None Exists";
                                        END ELSE IF ((ACA2NDExamClassificationUnits."Exam Score" = '') AND (CATExists = TRUE)) THEN BEGIN
                                            ACA2NDExamClassificationUnits."Results Exists Status" := ACA2NDExamClassificationUnits."Results Exists Status"::"CAT Only";
                                        END ELSE IF ((ACA2NDExamClassificationUnits."Exam Score" <> '') AND (CATExists = FALSE)) THEN BEGIN
                                            ACA2NDExamClassificationUnits."Results Exists Status" := ACA2NDExamClassificationUnits."Results Exists Status"::"Exam Only";
                                        END ELSE IF ((ACA2NDExamClassificationUnits."Exam Score" <> '') AND (CATExists = TRUE)) THEN BEGIN
                                            ACA2NDExamClassificationUnits."Results Exists Status" := ACA2NDExamClassificationUnits."Results Exists Status"::"Both Exists";
                                        END;
                                        ACA2NDExamClassificationUnits."Total Score Decimal" := ROUND(ACA2NDExamClassificationUnits."Exam Score Decimal", 0.01, '=');
                                        ACA2NDExamClassificationUnits."Total Score Decimal" := GetSuppMaxScore(Progyz."Exam Category", ACA2NDExamClassificationUnits."Total Score Decimal");
                                        ACA2NDExamClassificationUnits."Total Score" := FORMAT(ROUND(ACA2NDExamClassificationUnits."Total Score Decimal", 0.01, '='));
                                        ACA2NDExamClassificationUnits."Weighted Total Score" := ROUND(ACA2NDExamClassificationUnits."Credit Hours" * ACA2NDExamClassificationUnits."Total Score Decimal", 0.01, '=');

                                    END;
                                    ACA2NDExamClassificationUnits."Total Score Decimal" := ROUND(ACA2NDExamClassificationUnits."Exam Score Decimal", 0.01, '=');
                                    ACA2NDExamClassificationUnits."Total Score Decimal" := GetSuppMaxScore(Progyz."Exam Category", ACA2NDExamClassificationUnits."Total Score Decimal");
                                    ACA2NDExamClassificationUnits."Total Score" := FORMAT(ROUND(ACA2NDExamClassificationUnits."Total Score Decimal", 0.01, '='));
                                    ACA2NDExamClassificationUnits."Weighted Total Score" := ROUND(ACA2NDExamClassificationUnits."Credit Hours" * ACA2NDExamClassificationUnits."Total Score Decimal", 0.01, '=');

                                END;
                                ACA2NDExamClassificationUnits.MODIFY;
                            END;
                            ////////////*********************************************
                            //////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                            // Check for Special Exams Score if Exists
                            ///////////////////////////////////////////////////////// End of Supps Score Updates
                            CLEAR(Aca2ndSuppExamsDetails);
                            Aca2ndSuppExamsDetails.RESET;
                            Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                            Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                            Aca2ndSuppExamsDetails.SETFILTER("Exam Marks", '<>%1', 0);
                            Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                            IF Aca2ndSuppExamsDetails.FIND('-') THEN BEGIN
                                ACAExam2NDSuppUnits.INIT;
                                ACAExam2NDSuppUnits."Student No." := StudentUnits."Student No.";
                                ACAExam2NDSuppUnits."Unit Code" := ACA2NDExamClassificationUnits."Unit Code";
                                ACAExam2NDSuppUnits."Unit Description" := ACA2NDExamClassificationUnits."Unit Description";
                                ACAExam2NDSuppUnits."Unit Type" := ACA2NDExamClassificationUnits."Unit Type";
                                ACAExam2NDSuppUnits.Programme := ACA2NDExamClassificationUnits.Programme;
                                ACAExam2NDSuppUnits."Academic Year" := ACA2NDExamClassificationUnits."Academic Year";
                                ACAExam2NDSuppUnits."Credit Hours" := ACA2NDExamClassificationUnits."Credit Hours";
                                IF AcaSpecialExamsDetails.Category = AcaSpecialExamsDetails.Category::Supplementary THEN BEGIN
                                    ACAExam2NDSuppUnits."Exam Score" := FORMAT(ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '='));
                                    ACAExam2NDSuppUnits."Exam Score Decimal" := ROUND(((AcaSpecialExamsDetails."Exam Marks")), 0.01, '=');
                                    ACAExam2NDSuppUnits."CAT Score" := FORMAT(ROUND(ACA2NDExamClassificationUnits."CAT Score Decimal", 0.01, '='));
                                    ACAExam2NDSuppUnits."CAT Score Decimal" := ROUND(ACA2NDExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                    ACAExam2NDSuppUnits."Total Score Decimal" := ROUND((GetSuppMaxScore(Progyz."Exam Category", (ROUND(ACAExam2NDSuppUnits."Exam Score Decimal", 0.01, '=')))), 0.01, '=');
                                    ACAExam2NDSuppUnits."Total Score" := FORMAT(ACAExam2NDSuppUnits."Total Score Decimal");
                                END ELSE IF AcaSpecialExamsDetails.Category = AcaSpecialExamsDetails.Category::Special THEN BEGIN
                                    ACAExam2NDSuppUnits."Exam Score Decimal" := ROUND(AcaSpecialExamsDetails."Exam Marks", 0.01, '=');
                                    ACAExam2NDSuppUnits."Exam Score" := FORMAT(ROUND(AcaSpecialExamsDetails."Exam Marks", 0.01, '='));
                                    ACAExam2NDSuppUnits."CAT Score" := FORMAT(ROUND(ACA2NDExamClassificationUnits."CAT Score Decimal", 0.01, '='));
                                    ACAExam2NDSuppUnits."CAT Score Decimal" := ROUND(ACA2NDExamClassificationUnits."CAT Score Decimal", 0.01, '=');
                                    ACAExam2NDSuppUnits."Total Score Decimal" := GetSuppMaxScore(Progyz."Exam Category", (ROUND(AcaSpecialExamsDetails."Exam Marks" + ACA2NDExamClassificationUnits."CAT Score Decimal", 0.01, '=')));
                                    ACAExam2NDSuppUnits."Total Score" := FORMAT(ACAExam2NDSuppUnits."Total Score Decimal");
                                END;
                                ACAExam2NDSuppUnits."Exam Category" := ACA2NDExamClassificationUnits."Exam Category";
                                ACAExam2NDSuppUnits."Allow In Graduate" := TRUE;
                                ACAExam2NDSuppUnits."Year of Study" := ACA2NDExamClassificationUnits."Year of Study";
                                ACAExam2NDSuppUnits.Cohort := ACA2NDExamClassificationUnits.Cohort;
                                ACAExam2NDSuppUnits."School Code" := ACA2NDExamClassificationUnits."School Code";
                                ACAExam2NDSuppUnits."Department Code" := ACA2NDExamClassificationUnits."Department Code";
                                IF ACAExam2NDSuppUnits.INSERT THEN;
                                ACA2NDExamClassificationUnits.MODIFY;
                                //  END;
                            END;
                            ACA2NDExamClassificationUnits."Allow In Graduate" := TRUE;
                            ACA2NDExamClassificationUnits.MODIFY;
                            /// Update Cummulative Resit
                            ACA2NDExamClassificationUnits.CALCFIELDS(Grade, "Grade Comment", "Comsolidated Prefix", Pass);
                            IF ACA2NDExamClassificationUnits.Pass THEN BEGIN
                                CLEAR(Aca2ndSuppExamsDetails);
                                Aca2ndSuppExamsDetails.RESET;
                                Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                Aca2ndSuppExamsDetails.SETFILTER("Exam Marks", '%1', 0);
                                IF Aca2ndSuppExamsDetails.FIND('-') THEN Aca2ndSuppExamsDetails.DELETEALL;
                            END ELSE BEGIN
                                // Student Failed Supp or Special. Register for the second Supp if first Supp Failed and 1st Supp if Special Failed

                                CLEAR(Aca2ndSuppExamsDetails);
                                Aca2ndSuppExamsDetails.RESET;
                                Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                Aca2ndSuppExamsDetails.SETFILTER("Exam Marks", '%1', 0);
                                IF Aca2ndSuppExamsDetails.FIND('-') THEN Aca2ndSuppExamsDetails.DELETEALL;
                                //Aca2ndSuppExamsDetails3
                                CLEAR(Aca2ndSuppExamsDetails);
                                Aca2ndSuppExamsDetails.RESET;
                                Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                IF NOT (Aca2ndSuppExamsDetails.FIND('-')) THEN BEGIN
                                    //  Register Supp for Special that is Failed
                                    // The Failed Unit is not in Supp Special, Register The Unit here
                                    CLEAR(CountedSeq);
                                    CLEAR(Aca2ndSuppExamsDetails3);
                                    Aca2ndSuppExamsDetails3.RESET;
                                    Aca2ndSuppExamsDetails3.SETRANGE("Student No.", StudentUnits."Student No.");
                                    Aca2ndSuppExamsDetails3.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                    Aca2ndSuppExamsDetails3.SETCURRENTKEY(Sequence);
                                    IF Aca2ndSuppExamsDetails3.FIND('+') THEN BEGIN
                                        CountedSeq := Aca2ndSuppExamsDetails3.Sequence;
                                    END ELSE BEGIN
                                        CountedSeq := 0;
                                    END;
                                    CountedSeq += 1;
                                    Aca2ndSuppExamsDetails.INIT;
                                    Aca2ndSuppExamsDetails.Stage := StudentUnits.Stage;
                                    Aca2ndSuppExamsDetails.Status := Aca2ndSuppExamsDetails.Status::New;
                                    Aca2ndSuppExamsDetails."Student No." := StudentUnits."Student No.";
                                    Aca2ndSuppExamsDetails."Academic Year" := Coregcs."Academic Year";
                                    Aca2ndSuppExamsDetails."Unit Code" := StudentUnits.Unit;
                                    Aca2ndSuppExamsDetails.Semester := StudentUnits.Semester;
                                    Aca2ndSuppExamsDetails.Sequence := CountedSeq;
                                    Aca2ndSuppExamsDetails."Current Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                    Aca2ndSuppExamsDetails.Category := Aca2ndSuppExamsDetails.Category::Supplementary;
                                    Aca2ndSuppExamsDetails.Programme := StudentUnits.Programme;
                                    IF AcaSpecialExamsDetails.INSERT THEN;
                                    CLEAR(Aca2ndSuppExamsDetails);
                                    Aca2ndSuppExamsDetails.RESET;
                                    Aca2ndSuppExamsDetails.SETRANGE("Student No.", StudentUnits."Student No.");
                                    Aca2ndSuppExamsDetails.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                    Aca2ndSuppExamsDetails.SETRANGE(Category, Aca2ndSuppExamsDetails.Category::Supplementary);
                                    Aca2ndSuppExamsDetails.SETRANGE(Semester, StudentUnits.Semester);
                                    IF NOT (Aca2ndSuppExamsDetails.FIND('-')) THEN BEGIN
                                        CLEAR(CountedSeq);
                                        CLEAR(Aca2ndSuppExamsDetails3);
                                        Aca2ndSuppExamsDetails3.RESET;
                                        Aca2ndSuppExamsDetails3.SETRANGE("Student No.", StudentUnits."Student No.");
                                        Aca2ndSuppExamsDetails3.SETRANGE("Unit Code", ACA2NDExamClassificationUnits."Unit Code");
                                        Aca2ndSuppExamsDetails3.SETRANGE(Semester, StudentUnits.Semester);
                                        Aca2ndSuppExamsDetails3.SETCURRENTKEY(Sequence);
                                        IF Aca2ndSuppExamsDetails3.FIND('+') THEN BEGIN
                                            CountedSeq := Aca2ndSuppExamsDetails3.Sequence;
                                        END ELSE BEGIN
                                            CountedSeq := 0;
                                        END;
                                        CountedSeq += 1;
                                        Aca2ndSuppExamsDetails.INIT;
                                        Aca2ndSuppExamsDetails.Stage := StudentUnits.Stage;
                                        Aca2ndSuppExamsDetails.Status := Aca2ndSuppExamsDetails.Status::New;
                                        Aca2ndSuppExamsDetails."Student No." := StudentUnits."Student No.";
                                        Aca2ndSuppExamsDetails."Academic Year" := Coregcs."Academic Year";
                                        Aca2ndSuppExamsDetails."Unit Code" := StudentUnits.Unit;
                                        Aca2ndSuppExamsDetails.Semester := StudentUnits.Semester;
                                        Aca2ndSuppExamsDetails.Sequence := CountedSeq;
                                        Aca2ndSuppExamsDetails."Current Academic Year" := GetFinalAcademicYear(StudentUnits."Student No.", StudentUnits.Programme);
                                        Aca2ndSuppExamsDetails.Category := Aca2ndSuppExamsDetails.Category::Supplementary;
                                        Aca2ndSuppExamsDetails.Programme := StudentUnits.Programme;

                                        IF Aca2ndSuppExamsDetails.INSERT THEN;
                                    END;

                                END;
                            END;
                            /////////////////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                        END;
                    END;
                END;
            END;
            UNTIL FirstSuppUnitsRegFor2ndSupp.NEXT = 0;
        END;

        // Update Averages
        CLEAR(TotalRecs);
        CLEAR(CountedRecs);
        CLEAR(RemeiningRecs);
        CLEAR(ACA2NDExamClassificationStuds);
        ACA2NDExamCourseRegistration.RESET;
        ACA2NDExamCourseRegistration.SETFILTER("Reporting Academic Year", ACASuppExamCoRegfor2ndSupp."Academic Year");
        ACA2NDExamCourseRegistration.SETFILTER("Student Number", ACASuppExamCoRegfor2ndSupp."Student Number");
        ACA2NDExamCourseRegistration.SETFILTER(Programme, ACASuppExamCoRegfor2ndSupp.Programme);
        IF ACA2NDExamCourseRegistration.FIND('-') THEN BEGIN
            TotalRecs := ACA2NDExamCourseRegistration.COUNT;
            RemeiningRecs := TotalRecs;
            REPEAT
            BEGIN

                Progyz.RESET;
                Progyz.SETRANGE(Code, ACA2NDExamCourseRegistration.Programme);
                IF Progyz.FIND('-') THEN;
                CountedRecs += 1;
                RemeiningRecs -= 1;
                ACA2NDExamCourseRegistration.CALCFIELDS("Total Marks", "Total Courses", "Total Weighted Marks",
              "Total Units", "Classified Total Marks", "Total Classified C. Count", "Classified W. Total", "Attained Stage Units", Average, "Weighted Average");
                ACA2NDExamCourseRegistration."Normal Average" := ROUND((ACA2NDExamCourseRegistration.Average), 0.01, '=');
                IF ACA2NDExamCourseRegistration."Total Units" > 0 THEN
                    ACA2NDExamCourseRegistration."Weighted Average" := ROUND((ACA2NDExamCourseRegistration."Total Weighted Marks" / ACA2NDExamCourseRegistration."Total Units"), 0.01, '=');
                IF ACA2NDExamCourseRegistration."Total Classified C. Count" <> 0 THEN
                    ACA2NDExamCourseRegistration."Classified Average" := ROUND((ACA2NDExamCourseRegistration."Classified Total Marks" / ACA2NDExamCourseRegistration."Total Classified C. Count"), 0.01, '=');
                IF ACA2NDExamCourseRegistration."Total Classified Units" <> 0 THEN
                    ACA2NDExamCourseRegistration."Classified W. Average" := ROUND((ACA2NDExamCourseRegistration."Classified W. Total" / ACA2NDExamCourseRegistration."Total Classified Units"), 0.01, '=');
                ACA2NDExamCourseRegistration.CALCFIELDS("Defined Units (Flow)");
                ACA2NDExamCourseRegistration."Required Stage Units" := ACA2NDExamCourseRegistration."Defined Units (Flow)";//RequiredStageUnits(ACA2NDExamCourseRegistration.Programme,
                                                                                                                           //ACA2NDExamCourseRegistration."Year of Study",ACA2NDExamCourseRegistration."Student Number");
                IF ACA2NDExamCourseRegistration."Required Stage Units" > ACA2NDExamCourseRegistration."Attained Stage Units" THEN
                    ACA2NDExamCourseRegistration."Units Deficit" := ACA2NDExamCourseRegistration."Required Stage Units" - ACA2NDExamCourseRegistration."Attained Stage Units";
                ACA2NDExamCourseRegistration."Multiple Programe Reg. Exists" := GetMultipleProgramExists(ACA2NDExamCourseRegistration."Student Number", ACA2NDExamCourseRegistration."Academic Year");

                ACA2NDExamCourseRegistration."Final Classification" := GetRubricSupp2(Progyz, ACA2NDExamCourseRegistration);
                IF Coregcs."Stopage Yearly Remark" <> '' THEN
                    ACA2NDExamCourseRegistration."Final Classification" := Coregcs."Stopage Yearly Remark";
                ACA2NDExamCourseRegistration."Final Classification Pass" := Get2ndSuppRubricPassStatus(ACA2NDExamCourseRegistration."Final Classification",
                ACA2NDExamCourseRegistration."Academic Year", Progyz);
                ACA2NDExamCourseRegistration."Final Classification Order" := Get2ndSuppRubricOrder(ACA2NDExamCourseRegistration."Final Classification");
                ACA2NDExamCourseRegistration."Final Classification Pass" := GetRubricPassStatus(ACA2NDExamCourseRegistration."Final Classification",
                ACA2NDExamCourseRegistration."Academic Year", Progyz);
                ACA2NDExamCourseRegistration.Classification := ACA2NDExamCourseRegistration."Final Classification";
                IF ACA2NDExamCourseRegistration."Total Courses" = 0 THEN BEGIN
                    //  ACA2NDExamCourseRegistration."Final Classification":='HALT';
                    ACA2NDExamCourseRegistration."Final Classification Pass" := FALSE;
                    ACA2NDExamCourseRegistration."Final Classification Order" := 10;
                    ACA2NDExamCourseRegistration.Graduating := FALSE;
                    //  ACA2NDExamCourseRegistration.Classification:='HALT';
                END;
                IF Coregcs."Stopage Yearly Remark" <> '' THEN
                    ACA2NDExamCourseRegistration.Classification := Coregcs."Stopage Yearly Remark";
                ACA2NDExamCourseRegistration.CALCFIELDS("Total Marks",
   "Total Weighted Marks",
   "Total Failed Courses",
   "Total Failed Units",
   "Failed Courses",
   "Failed Units",
   "Failed Cores",
   "Failed Required",
   "Failed Electives",
   "Total Cores Done",
   "Total Cores Passed",
   "Total Required Done",
   "Total Electives Done",
   "Tota Electives Passed");
                ACA2NDExamCourseRegistration.CALCFIELDS(
                "Classified Electives C. Count",
                "Classified Electives Units",
                "Total Classified C. Count",
                "Total Classified Units",
                "Classified Total Marks",
                "Classified W. Total",
                "Total Failed Core Units");
                ACA2NDExamCourseRegistration."Cummulative Fails" := GetCummulativeFails(ACA2NDExamCourseRegistration."Student Number", ACA2NDExamCourseRegistration."Year of Study");
                ACA2NDExamCourseRegistration."Cumm. Required Stage Units" := GetCummulativeReqStageUnitrs(ACA2NDExamCourseRegistration.Programme, ACA2NDExamCourseRegistration."Year of Study", ACA2NDExamCourseRegistration."Programme Option",
                ACA2NDExamCourseRegistration."Academic Year");
                ACA2NDExamCourseRegistration."Cumm Attained Units" := GetCummAttainedUnits(ACA2NDExamCourseRegistration."Student Number", ACA2NDExamCourseRegistration."Year of Study", ACA2NDExamCourseRegistration.Programme);
                ACA2NDExamCourseRegistration.MODIFY;

            END;
            UNTIL ACA2NDExamCourseRegistration.NEXT = 0;
        END;
    end;

    procedure GetRubricSupp2(ACAProgramme: Record "ACA-Programme"; CoursesRegz: Record "ACA-2ndSuppExam. Co. Reg.") StatusRemarks: Text[150]
    var
        Customer: Record "ACA-Course Registration";
        LubricIdentified: Boolean;
        ACAResultsStatus: Record "ACA-2ndSupp. Results Status";
        YearlyReMarks: Text[250];
        StudCoregcs2: Record "ACA-Course Registration";
        StudCoregcs24: Record "ACA-Course Registration";
        Customersz: Record Customer;
        ACARegStoppageReasons: Record "ACA-Reg. Stoppage Reasons";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        StudCoregcs: Record "ACA-Course Registration";
        ObjUnits: Record "ACA-Student Units";
    Begin

        CLEAR(StatusRemarks);
        CLEAR(YearlyReMarks);
        Customer.RESET;
        Customer.SETRANGE("Student No.", CoursesRegz."Student Number");
        Customer.SETRANGE("Academic Year", CoursesRegz."Academic Year");
        IF Customer.FIND('+') THEN BEGIN
            IF ((Customer.Status = Customer.Status::Registration) OR (Customer.Status = Customer.Status::Current)) THEN BEGIN
                CLEAR(LubricIdentified);
                CoursesRegz.CALCFIELDS("Attained Stage Units", "Failed Cores", "Failed Courses", "Failed Electives", "Failed Required", "Failed Units",
                "Total Failed Units", "Total Marks", "Total Required Done",
                "Total Required Passed", "Total Units", "Total Weighted Marks", "Exists DTSC Prefix");
                CoursesRegz.CALCFIELDS("Total Cores Done", "Total Cores Passed", "Total Courses", "Total Electives Done", "Total Failed Courses",
                "Tota Electives Passed", "Total Classified C. Count", "Total Classified Units", "Total Classified Units");
                IF CoursesRegz."Total Courses" > 0 THEN
                    CoursesRegz."% Failed Courses" := (CoursesRegz."Failed Courses" / CoursesRegz."Total Courses") * 100;
                CoursesRegz."% Failed Courses" := ROUND(CoursesRegz."% Failed Courses", 0.01, '>');
                IF CoursesRegz."% Failed Courses" > 100 THEN CoursesRegz."% Failed Courses" := 100;
                IF CoursesRegz."Total Cores Done" > 0 THEN
                    CoursesRegz."% Failed Cores" := ((CoursesRegz."Failed Cores" / CoursesRegz."Total Cores Done") * 100);
                CoursesRegz."% Failed Cores" := ROUND(CoursesRegz."% Failed Cores", 0.01, '>');
                IF CoursesRegz."% Failed Cores" > 100 THEN CoursesRegz."% Failed Cores" := 100;
                IF CoursesRegz."Total Units" > 0 THEN
                    CoursesRegz."% Failed Units" := (CoursesRegz."Failed Units" / CoursesRegz."Total Units") * 100;
                CoursesRegz."% Failed Units" := ROUND(CoursesRegz."% Failed Units", 0.01, '>');
                IF CoursesRegz."% Failed Units" > 100 THEN CoursesRegz."% Failed Units" := 100;
                IF CoursesRegz."Total Electives Done" > 0 THEN
                    CoursesRegz."% Failed Electives" := (CoursesRegz."Failed Electives" / CoursesRegz."Total Electives Done") * 100;
                CoursesRegz."% Failed Electives" := ROUND(CoursesRegz."% Failed Electives", 0.01, '>');
                IF CoursesRegz."% Failed Electives" > 100 THEN CoursesRegz."% Failed Electives" := 100;
                // CoursesRegz.MODIFY;
                IF CoursesRegz."Student Number" = 'P101/2243G/22' THEN
                    ACAResultsStatus.RESET;
                ACAResultsStatus.RESET;
                ACAResultsStatus.SETFILTER("Manual Status Processing", '%1', FALSE);
                ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                //ACAResultsStatus.SETRANGE("Special Programme Class",ACAProgramme."Special Programme Class");
                // ACAResultsStatus.SETFILTER("Min. Unit Repeat Counts",'=%1|<%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                // ACAResultsStatus.SETFILTER("Max. Unit Repeat Counts",'=%1|>%2',CoursesRegz."Highest Yearly Repeats",CoursesRegz."Highest Yearly Repeats");
                // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',CoursesRegz."Yearly Failed Units %",CoursesRegz."Yearly Failed Units %");
                IF ACAProgramme."Special Programme Class" = ACAProgramme."Special Programme Class"::"Medicine & Nursing" THEN BEGIN
                    // // // // // // //  IF CoursesRegz."% Failed Cores">0 THEN BEGIN
                    // // // // // // // ACAResultsStatus.SETFILTER("Minimum Core Fails",'=%1|<%2',CoursesRegz."% Failed Cores",CoursesRegz."% Failed Cores");
                    // // // // // // // ACAResultsStatus.SETFILTER("Maximum Core Fails",'=%1|>%2',CoursesRegz."% Failed Cores",CoursesRegz."% Failed Cores");
                    // // // // // // // END ELSE BEGIN
                    // // // // // // //  ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',CoursesRegz."Failed Courses",CoursesRegz."Failed Courses");
                    // // // // // // //  ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',CoursesRegz."Failed Courses",CoursesRegz."Failed Courses");
                    // // // // // // // END;
                    //  ACAResultsStatus.SETFILTER("Minimum None-Core Fails",'=%1|<%2',CoursesRegz."Failed Required",CoursesRegz."Failed Required");
                    // ACAResultsStatus.SETFILTER("Maximum None-Core Fails",'=%1|>%2',CoursesRegz."Failed Required",CoursesRegz."Failed Required");
                    ACAResultsStatus.SETFILTER("Special Programme Class", '=%1', ACAResultsStatus."Special Programme Class"::"Medicine & Nursing");
                END ELSE BEGIN
                    ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                    ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                END;
                ACAResultsStatus.SETFILTER("Minimum Units Failed", '=%1|<%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                ACAResultsStatus.SETFILTER("Maximum Units Failed", '=%1|>%2', CoursesRegz."% Failed Units", CoursesRegz."% Failed Units");
                // // // // // ELSE BEGIN
                // // // // // ACAResultsStatus.SETFILTER("Minimum Units Failed",'=%1|<%2',YearlyFailedUnits,YearlyFailedUnits);
                // // // // // ACAResultsStatus.SETFILTER("Maximum Units Failed",'=%1|>%2',YearlyFailedUnits,YearlyFailedUnits);
                // // // // //  END;
                ACAResultsStatus.SETCURRENTKEY("Order No");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        StatusRemarks := ACAResultsStatus.Code;
                        IF ACAResultsStatus."Lead Status" <> '' THEN
                            StatusRemarks := ACAResultsStatus."Lead Status";
                        YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        LubricIdentified := TRUE;
                    END;
                    UNTIL ((ACAResultsStatus.NEXT = 0) OR (LubricIdentified = TRUE))
                END;
                CoursesRegz.CALCFIELDS("Supp/Special Exists", "Attained Stage Units", "Special Registration Exists");
                //IF CoursesRegz."Supp/Special Exists" THEN  StatusRemarks:='SPECIAL';
                IF CoursesRegz."Units Deficit" > 0 THEN StatusRemarks := 'DTSC';
                IF CoursesRegz."Required Stage Units" > CoursesRegz."Attained Stage Units" THEN StatusRemarks := 'DTSC';
                IF CoursesRegz."Attained Stage Units" = 0 THEN StatusRemarks := 'DTSC';
                //IF CoursesRegz."Exists DTSC Prefix" THEN StatusRemarks:='DTSC';
                //IF CoursesRegz."Special Registration Exists" THEN StatusRemarks:='Special';

                ////////////////////////////////////////////////////////////////////////////////////////////////
                // Check if exists a stopped Semester for the Academic Years and Pick the Status on the lines as the rightful Status
                CLEAR(StudCoregcs24);
                StudCoregcs24.RESET;
                StudCoregcs24.SETRANGE("Student No.", CoursesRegz."Student Number");
                StudCoregcs24.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                StudCoregcs24.SETRANGE(Reversed, TRUE);
                IF StudCoregcs24.FIND('-') THEN BEGIN
                    CLEAR(ACARegStoppageReasons);
                    ACARegStoppageReasons.RESET;
                    ACARegStoppageReasons.SETRANGE("Reason Code", StudCoregcs24."Stoppage Reason");
                    IF ACARegStoppageReasons.FIND('-') THEN BEGIN

                        ACAResultsStatus.RESET;
                        ACAResultsStatus.SETRANGE(Status, ACARegStoppageReasons."Global Status");
                        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                        IF ACAResultsStatus.FIND('-') THEN BEGIN
                            StatusRemarks := ACAResultsStatus.Code;
                            YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                        END ELSE BEGIN
                            // StatusRemarks:=UPPERCASE(FORMAT(Customer.Status));
                            StatusRemarks := UPPERCASE(FORMAT(StudCoregcs24."Stoppage Reason"));
                            YearlyReMarks := StatusRemarks;
                        END;
                    END;
                END;
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

            END ELSE BEGIN

                CoursesRegz.CALCFIELDS("Attained Stage Units");
                IF CoursesRegz."Attained Stage Units" = 0 THEN StatusRemarks := 'DTSC';
                IF (NOT CoursesRegz."Special Registration Exists") AND (StatusRemarks = 'DTSC') THEN BEGIN
                    ///Ensure special is not skipped.
                    ObjUnits.RESET;
                    ObjUnits.SETRANGE("Student No.", CoursesRegz."Student Number");
                    ObjUnits.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                    ObjUnits.SETRANGE("Year Of Study", CoursesRegz."Year of Study");
                    ObjUnits.SETRANGE(ObjUnits."Special Exam", ObjUnits."Special Exam"::Special);
                    IF ObjUnits.FINDFIRST THEN
                        StatusRemarks := 'Special';
                END;
                CLEAR(StudCoregcs);
                StudCoregcs.RESET;
                StudCoregcs.SETRANGE("Student No.", CoursesRegz."Student Number");
                StudCoregcs.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                StudCoregcs.SETRANGE("Stoppage Exists In Acad. Year", TRUE);
                IF StudCoregcs.FIND('-') THEN BEGIN
                    CLEAR(StudCoregcs2);
                    StudCoregcs2.RESET;
                    StudCoregcs2.SETRANGE("Student No.", CoursesRegz."Student Number");
                    StudCoregcs2.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                    StudCoregcs2.SETRANGE("Stoppage Exists In Acad. Year", TRUE);
                    StudCoregcs2.SETRANGE(Reversed, TRUE);
                    IF StudCoregcs2.FIND('-') THEN BEGIN
                        StatusRemarks := UPPERCASE(FORMAT(StudCoregcs2."Stoppage Reason"));
                        YearlyReMarks := StatusRemarks;
                    END;
                END;

                ACAResultsStatus.RESET;
                ACAResultsStatus.SETRANGE(Status, Customer.Status);
                ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
                ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
                IF ACAResultsStatus.FIND('-') THEN BEGIN
                    StatusRemarks := ACAResultsStatus.Code;
                    YearlyReMarks := ACAResultsStatus."Transcript Remarks";
                END ELSE BEGIN
                    StatusRemarks := UPPERCASE(FORMAT(Customer.Status));
                    YearlyReMarks := StatusRemarks;
                END;
            END;
        END;


        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, StatusRemarks);
        ACAResultsStatus.SETRANGE("Academic Year", CoursesRegz."Academic Year");
        ACAResultsStatus.SETRANGE("Special Programme Class", ACAProgramme."Special Programme Class");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            // Check if the Ststus does not allow Supp. Generation and delete
            IF ACAResultsStatus."Skip Supp Generation" = TRUE THEN BEGIN
                // Delete Entries from Supp Registration for the Semester
                CLEAR(AcaSpecialExamsDetails);
                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE("Student No.", CoursesRegz."Student Number");
                AcaSpecialExamsDetails.SETRANGE("Year of Study", CoursesRegz."Year of Study");
                AcaSpecialExamsDetails.SETRANGE("Exam Marks", 0);
                AcaSpecialExamsDetails.SETRANGE(Status, AcaSpecialExamsDetails.Status::New);
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails.Category, AcaSpecialExamsDetails.Category::Supplementary);
                IF AcaSpecialExamsDetails.FIND('-') THEN AcaSpecialExamsDetails.DELETEALL;
            END;
        END;
    End;

    procedure Get2ndSuppRubricOrder(RubricCode: Code[50]) RubricOrder: Integer
    var
        ACAResultsStatus: record "ACA-2ndSupp. Results Status";
    begin
        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, RubricCode);
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            RubricOrder := ACAResultsStatus."Order No";
        END;
    end;

    procedure Get2ndSuppRubricPassStatus(RubricCode: Code[50]; AcademicYears: Code[250]; Progyz: Record "ACA-Programme") PassStatus: Boolean
    var
        ACAResultsStatus: Record "ACA-2ndSupp. Results Status";
    begin

        ACAResultsStatus.RESET;
        ACAResultsStatus.SETRANGE(Code, RubricCode);
        ACAResultsStatus.SETRANGE("Academic Year", AcademicYears);
        ACAResultsStatus.SETRANGE("Special Programme Class", Progyz."Special Programme Class");
        IF ACAResultsStatus.FIND('-') THEN BEGIN
            PassStatus := ACAResultsStatus.Pass;
        END;
    end;

    procedure GetAcademicYearDiff(RegAcademicYear: Code[20]; CurrentAcademicYear: Code[20]) Register2ndSupp: Boolean
    var
        AcadYears: Record "ACA-Academic Year";
        AcaCourseReg: Record "ACA-Course Registration";
        AcaStudUnitsReg: Record "ACA-Student Units";
        ProcessingYearInteger: Integer;
        CurrYearInteger: Integer;
        ProcessingYearString: Text[30];
        CurrYearString: Text[30];
    begin
        CLEAR(ProcessingYearString);
        CLEAR(CurrYearString);
        CLEAR(ProcessingYearInteger);
        CLEAR(CurrYearInteger);
        IF STRLEN(CurrentAcademicYear) > 2 THEN BEGIN
            CurrYearString := COPYSTR(CurrentAcademicYear, STRLEN(CurrentAcademicYear) - 1, 2);

            IF EVALUATE(CurrYearInteger, CurrYearString) THEN;
        END;


        IF STRLEN(RegAcademicYear) > 2 THEN BEGIN
            ProcessingYearString := COPYSTR(RegAcademicYear, STRLEN(RegAcademicYear) - 1, 2);

            IF EVALUATE(ProcessingYearInteger, ProcessingYearString) THEN;
        END;
        IF ((ProcessingYearInteger <> 0) AND (CurrYearInteger <> 0)) THEN BEGIN
            IF ((CurrYearInteger - ProcessingYearInteger) > 1) THEN BEGIN
                EXIT(TRUE); // allow registration of supplementary
            END;
        END;
    end;
}

