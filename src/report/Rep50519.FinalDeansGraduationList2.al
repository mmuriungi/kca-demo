report 50519 "Final Deans Graduation List 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Final Deans Graduation List 2.rdl';
    Caption = 'Graduation List';

    dataset
    {
        dataitem(StudentsClassification; "ACA-Classification Students")
        {
            CalcFields = "Status Students Count", "Prog. Exam Category", "Programme Option", "Prog. Option Name";
            DataItemTableView = WHERE("Final Classification Pass" = FILTER(true), "Final Classification" = FILTER(<> ''));
            RequestFilterFields = "Graduation Academic Year", "School Code";
            column(ClassCode; StudentsClassification."Final Classification")
            {
            }
            column(GradAcademicYear; StudentsClassification."Graduation Academic Year")
            {
            }
            column(ProgCode; StudentsClassification.Programme)
            {
            }
            column(PassStatus; StudentsClassification."Final Classification Pass")
            {
            }
            column(PassStatusOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(ClassOrders; StudentsClassification."Final Classification Order")
            {
            }
            column(ClassOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(YearOfStudy; StudentsClassification."Year of Study")
            {
            }
            column(PassOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(Pics; CompInf.Picture)
            {
            }
            column(Compname; UpperCase(CompInf.Name))
            {
            }
            column(StatusOrderCompiled; StatusOrder)
            {
            }
            column(statusCompiled; statusCompiled)
            {
            }
            column(StatusCode; StudentsClassification."Final Classification")
            {
            }
            column(StatusDesc; ACAResultsStatus.Description)
            {
            }
            column(SummaryPageCaption; ACAResultsStatus."Summary Page Caption")
            {
            }
            column(StatusOrder; StudentsClassification."Final Classification Order")
            {
            }
            column(StatCodes; ACAResultsStatus.Code)
            {
            }
            column(ApprovalsClaimer; 'Approved by the board of the Examiners of the  ' + FacDesc + ' at a meeting held on:')
            {
            }
            column(ProgName; progName)
            {
            }
            column(facCode; facCode)
            {
            }
            column(FacDesc; FacDesc)
            {
            }
            column(YoS; StudentsClassification."Year of Study")
            {
            }
            column(AcadYear; StudentsClassification."Graduation Academic Year")
            {
            }
            column(YearOfStudyText; YearOfStudyText)
            {
            }
            column(NextYear; NextYear)
            {
            }
            column(SaltedExamStatusDesc; 'In the  ' + StudentsClassification."Graduation Academic Year" + ' Academic Year,  ' + SaltedExamStatusDesc)
            {
            }
            column(SaltedExamStatus; SaltedExamStatus)
            {
            }
            column(YoSTexed; YoS)
            {
            }
            column(ExamStatus; StudentsClassification."Final Classification")
            {
            }
            column(Names; Cust.Name)
            {
            }
            column(ProgCat; StudentsClassification."Program Group Order")
            {
            }
            column(ProgrammeOption; StudentsClassification."Programme Option")
            {
            }
            column(OptName; StudentsClassification."Prog. Option Name")
            {
            }
            column(NotClassified; Prog."Not Classified")
            {
            }
            column(ShowOption; Prog."Show Options on Graduation")
            {
            }
            column(StudentNo; Cust."No.")
            {
            }
            column(CourseCatOrder; CourseCatOrder)
            {
            }
            column(CourseCat; Prog.Category)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Clear(NextYear);
                Clear(YearOfStudyText);
                Clear(YoS);
                YoS := GetYearofStudyText(StudentsClassification."Year of Study");
                YearOfStudyText := YoS;
                Clear(IsaForthYear);
                IsaForthYear := true;
                Clear(statusCompiled);
                Clear(progName);
                Prog.Reset;
                Prog.SetRange(Code, StudentsClassification.Programme);
                if Prog.Find('-') then begin
                    progName := Prog.Description;
                    CourseCatOrder := 1;
                    CourseCat := 'BARCHELORS';
                end;

                //Get the Department
                Clear(FacDesc);
                Clear(facCode);
                FacDesc := StudentsClassification."School Name";
                facCode := StudentsClassification."School Code";


                Clear(SaltedExamStatus);
                Clear(SaltedExamStatusDesc);
                SaltedExamStatus := ACAResultsStatus.Code + facCode + Prog.Code +
                Format(StudentsClassification."Year of Study") +
                StudentsClassification."Graduation Academic Year";
                Clear(NoOfStudents);
                Clear(NoOfStudentsDecimal);

                ACAResultsStatus.Reset;

                ACAResultsStatus.SetRange(Code, 'PASS');
                //SaltedExamStatusDesc:=ClassHeader.Msg1;
                Clear(NoOfStudentInText);
                StudentsClassification.CalcFields("Status Students Count");
                NoOfStudents := StudentsClassification."Status Students Count";
                if NoOfStudents <> 0 then NoOfStudentInText := ConvertDecimalToText.InitiateConvertion(NoOfStudents);
                if ACAResultsStatus.Find('-') then begin
                    if ACAResultsStatus."Include Class Variable 1" then SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg1" + ' ' + NoOfStudentInText + ' (' + Format(NoOfStudents) + ') ' + ACAResultsStatus."Classification Msg2";
                    if ACAResultsStatus."Include Class Variable 2" then SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + FacDesc;
                    if StudentsClassification."Program Group Order" = 1 then
                        SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg3"
                    else
                        if StudentsClassification."Program Group Order" = 2 then
                            SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg4"
                        else
                            if StudentsClassification."Program Group Order" = 3 then
                                SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Classification Msg5";
                    //IF ACAResultsStatus."Include Class Variable 3" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+ACAResultsStatus."Classification Msg4";
                    //IF ACAResultsStatus."Include Class Variable 4" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+progName+' '+ClassHeader.Msg5;
                    // IF ACAResultsStatus."Include Class Variable 5" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc;//+' '+NextYear;
                    // IF ACAResultsStatus."Include Class Variable 6" THEN SaltedExamStatusDesc:=SaltedExamStatusDesc+' '+ClassHeader.Msg6;
                    SaltedExamStatusDesc := SaltedExamStatusDesc + ' ' + ACAResultsStatus."Final Year Comment";
                end;

                Cust.Reset;
                Cust.SetRange("No.", StudentsClassification."Student Number");
                if Cust.Find('-') then;

                if StudentsClassification."Final Classification" = 'DISTINCTION' then
                    StudentsClassification."Final Classification Order" := 1
                else
                    if StudentsClassification."Final Classification" = 'CREDIT' then StudentsClassification."Final Classification Order" := 2;

                if StudentsClassification."Programme Option" <> '' then begin
                    if StudentsClassification."Prog. Option Name" = '' then StudentsClassification."Prog. Option Name" := StudentsClassification."Programme Option";
                    StudentsClassification."Prog. Option Name" := StudentsClassification."Prog. Option Name" + ' Option';
                end;
                if Prog."Show Options on Graduation" = false then begin
                    StudentsClassification."Programme Option" := '';
                    StudentsClassification."Prog. Option Name" := '';
                end;
            end;

            trigger OnPreDataItem()
            begin
                //ClassHeader.SETFILTER("User ID",USERID);
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
        CompInf.Get();
        CompInf.CalcFields(CompInf.Picture);
    end;

    trigger OnPreReport()
    var
        ACAGraduationReportPicker: Record "ACA-Graduation Report Picker";
        GradAcdYear: Code[1024];
        YearOfStudy: Option " ","1","2","3","4","5","6","7";
        ProgFilters: Code[1024];
        ACACourseRegistration: Record "ACA-Classification Students";
        ITmCourseReg: Record "ACA-Classification Students";
        ACAProgramme: Record "ACA-Programme";
        ACAProgrammeStages: Record "ACA-Programme Stages";
        YoSComputed: Integer;
        ACAClassificationHeader: Record "ACA-Classification Header";
        ACAClassificationDetails: Record "ACA-Classification Details";
        ACAClassificationDetails2: Record "ACA-Classification Details";
        ACAClassGradRubrics: Record "ACA-Class/Grad. Rubrics";
        SpecialReason: Text[150];
        failExists: Boolean;
        StatusOrder: Integer;
        statusCompiled: Code[50];
        NotSpecialNotSuppSpecial: Boolean;
        isSpecialOnly: Boolean;
        IsSpecialAndSupp: Boolean;
        IsaForthYear: Boolean;
        IsSpecialUnit: Boolean;
        SpecialUnitReg1: Boolean;
        SpecialUnitReg: Boolean;
        ACASenateReportCounts: Record "ACA-Senate Report Counts";
        NoOfStudentInText: Text[250];
        ConvertDecimalToText: Codeunit "Convert Decimal To Text";
        PercentageFailedCaption: Text[100];
        NumberOfCoursesFailedCaption: Text[100];
        PercentageFailedValue: Decimal;
        NoOfCausesFailedValue: Integer;
        NoOfStudentsDecimal: Text;
        ACAStudentUnits: Record "ACA-Classification Units";
        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;
        StudUnits: Record "ACA-Classification Units";
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record Customer;
        Semesters: Record "ACA-Semesters";
        Dimensions: Record "Dimension Value";
        Prog: Record "ACA-Programme";
        FacDesc: Code[100];
        Depts: Record "Dimension Value";
        Stages: Record "ACA-Programme Stages";
        StudentsL: Text[250];
        N: Integer;
        Grd: Code[20];
        Marks: Decimal;
        Dimensions2: Record "Dimension Value";
        ResultsStatus: Record "ACA-Class/Grad. Rubrics";
        ResultsStatus3: Record "ACA-Class/Grad. Rubrics";
        UnitsRec: Record "ACA-Units/Subjects";
        UnitsDesc: Text[100];
        UnitsHeader: Text[50];
        FailsDesc: Text[200];
        Nx: Integer;
        RegNo: Code[20];
        Names: Text[100];
        Ucount: Integer;
        RegNox: Code[20];
        Namesx: Text[100];
        Nxx: Text[30];
        SemYear: Code[20];
        ShowSem: Boolean;
        SemDesc: Code[100];
        CREG2: Record "ACA-Classification Students";
        ExamsProcessing: Codeunit "Exams Processing1";
        CompInf: Record "Company Information";
        YearDesc: Text[30];
        MaxYear: Code[20];
        MaxSem: Code[20];
        CummScore: Decimal;
        CurrScore: Decimal;
        mDate: Date;
        IntakeRec: Record "ACA-Intake";
        IntakeDesc: Text[100];
        SemFilter: Text[100];
        StageFilter: Text[100];
        MinYear: Code[20];
        MinSem: Code[20];
        StatusNarrations: Text[1000];
        NextYear: Code[20];
        facCode: Code[20];
        progName: Code[150];
        ACAResultsStatus: Record "ACA-Class/Grad. Rubrics";
        Msg1: Text[250];
        Msg2: Text[250];
        Msg3: Text[250];
        Msg4: Text[250];
        Msg5: Text[250];
        Msg6: Text[250];
        YearOfStudyText: Text[30];
        SaltedExamStatus: Code[1024];
        SaltedExamStatusDesc: Text;
        ACASenateReportStatusBuff: Record "ACA-Senate Report Status Buff." temporary;
        CurrNo: Integer;
        YoS: Code[20];
        CReg33: Record "ACA-Classification Students";
        CReg: Record "ACA-Classification Students";
        yosInt: Integer;
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        incounts: Integer;
    begin
        if StudentsClassification.GetFilter("Graduation Academic Year") = '' then Error('Missing Academic years Filter');
        if StudentsClassification.GetFilter("School Code") = '' then Error('Missing Faculty');
    end;

    var
        ACACourseRegistration741: Record "ACA-Classification Course Reg.";
        SpecialReason: Text[150];
        failExists: Boolean;
        StatusOrder: Integer;
        statusCompiled: Code[50];
        NotSpecialNotSuppSpecial: Boolean;
        isSpecialOnly: Boolean;
        IsSpecialAndSupp: Boolean;
        IsaForthYear: Boolean;
        IsSpecialUnit: Boolean;
        SpecialUnitReg1: Boolean;
        SpecialUnitReg: Boolean;
        ACASenateReportCounts: Record "ACA-Senate Report Counts";
        NoOfStudentInText: Text[250];
        ConvertDecimalToText: Codeunit "Convert Decimal To Text";
        PercentageFailedCaption: Text[100];
        NumberOfCoursesFailedCaption: Text[100];
        PercentageFailedValue: Decimal;
        NoOfCausesFailedValue: Integer;
        NoOfStudentsDecimal: Text;
        CountedRecs: Integer;
        UnitCodes: array[30] of Text[50];
        UnitDescs: array[30] of Text[150];
        UnitCodeLabel: Text;
        UnitDescriptionLabel: Text;
        NoOfStudents: Integer;
        StudUnits: Record "ACA-Classification Units";
        ExamsDone: Integer;
        FailCount: Integer;
        Cust: Record Customer;
        Semesters: Record "ACA-Semesters";
        Dimensions: Record "Dimension Value";
        Prog: Record "ACA-Programme";
        FacDesc: Code[100];
        Depts: Record "Dimension Value";
        Stages: Record "ACA-Programme Stages";
        StudentsL: Text[250];
        N: Integer;
        Grd: Code[20];
        Marks: Decimal;
        Dimensions2: Record "Dimension Value";
        UnitsRec: Record "ACA-Units/Subjects";
        UnitsDesc: Text[100];
        UnitsHeader: Text[50];
        FailsDesc: Text[200];
        Nx: Integer;
        RegNo: Code[20];
        Names: Text[100];
        Ucount: Integer;
        RegNox: Code[20];
        Namesx: Text[100];
        Nxx: Text[30];
        SemYear: Code[20];
        ShowSem: Boolean;
        SemDesc: Code[100];
        ExamsProcessing: Codeunit "Exams Processing1";
        CompInf: Record "Company Information";
        YearDesc: Text[30];
        MaxYear: Code[20];
        MaxSem: Code[20];
        CummScore: Decimal;
        CurrScore: Decimal;
        mDate: Date;
        IntakeRec: Record "ACA-Intake";
        IntakeDesc: Text[100];
        SemFilter: Text[100];
        StageFilter: Text[100];
        MinYear: Code[20];
        MinSem: Code[20];
        StatusNarrations: Text[1000];
        NextYear: Code[20];
        facCode: Code[20];
        progName: Code[150];
        ACAResultsStatus: Record "ACA-Class/Grad. Rubrics";
        YearOfStudyText: Text[30];
        SaltedExamStatus: Code[1024];
        SaltedExamStatusDesc: Text;
        ACASenateReportStatusBuff: Record "ACA-Senate Report Status Buff." temporary;
        CurrNo: Integer;
        YoS: Code[20];
        yosInt: Integer;
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ReoderElement: Code[10];
        ProgCat: Code[10];
        CourseCatOrder: Integer;
        CourseCat: Code[50];

    local procedure GetYearofStudyText(Yos: Integer) YosText: Text[150]
    begin
        Clear(YosText);
        if Yos = 1 then YosText := 'FIRST';
        if Yos = 2 then YosText := 'SECOND';
        if Yos = 3 then YosText := 'THIRD';
        if Yos = 4 then YosText := 'FORTH';
        if Yos = 5 then YosText := 'FIFTH';
        if Yos = 6 then YosText := 'SIXTH';
        if Yos = 7 then YosText := 'SEVENTH';
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
}

