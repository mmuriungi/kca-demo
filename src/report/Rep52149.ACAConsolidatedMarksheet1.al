report 52149 "ACA-Consolidated Marksheet 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ACA-Consolidated Marksheet 1.rdl';

    dataset
    {
        dataitem(ExamCoreg; "ACA-Exam. Course Registration")
        {
            CalcFields = "Total Courses", "Total Units", "Total Marks", "Total Failed Courses", "Total Failed Units", "Failed Courses", "Failed Units", "Total Cores Passed", "Tota Electives Passed", "Total Required Passed", "Total Cores Done", "Total Required Done", "Total Electives Done";
            RequestFilterFields = Programme, "Academic Year", "Year of Study", "Programme Option";
            RequestFilterHeading = 'Report Filters';
            column(seq; seq)
            {
            }
            column(COmpName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address + ', ' + CompanyInformation."Address 2" + ' ' + CompanyInformation.City)
            {
            }
            column(CompPhone; CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2")
            {
            }
            column(pic; CompanyInformation.Picture)
            {
            }
            column(mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(StudNumber; ExamCoreg."Student Number")
            {
            }
            column(Progs; ExamCoreg.Programme)
            {
            }
            column(YearofStudy; ExamCoreg."Year of Study")
            {
            }
            column(AcadYear; ExamCoreg."Academic Year")
            {
            }
            column(StudentName; ExamCoreg."Student Name")
            {
            }
            column(Dept; ExamCoreg.Department)
            {
            }
            column(SchCode; ExamCoreg."School Code")
            {
            }
            column(DeptName; ExamCoreg."Department Name")
            {
            }
            column(SchName; ExamCoreg."School Name")
            {
            }
            column(Class; ExamCoreg.Classification)
            {
            }
            column(NAverage; Round(ExamCoreg."Normal Average", 0.01, '='))
            {
            }
            column(WAverage; Round(ExamCoreg."Weighted Average", 0.01, '='))
            {
            }
            column(ProgOption; ExamCoreg."Programme Option")
            {
            }
            column(PercentageFailedCourses; ExamCoreg."% Total Failed Courses")
            {
            }
            column(PercentageFailedUnits; ExamCoreg."% Total Failed Units")
            {
            }
            column(TotalPassed; ExamCoreg."Total Required Passed" + ExamCoreg."Tota Electives Passed" + ExamCoreg."Total Cores Passed")
            {
            }
            column(TotalCourseDone; ExamCoreg."Total Electives Done" + ExamCoreg."Total Required Done" + ExamCoreg."Total Cores Done")
            {
            }
            column(TotalUnits; ExamCoreg."Total Units")
            {
            }
            column(TotalMarks; ExamCoreg."Total Marks")
            {
            }
            column(TotFailedCourses; ExamCoreg."Total Failed Courses")
            {
            }
            column(TotFailedUnits; ExamCoreg."Total Failed Units")
            {
            }
            column(FailedCourses; ExamCoreg."Failed Courses")
            {
            }
            column(FailedUnits; ExamCoreg."Failed Units")
            {
            }
            column(TotalCoursesPassed; ExamCoreg."Total Required Passed" + ExamCoreg."Tota Electives Passed" + ExamCoreg."Total Cores Passed")
            {
            }
            column(TotWeightedMarks; ExamCoreg."Total Weighted Marks")
            {
            }
            column(ClassOrder; ExamCoreg."Final Classification Order")
            {
            }
            dataitem(ExamClassUnits; "ACA-Exam Classification Units")
            {
                CalcFields = "Comsolidated Prefix", "Grade Comment", Grade, Pass;
                DataItemLink = "Student No." = FIELD("Student Number"), Programme = FIELD(Programme), "Academic Year" = FIELD("Academic Year"), "Year of Study" = FIELD("Year of Study");
                column(UnitCode; ExamClassUnits."Unit Code")
                {
                }
                column(UnitDescription; ExamClassUnits."Unit Description")
                {
                }
                column(CreditHours; ExamClassUnits."Credit Hours")
                {
                }
                column(CATScore; ExamClassUnits."CAT Score")
                {
                }
                column(ExamScore; ExamClassUnits."Exam Score")
                {
                }
                column(TotalScore; ExamClassUnits."Total Score")
                {
                }
                column(Pass; ExamClassUnits.Pass)
                {
                }
                column(UnitYearOfStudy; ExamClassUnits."Year of Study")
                {
                }
                column(ExamScoreDecimal; ExamClassUnits."Exam Score Decimal")
                {
                }
                column(CATScoreDecimal; ExamClassUnits."CAT Score Decimal")
                {
                }
                column(TotalScoreDecimal; ExamClassUnits."Total Score Decimal")
                {
                }
                column(UnitGrade; ExamClassUnits.Grade)
                {
                }
                column(UnitSchoolCode; ExamClassUnits."School Code")
                {
                }
                column(UnitDepartmentCode; ExamClassUnits."Department Code")
                {
                }
                column(GradeComment; ExamClassUnits."Grade Comment")
                {
                }
                column(Prefix; ExamClassUnits."Comsolidated Prefix")
                {
                }
                column(isRepeatOrResit; ExamClassUnits."Is a Resit/Repeat")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;

            trigger OnPreDataItem()
            begin
                Clear(seq);
                if ExamCoreg.GetFilter(Programme) = '' then Error('Specify a programme');
                if ExamCoreg.GetFilter("Academic Year") = '' then Error('Specify Academic year');
                if ExamCoreg.GetFilter("Year of Study") = '' then Error('Specify Year of Study');
                ACAProgrammeOptions.Reset;
                ACAProgrammeOptions.SetRange("Programme Code", ExamCoreg.GetFilter(Programme));
                ACAProgrammeOptions.SetFilter(Code, '<>%1', '');
                if ACAProgrammeOptions.Find('-') then begin
                    //IF ExamCoreg.GETFILTER("Programme Option")='' THEN ERROR('Specify Programme option');
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
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
        if CompanyInformation.Find('-') then CompanyInformation.CalcFields(Picture);
    end;

    trigger OnPreReport()
    begin
        if ExamCoreg.GetFilter(Programme) = '' then Error('Specify a programme filter.');
    end;


    var
        CompanyInformation: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        seq: Integer;
        ACAProgrammeOptions: Record "ACA-Programme Options";

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

