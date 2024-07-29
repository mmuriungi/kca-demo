report 52139 "Exams Final Pass List C 5"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Exams Final Pass List C 5.rdl';

    dataset
    {
        dataitem(SenateHeaders; "ACA-Senate Reports Header")
        {
            CalcFields = School_AcadYearTrans_Count, School_AcadYear_Count, School_AcadYear_Status_Count, SchCat_AcadYear_BarcCo, SchCat_AcadYear_Status_BarcCo, SchCat_AcadYearTrans_BarcCo, SchCat_AcadYear_MasCo, SchCat_AcadYear_Status_MasCo, SchCat_AcadYearTrans_MascCo, SchCat_AcadYear_DipCo, SchCat_AcadYear_Status_DipCo, SchCat_AcadYearTrans_DipCo, SchCat_AcadYear_CertCo, SchCat_AcadYear_Status_CertCo, SchCat_AcadYearTrans_CertCo, "School Classification Count", "Programme Classification Count";
            //  DataItemTableView = SORTING("Programme Code", "Academic Year", "Year of Study") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Academic Year", "School Code", "Year of Study";
            column(CompName; CompanyInformation.Name)
            {
            }
            column(Address; CompanyInformation.Address + ',' + CompanyInformation."Address 2" + ',' + CompanyInformation.City)
            {
            }
            column(Phones; CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2")
            {
            }
            column(pics; CompanyInformation.Picture)
            {
            }
            column(mails; CompanyInformation."E-Mail" + '/' + CompanyInformation."Home Page")
            {
            }
            column(ProgFilter; ProgFilter)
            {
            }
            column(YoSText; YoSText + ' YEAR')
            {
            }
            column(School_AcadYear_Status_Count; SenateHeaders.School_AcadYear_Status_Count)
            {
            }
            column(School_AcadYear_Count; SenateHeaders.School_AcadYear_Count)
            {
            }
            column(StatusPercentage; StatusPercentage)
            {
            }
            column(TransRate; TransRate)
            {
            }
            column(Transition; SenateHeaders.School_AcadYearTrans_Count)
            {
            }
            column(BarcCo; SenateHeaders.SchCat_AcadYear_BarcCo)
            {
            }
            column(Status_BarcCo; SenateHeaders.SchCat_AcadYear_Status_BarcCo)
            {
            }
            column(Trans_BarcCo; SenateHeaders.SchCat_AcadYearTrans_BarcCo)
            {
            }
            column(TransRateBarch; TransRateBarch)
            {
            }
            column(ShowRateBarch; ShowRateBarch)
            {
            }
            column(StatusPercentageBarchelors; StatusPercentageBarchelors)
            {
            }
            column(MasCo; SenateHeaders.SchCat_AcadYear_MasCo)
            {
            }
            column(Status_MasCo; SenateHeaders.SchCat_AcadYear_Status_MasCo)
            {
            }
            column(Trans_MascCo; SenateHeaders.SchCat_AcadYearTrans_MascCo)
            {
            }
            column(TransRateMasters; TransRateMasters)
            {
            }
            column(ShowRateMasters; ShowRateMasters)
            {
            }
            column(StatusPercentageMasters; StatusPercentageMasters)
            {
            }
            column(DipCo; SenateHeaders.SchCat_AcadYear_DipCo)
            {
            }
            column(Status_DipCo; SenateHeaders.SchCat_AcadYear_Status_DipCo)
            {
            }
            column(Trans_DipCo; SenateHeaders.SchCat_AcadYearTrans_DipCo)
            {
            }
            column(TransRateDiploma; TransRateDiploma)
            {
            }
            column(ShowRateDiploma; ShowRateDiploma)
            {
            }
            column(StatusPercentageDiploma; StatusPercentageDiploma)
            {
            }
            column(CertCo; SenateHeaders.SchCat_AcadYear_CertCo)
            {
            }
            column(Status_CertCo; SenateHeaders.SchCat_AcadYear_Status_CertCo)
            {
            }
            column(Trans_CertCo; SenateHeaders.SchCat_AcadYearTrans_CertCo)
            {
            }
            column(TransRateCertificate; TransRateCertificate)
            {
            }
            column(ShowRateCertificate; ShowRateCertificate)
            {
            }
            column(StatusPercentageCert; StatusPercentageCert)
            {
            }
            dataitem(ExamsCoreg; "ACA-Exam. Course Registration")
            {
                DataItemLink = Programme = FIELD("Programme Code"), "School Code" = FIELD("School Code"), "Academic Year" = FIELD("Academic Year"), Classification = FIELD("Classification Code"), "Year of Study" = FIELD("Year of Study");
                DataItemTableView = SORTING(Programme, "Programme Option", "Student Number", "Category Order") ORDER(Ascending);
                column(ProgOptions; ExamsCoreg."Programme Option")
                {
                }
                column(CatOrder; ExamsCoreg."Category Order")
                {
                }
                column(seqSequence; ExamsCoreg."Rubric Number")
                {
                }
                column(seq; ExamsCoreg."Record Count")
                {
                }
                column(SchNames; ExamsCoreg."School Name")
                {
                }
                column(ProgNames; ACAProgramme.Description)
                {
                }
                column(FinalTexts; FinalTexts)
                {
                }
                column(ShowRate; ShowRate)
                {
                }
                column(Messages1; ACAResultsStatusez."Grad. Status Msg 1")
                {
                }
                column(Messages2; ACAResultsStatusez."Grad. Status Msg 2")
                {
                }
                column(Messages3; ACAResultsStatusez."Grad. Status Msg 3")
                {
                }
                column(Messages4; ACAResultsStatusez."Grad. Status Msg 4")
                {
                }
                column(Messages5; ACAResultsStatusez."Grad. Status Msg 5")
                {
                }
                column(Messages6; ACAResultsStatusez."Grad. Status Msg 6")
                {
                }
                column(RubAcadYear; RubAcadYear)
                {
                }
                column(RubNumberText; RubNumberText)
                {
                }
                column(Schoolz; Schoolz)
                {
                }
                column(YearText2; YearText2)
                {
                }
                column(AcadYear; SenateHeaders."Academic Year")
                {
                }
                column(SchCode; SenateHeaders."School Code")
                {
                }
                column(ClassificationCode; SenateHeaders."Classification Code")
                {
                }
                column(ProgCode; SenateHeaders."Programme Code")
                {
                }
                column(DeptCode; SenateHeaders."Department Code")
                {
                }
                column(SchPerc_Passed; SenateHeaders."School % Passed")
                {
                }
                column(SchPerc_Failed; SenateHeaders."School % Failed")
                {
                }
                column(ClassCaption; SenateHeaders."Calss Caption")
                {
                }
                column(ProgPerc_Passed; SenateHeaders."Programme % Passed")
                {
                }
                column(ProgPerc_Failed; SenateHeaders."Programme % Failed")
                {
                }
                column(ProgClassPerc_Value; SenateHeaders."Prog. Class % Value")
                {
                }
                column(SchClassPerc_Value; SenateHeaders."Sch. Class % Value")
                {
                }
                column(SummaryPageCaption; SenateHeaders."Summary Page Caption")
                {
                }
                column(INCLUDEfailedUnitsHeader; SenateHeaders."Include Failed Units Headers")
                {
                }
                column(RubricOrder; SenateHeaders."Rubric Order")
                {
                }
                column(SchClassCount; SenateHeaders."School Classification Count")
                {
                }
                column(SchClassCountText; ConvertDecimalToText.InitiateConvertion(SenateHeaders."School Classification Count"))
                {
                }
                column(SchTotPassed; SenateHeaders."School Total Passed")
                {
                }
                column(SchTotFailed; SenateHeaders."School Total Failed")
                {
                }
                column(ProgClassCount; SenateHeaders."Programme Classification Count")
                {
                }
                column(ProgTotPassed; SenateHeaders."Programme Total Passed")
                {
                }
                column(ProgTotFailed; SenateHeaders."Programme Total Failed")
                {
                }
                column(SchTotal; SenateHeaders."School Total Count")
                {
                }
                column(ProgTotal; SenateHeaders."Prog. Total Count")
                {
                }
                column(IncludeYear; SenateHeaders."Include Academic Year Caption")
                {
                }
                column(YearText; SenateHeaders."Academic Year Text")
                {
                }
                column(IncludeVar1; SenateHeaders."IncludeVariable 1")
                {
                }
                column(Var1; SenateHeaders."Status Msg1")
                {
                }
                column(IncludeVar2; SenateHeaders."IncludeVariable 2")
                {
                }
                column(Var2; SenateHeaders."Status Msg2")
                {
                }
                column(IncludeVar3; SenateHeaders."IncludeVariable 3")
                {
                }
                column(Var3; SenateHeaders."Status Msg3")
                {
                }
                column(IncludeVar4; SenateHeaders."IncludeVariable 4")
                {
                }
                column(Var4; Var4s)
                {
                }
                column(IncludeVar5; SenateHeaders."IncludeVariable 5")
                {
                }
                column(Var5; Var5s)
                {
                }
                column(IncludeVar6; SenateHeaders."IncludeVariable 6")
                {
                }
                column(Var6; '')
                {
                }
                column(StudentNo; ExamsCoreg."Student Number")
                {
                }
                column(YoS; ExamsCoreg."Year of Study")
                {
                }
                column(StudentName; ExamsCoreg."Student Name")
                {
                }
                column(SnchName; ExamsCoreg."School Name")
                {
                }
                column(Classification; ExamsCoreg.Classification)
                {
                }
                column(FinalClassPass; ExamsCoreg."Final Classification Pass")
                {
                }
                column(Graduating; ExamsCoreg.Graduating)
                {
                }
                column(ProgOptName; ExamsCoreg."Prog. Option Name")
                {
                }
                dataitem(ResitUnits; "ACA-Exam Classification Units")
                {
                    DataItemLink = "Student No." = FIELD("Student Number"), "Academic Year" = FIELD("Academic Year");
                    DataItemTableView = WHERE(Pass = FILTER(false));
                    column(UnitCode; ResitUnits."Unit Code")
                    {
                    }
                    column(UnitDescription; ResitUnits."Unit Description")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(CourseCat);
                    Clear(Schoolz);
                    Clear(YearText2);
                    Clear(FinalTexts);
                    Clear(ShowRate);
                    Schoolz := ExamsCoreg."School Name";
                    YearText2 := YoSText;
                    if ExamsCoreg."Programme Option" <> '' then begin
                        if ExamsCoreg."Prog. Option Name" = '' then
                            ExamsCoreg."Prog. Option Name" := ExamsCoreg."Programme Option" + ' Option'
                        else
                            ExamsCoreg."Prog. Option Name" := ExamsCoreg."Prog. Option Name" + ' Option';
                    end;


                    // // // // IF ((SchCode<>ExamsCoreg."School Code") AND (AcadCode<>ExamsCoreg."Academic Year") AND
                    // // // //   (YosCode<>ExamsCoreg."Year of Study") AND (RubsCode<>ExamsCoreg.Classification)) THEN
                    // // // //   BEGIN
                    // // // //   seq:=1;
                    // // // //   SchCode:=ExamsCoreg."School Code";
                    // // // //   AcadCode:=ExamsCoreg."Academic Year";
                    // // // //   YosCode:=ExamsCoreg."Year of Study";
                    // // // //   RubsCode:=ExamsCoreg.Classification;
                    // // // //   END ELSE seq:=seq+1;
                    ACAProgramme.Reset;
                    ACAProgramme.SetRange(Code, ExamsCoreg.Programme);
                    if ACAProgramme.Find('-') then begin
                        if ((ACAProgramme.Category = ACAProgramme.Category::Certificate) or
                           (ACAProgramme.Category = ACAProgramme.Category::"Course List") or
                           (ACAProgramme.Category = ACAProgramme.Category::Professional)) then
                            CourseCat := 'CERTIFICATE';

                    end;


                    ACAResultsStatusez.Reset;
                    ACAResultsStatusez.SetRange(Code, SenateHeaders."Classification Code");
                    ACAResultsStatusez.SetRange(ACAResultsStatusez."Special Programme Class", ACAProgramme."Special Programme Class");
                    ACAResultsStatusez.SetRange(ACAResultsStatusez."Academic Year", SenateHeaders."Academic Year");
                    if ACAResultsStatusez.Find('-') then begin

                        if ((ACAResultsStatusez."Grad. Status Msg 4" = '') or (ACAResultsStatusez."Grad. Status Msg 5" = '') or
                           (ACAResultsStatusez."Grad. Status Msg 5" = '')) then
                            YearText2 := '';
                        if ExamsCoreg."Year of Study" = 1 then begin
                            FinalTexts := ACAResultsStatusez."1st Year Grad. Comments";
                        end else
                            if ExamsCoreg."Year of Study" = 2 then begin
                                FinalTexts := ACAResultsStatusez."2nd Year Grad. Comments";
                            end else
                                if ExamsCoreg."Year of Study" = 3 then begin
                                    FinalTexts := ACAResultsStatusez."3rd Year Grad. Comments";
                                end else
                                    if ExamsCoreg."Year of Study" = 4 then begin
                                        FinalTexts := ACAResultsStatusez."4th Year Grad. Comments";
                                    end else
                                        if ExamsCoreg."Year of Study" = 5 then begin
                                            FinalTexts := ACAResultsStatusez."5th Year Grad. Comments";
                                        end else
                                            if ExamsCoreg."Year of Study" = 6 then begin
                                                FinalTexts := ACAResultsStatusez."6th Year Grad. Comments";
                                            end else
                                                if ExamsCoreg."Year of Study" = 7 then begin
                                                    FinalTexts := ACAResultsStatusez."7th Year Grad. Comments";
                                                end;

                        if ((ExamsCoreg."Final Year of Study") = (ExamsCoreg."Year of Study")) then begin
                            if ((ACAProgramme.Category = ACAProgramme.Category::Certificate) or
                              (ACAProgramme.Category = ACAProgramme.Category::"Course List") or
                              (ACAProgramme.Category = ACAProgramme.Category::Professional)) then begin
                                FinalTexts := ACAResultsStatusez."Finalists Grad. Comm. Cert.";
                            end else
                                if ((ACAProgramme.Category = ACAProgramme.Category::Diploma)) then begin
                                    FinalTexts := ACAResultsStatusez."Finalists Grad. Comm. Dip";
                                end else
                                    if ((ACAProgramme.Category = ACAProgramme.Category::Undergraduate) or
                           (ACAProgramme.Category = ACAProgramme.Category::Postgraduate)) then begin
                                        FinalTexts := ACAResultsStatusez."Finalists Grad. Comm. Degree";
                                    end;
                            ShowRate := true;
                        end;

                        if ACAResultsStatusez."Grad. Status Msg 6" = '' then begin
                            Schoolz := '';
                            FinalTexts := '';
                        end;
                        if ACAResultsStatusez."Grad. Status Msg 4" = '' then begin
                            Schoolz := '';
                            FinalTexts := '';
                        end;
                        if ACAResultsStatusez."Grad. Status Msg 5" = '' then begin
                            Schoolz := '';
                            FinalTexts := '';
                        end;
                    end;
                    Clear(NextYearofStudy);
                    Clear(Var4s);
                    Clear(Var5s);
                    if ExamsCoreg."Final Year of Study" = ExamsCoreg."Year of Study" then begin
                        finalists := true;
                        Var4s := 'Examinations for the degree in their repective Programs. They are recommended to GRADUATE';
                    end else begin
                        finalists := false;
                        if ExamsCoreg."Year of Study" = 1 then
                            NextYearofStudy := ' their SECOND (2) year of Study'
                        else
                            if ExamsCoreg."Year of Study" = 2 then
                                NextYearofStudy := ' their THIRD (3) year of Study'
                            else
                                if ExamsCoreg."Year of Study" = 3 then
                                    NextYearofStudy := ' their FOURTH (4) year of Study'
                                else
                                    if ExamsCoreg."Year of Study" = 4 then
                                        NextYearofStudy := ' their FIFTH (5) year of Study'
                                    else
                                        if ExamsCoreg."Year of Study" = 5 then
                                            NextYearofStudy := ' their SIXTH (6) year of Study'
                                        else
                                            if ExamsCoreg."Year of Study" = 6 then NextYearofStudy := ' their SEVENTH (7) year of Study';
                        Var4s := 'Examinations for the degree in their repective Programs. They are recommended to proceed to ' + NextYearofStudy;
                    end;
                    //ExamsCoreg."Student Name":=FormatNames(ExamsCoreg."Student Name");
                end;
            }

            trigger OnAfterGetRecord()
            var
                ACAExamCourseRegistration: Record "ACA-Exam. Course Registration";
                seq: Integer;
            begin
                CalcFields(Prog_AcadYearTrans_Count, Prog_AcadYear_Count, Prog_AcadYear_Status_Count,
                ProgCat_AcadYear_BarcCo, ProgCat_AcadYear_Status_BarcCo,
                ProgCat_AcadYearTrans_BarcCo, ProgCat_AcadYear_MasCo,
                ProgCat_AcadYear_Status_MasCo, ProgCat_AcadYearTrans_MascCo,
                ProgCat_AcadYear_DipCo, ProgCat_AcadYear_Status_DipCo,
                ProgCat_AcadYearTrans_DipCo, ProgCat_AcadYear_CertCo,
                ProgCat_AcadYear_Status_CertCo, ProgCat_AcadYearTrans_CertCo);
                Clear(ProgFilter);
                if (SenateHeaders.GetFilter("Programme Code")) <> '' then begin
                    ACAProgramme.Reset;
                    ACAProgramme.SetRange(Code, SenateHeaders.GetFilter("Programme Code"));
                    if ACAProgramme.Find('-') then ProgFilter := ACAProgramme.Description;
                end;

                Clear(seq);
                Clear(TransRate);
                Clear(RubAcadYear);
                Clear(RubNumberText);
                RubAcadYear := SenateHeaders."Academic Year";
                if (SenateHeaders.GetFilter("Programme Code")) <> '' then
                    SenateHeaders."School Classification Count" := SenateHeaders."Programme Classification Count";
                RubNumberText := ConvertDecimalToText.InitiateConvertion(SenateHeaders."School Classification Count");

                ACAExamCourseRegistration.Reset;
                ACAExamCourseRegistration.SetRange("Academic Year", SenateHeaders."Academic Year");
                ACAExamCourseRegistration.SetRange("Year of Study", SenateHeaders."Year of Study");
                ACAExamCourseRegistration.SetRange("School Code", SenateHeaders."School Code");
                ACAExamCourseRegistration.SetRange(Classification, SenateHeaders."Classification Code");
                if (SenateHeaders.GetFilter("Programme Code")) <> '' then
                    ACAExamCourseRegistration.SetRange(Programme, SenateHeaders.GetFilter("Programme Code"));
                ACAExamCourseRegistration.SetCurrentKey(Programme, "Programme Option", "Student Number", "Category Order");
                if ACAExamCourseRegistration.Find('-') then begin
                    repeat
                    begin
                        seq += 1;
                        ACAExamCourseRegistration."Rubric Number" := seq;
                        ACAExamCourseRegistration.Modify;
                    end;
                    until ACAExamCourseRegistration.Next = 0;
                end;
                Clear(YoSText);
                if SenateHeaders."Year of Study" = 1 then YoSText := 'FIRST';
                if SenateHeaders."Year of Study" = 2 then YoSText := 'SECOND';
                if SenateHeaders."Year of Study" = 3 then YoSText := 'THIRD';
                if SenateHeaders."Year of Study" = 4 then YoSText := 'FOURTH';
                if SenateHeaders."Year of Study" = 5 then YoSText := 'FIFTH';
                if SenateHeaders."Year of Study" = 6 then YoSText := 'SIXTH';
                if SenateHeaders."Year of Study" = 7 then YoSText := 'SEVENTH';
                Clear(StatusPercentage);
                Clear(StatusPercentageBarchelors);
                Clear(StatusPercentageMasters);
                Clear(StatusPercentageDiploma);
                Clear(StatusPercentageCert);
                Clear(ShowRateBarch);
                Clear(ShowRateCertificate);
                Clear(ShowRateDiploma);
                Clear(ShowRateMasters);

                if (SenateHeaders.GetFilter("Programme Code")) <> '' then begin
                    // General
                    if SenateHeaders.Prog_AcadYear_Count <> 0 then begin
                        StatusPercentage := Round((SenateHeaders.Prog_AcadYear_Status_Count / SenateHeaders.Prog_AcadYear_Count) * 100, 0.01, '<');
                        TransRate := Round((SenateHeaders.Prog_AcadYearTrans_Count / SenateHeaders.Prog_AcadYear_Count) * 100, 0.01, '<');
                    end;
                    SenateHeaders.School_AcadYear_Count := SenateHeaders.Prog_AcadYear_Count;
                    SenateHeaders.School_AcadYear_Status_Count := SenateHeaders.Prog_AcadYear_Status_Count;
                    SenateHeaders.School_AcadYear_Count := SenateHeaders.Prog_AcadYear_Count;
                    SenateHeaders.School_AcadYearTrans_Count := SenateHeaders.Prog_AcadYearTrans_Count;
                    // Barchelors
                    if SenateHeaders.ProgCat_AcadYear_BarcCo <> 0 then begin
                        StatusPercentageBarchelors := Round((SenateHeaders.ProgCat_AcadYear_Status_BarcCo / SenateHeaders.ProgCat_AcadYear_BarcCo) * 100, 0.01, '<');
                        TransRateBarch := Round((SenateHeaders.ProgCat_AcadYearTrans_BarcCo / SenateHeaders.ProgCat_AcadYear_BarcCo) * 100, 0.01, '<');
                        ShowRateBarch := true;
                    end;
                    SenateHeaders.SchCat_AcadYear_BarcCo := SenateHeaders.ProgCat_AcadYear_BarcCo;
                    SenateHeaders.SchCat_AcadYear_Status_BarcCo := SenateHeaders.ProgCat_AcadYear_Status_BarcCo;
                    SenateHeaders.SchCat_AcadYear_BarcCo := SenateHeaders.ProgCat_AcadYear_BarcCo;
                    SenateHeaders.SchCat_AcadYearTrans_BarcCo := SenateHeaders.ProgCat_AcadYearTrans_BarcCo;
                    // Masters
                    if SenateHeaders.ProgCat_AcadYear_MasCo <> 0 then begin
                        StatusPercentageMasters := Round((SenateHeaders.ProgCat_AcadYear_Status_MasCo / SenateHeaders.ProgCat_AcadYear_MasCo) * 100, 0.01, '<');
                        TransRateMasters := Round((SenateHeaders.ProgCat_AcadYearTrans_MascCo / SenateHeaders.ProgCat_AcadYear_MasCo) * 100, 0.01, '<');
                        ShowRateMasters := true;
                    end;
                    SenateHeaders.SchCat_AcadYear_MasCo := SenateHeaders.ProgCat_AcadYear_MasCo;
                    SenateHeaders.SchCat_AcadYear_Status_MasCo := SenateHeaders.ProgCat_AcadYear_Status_MasCo;
                    SenateHeaders.SchCat_AcadYear_MasCo := SenateHeaders.ProgCat_AcadYear_MasCo;
                    SenateHeaders.SchCat_AcadYearTrans_MascCo := SenateHeaders.ProgCat_AcadYearTrans_MascCo;
                    // Diploma
                    if SenateHeaders.ProgCat_AcadYear_DipCo <> 0 then begin
                        StatusPercentageDiploma := Round((SenateHeaders.ProgCat_AcadYear_Status_DipCo / SenateHeaders.ProgCat_AcadYear_DipCo) * 100, 0.01, '<');
                        TransRateDiploma := Round((SenateHeaders.ProgCat_AcadYearTrans_DipCo / SenateHeaders.ProgCat_AcadYear_DipCo) * 100, 0.01, '<');
                        ShowRateDiploma := true;
                    end;
                    SenateHeaders.SchCat_AcadYear_DipCo := SenateHeaders.ProgCat_AcadYear_DipCo;
                    SenateHeaders.SchCat_AcadYear_Status_DipCo := SenateHeaders.ProgCat_AcadYear_Status_DipCo;
                    SenateHeaders.SchCat_AcadYear_DipCo := SenateHeaders.ProgCat_AcadYear_DipCo;
                    SenateHeaders.SchCat_AcadYearTrans_DipCo := SenateHeaders.ProgCat_AcadYearTrans_DipCo;
                    // Certificate
                    if SenateHeaders.ProgCat_AcadYear_CertCo <> 0 then begin
                        StatusPercentageCert := Round((SenateHeaders.ProgCat_AcadYear_Status_CertCo / SenateHeaders.ProgCat_AcadYear_CertCo) * 100, 0.01, '<');
                        TransRateCertificate := Round((SenateHeaders.ProgCat_AcadYearTrans_CertCo / SenateHeaders.ProgCat_AcadYear_CertCo) * 100, 0.01, '<');
                        ShowRateCertificate := true;
                    end;
                    SenateHeaders.SchCat_AcadYear_CertCo := SenateHeaders.ProgCat_AcadYear_CertCo;
                    SenateHeaders.SchCat_AcadYear_Status_CertCo := SenateHeaders.ProgCat_AcadYear_Status_CertCo;
                    SenateHeaders.SchCat_AcadYear_CertCo := SenateHeaders.ProgCat_AcadYear_CertCo;
                    SenateHeaders.SchCat_AcadYearTrans_CertCo := SenateHeaders.ProgCat_AcadYearTrans_CertCo;
                end else begin
                    // General
                    if SenateHeaders.School_AcadYear_Count <> 0 then begin
                        StatusPercentage := Round((SenateHeaders.School_AcadYear_Status_Count / SenateHeaders.School_AcadYear_Count) * 100, 0.01, '<');
                        TransRate := Round((SenateHeaders.School_AcadYearTrans_Count / SenateHeaders.School_AcadYear_Count) * 100, 0.01, '<');
                    end;
                    // Barchelors
                    if SenateHeaders.SchCat_AcadYear_BarcCo <> 0 then begin
                        StatusPercentageBarchelors := Round((SenateHeaders.SchCat_AcadYear_Status_BarcCo / SenateHeaders.SchCat_AcadYear_BarcCo) * 100, 0.01, '<');
                        TransRateBarch := Round((SenateHeaders.SchCat_AcadYearTrans_BarcCo / SenateHeaders.SchCat_AcadYear_BarcCo) * 100, 0.01, '<');
                        ShowRateBarch := true;
                    end;
                    // Masters
                    if SenateHeaders.SchCat_AcadYear_MasCo <> 0 then begin
                        StatusPercentageMasters := Round((SenateHeaders.SchCat_AcadYear_Status_MasCo / SenateHeaders.SchCat_AcadYear_MasCo) * 100, 0.01, '<');
                        TransRateMasters := Round((SenateHeaders.SchCat_AcadYearTrans_MascCo / SenateHeaders.SchCat_AcadYear_MasCo) * 100, 0.01, '<');
                        ShowRateMasters := true;
                    end;
                    // Diploma
                    if SenateHeaders.SchCat_AcadYear_DipCo <> 0 then begin
                        StatusPercentageDiploma := Round((SenateHeaders.SchCat_AcadYear_Status_DipCo / SenateHeaders.SchCat_AcadYear_DipCo) * 100, 0.01, '<');
                        TransRateDiploma := Round((SenateHeaders.SchCat_AcadYearTrans_DipCo / SenateHeaders.SchCat_AcadYear_DipCo) * 100, 0.01, '<');
                        ShowRateDiploma := true;
                    end;
                    // Certificate
                    if SenateHeaders.SchCat_AcadYear_CertCo <> 0 then begin
                        StatusPercentageCert := Round((SenateHeaders.SchCat_AcadYear_Status_CertCo / SenateHeaders.SchCat_AcadYear_CertCo) * 100, 0.01, '<');
                        TransRateCertificate := Round((SenateHeaders.SchCat_AcadYearTrans_CertCo / SenateHeaders.SchCat_AcadYear_CertCo) * 100, 0.01, '<');
                        ShowRateCertificate := true;
                    end;
                end;
                Clear(SchCode);
            end;

            trigger OnPreDataItem()
            begin
                if SenateHeaders.GetFilter("Academic Year") = '' then Error('Specify the Academic Year filters');
                if SenateHeaders.GetFilter("School Code") = '' then Error('Specify a School Code filters');
                if SenateHeaders.GetFilter("Year of Study") = '' then Error('Specify the Year of Study filter');
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
        if CompanyInformation.Find('-') then CompanyInformation.CalcFields(Picture);
    end;

    var
        ProgFilter: Text[250];
        CompanyInformation: Record "Company Information";
        seq: Integer;
        ACAProgramme: Record "ACA-Programme";
        YoSText: Text[150];
        finalists: Boolean;
        ConvertDecimalToText: Codeunit "Convert Decimal To Text";
        Var4s: Text;
        Var5s: Text;
        NextYearofStudy: Text;
        CourseCat: Text[100];
        StatusPercentage: Decimal;
        SchCode: Code[20];
        AcadCode: Code[20];
        YosCode: Integer;
        RubsCode: Code[20];
        ACAResultsStatusez: Record "ACA-Results Status";
        RubAcadYear: Text[250];
        RubNumberText: Text[250];
        Schoolz: Text[250];
        YearText2: Text[250];
        FinalTexts: Text[250];
        TransRate: Decimal;
        ShowRate: Boolean;
        TransRateBarch: Decimal;
        ShowRateBarch: Boolean;
        TransRateMasters: Decimal;
        ShowRateMasters: Boolean;
        TransRateDiploma: Decimal;
        ShowRateDiploma: Boolean;
        TransRateCertificate: Decimal;
        ShowRateCertificate: Boolean;
        StatusPercentageBarchelors: Decimal;
        StatusPercentageMasters: Decimal;
        StatusPercentageDiploma: Decimal;
        StatusPercentageCert: Decimal;
        progOptions: Record "ACA-Programme Options";
}

