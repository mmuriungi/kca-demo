report 52151 "Aca-Senate Report (Final)"
{
    ApplicationArea = All;
    Caption = 'Aca-Senate Report (Final)';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Final SenateReport.rdl';
    dataset
    {
        dataitem(ACASenateReportsHeader; "ACA-Senate Reports Header")
        {
            DataItemTableView = SORTING("Programme Code", "Academic Year", "Year of Study") ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Academic Year", "School Code", "Year of Study", "Programme Code";
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
            column(FirstYearGradComments; ACASenateReportsHeader."1st Year Grad. Comments")
            {
            }
            column(SecondYearGradComments; "2nd Year Grad. Comments")
            {
            }
            column(ThirdYearGradComments; "3rd Year Grad. Comments")
            {
            }
            column(FourthYearGradComments; "4th Year Grad. Comments")
            {
            }
            column(FifthYearGradComments; "5th Year Grad. Comments")
            {
            }
            column(SixthYearGradComments; "6th Year Grad. Comments")
            {
            }
            column(SeventhYearGradComments; "7th Year Grad. Comments")
            {
            }
            column(AcademicYear; "Academic Year")
            {
            }
            column(AcademicYearText; "Academic Year Text")
            {
            }
            column(CalssCaption; "Calss Caption")
            {
            }
            column(Category; Category)
            {
            }
            column(ClassificationCode; "Classification Code")
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            column(FinalistsGraduationComments; "Finalists Graduation Comments")
            {
            }
            column(GradStatusMsg1; "Grad. Status Msg 1")
            {
            }
            column(GradStatusMsg2; "Grad. Status Msg 2")
            {
            }
            column(GradStatusMsg3; "Grad. Status Msg 3")
            {
            }
            column(GradStatusMsg4; "Grad. Status Msg 4")
            {
            }
            column(GradStatusMsg5; "Grad. Status Msg 5")
            {
            }
            column(GradStatusMsg6; "Grad. Status Msg 6")
            {
            }
            column(IncludeAcademicYearCaption; "Include Academic Year Caption")
            {
            }
            column(IncludeFailedUnitsHeaders; "Include Failed Units Headers")
            {
            }
            column(IncludeVariable1; "IncludeVariable 1")
            {
            }
            column(IncludeVariable2; "IncludeVariable 2")
            {
            }
            column(IncludeVariable3; "IncludeVariable 3")
            {
            }
            column(IncludeVariable4; "IncludeVariable 4")
            {
            }
            column(IncludeVariable5; "IncludeVariable 5")
            {
            }
            column(IncludeVariable6; "IncludeVariable 6")
            {
            }
            column(ProgClassValue; "Prog. Class % Value")
            {
            }
            column(ProgTotalCount; "Prog. Total Count")
            {
            }
            column(ProgCat_AcadYearTrans_BarcCo; ProgCat_AcadYearTrans_BarcCo)
            {
            }
            column(ProgCat_AcadYearTrans_CertCo; ProgCat_AcadYearTrans_CertCo)
            {
            }
            column(ProgCat_AcadYearTrans_DipCo; ProgCat_AcadYearTrans_DipCo)
            {
            }
            column(ProgCat_AcadYearTrans_MascCo; ProgCat_AcadYearTrans_MascCo)
            {
            }
            column(ProgCat_AcadYear_BarcCo; ProgCat_AcadYear_BarcCo)
            {
            }
            column(ProgCat_AcadYear_CertCo; ProgCat_AcadYear_CertCo)
            {
            }
            column(ProgCat_AcadYear_DipCo; ProgCat_AcadYear_DipCo)
            {
            }
            column(ProgCat_AcadYear_MasCo; ProgCat_AcadYear_MasCo)
            {
            }
            column(ProgCat_AcadYear_Status_BarcCo; ProgCat_AcadYear_Status_BarcCo)
            {
            }
            column(ProgCat_AcadYear_Status_CertCo; ProgCat_AcadYear_Status_CertCo)
            {
            }
            column(ProgCat_AcadYear_Status_DipCo; ProgCat_AcadYear_Status_DipCo)
            {
            }
            column(ProgCat_AcadYear_Status_MasCo; ProgCat_AcadYear_Status_MasCo)
            {
            }
            column(Prog_AcadYearTrans_Count; Prog_AcadYearTrans_Count)
            {
            }
            column(Prog_AcadYear_Count; Prog_AcadYear_Count)
            {
            }
            column(Prog_AcadYear_Status_Count; Prog_AcadYear_Status_Count)
            {
            }
            column(ProgrammeFailed; "Programme % Failed")
            {
            }
            column(ProgrammePassed; "Programme % Passed")
            {
            }
            column(ProgrammeClassificationCount; "Programme Classification Count")
            {
            }
            column(ProgrammeCode; "Programme Code")
            {
            }
            column(ProgrammeTotalFailed; "Programme Total Failed")
            {
            }
            column(ProgrammeTotalPassed; "Programme Total Passed")
            {
            }
            column(ReportingAcademicYear; "Reporting Academic Year")
            {
            }
            column(RubricOrder; "Rubric Order")
            {
            }
            column(SchClassValue; "Sch. Class % Value")
            {
            }
            column(SchCat_AcadYearTrans_BarcCo; SchCat_AcadYearTrans_BarcCo)
            {
            }
            column(SchCat_AcadYearTrans_CertCo; SchCat_AcadYearTrans_CertCo)
            {
            }
            column(SchCat_AcadYearTrans_DipCo; SchCat_AcadYearTrans_DipCo)
            {
            }
            column(SchCat_AcadYearTrans_MascCo; SchCat_AcadYearTrans_MascCo)
            {
            }
            column(SchCat_AcadYear_BarcCo; SchCat_AcadYear_BarcCo)
            {
            }
            column(SchCat_AcadYear_CertCo; SchCat_AcadYear_CertCo)
            {
            }
            column(SchCat_AcadYear_DipCo; SchCat_AcadYear_DipCo)
            {
            }
            column(SchCat_AcadYear_MasCo; SchCat_AcadYear_MasCo)
            {
            }
            column(SchCat_AcadYear_Status_BarcCo; SchCat_AcadYear_Status_BarcCo)
            {
            }
            column(SchCat_AcadYear_Status_CertCo; SchCat_AcadYear_Status_CertCo)
            {
            }
            column(SchCat_AcadYear_Status_DipCo; SchCat_AcadYear_Status_DipCo)
            {
            }
            column(SchCat_AcadYear_Status_MasCo; SchCat_AcadYear_Status_MasCo)
            {
            }
            column(SchoolFailed; "School % Failed")
            {
            }
            column(SchoolPassed; "School % Passed")
            {
            }
            column(SchoolClassificationCount; "School Classification Count")
            {
            }
            column(SchoolCode; "School Code")
            {
            }
            column(SchoolTotalCount; "School Total Count")
            {
            }
            column(SchoolTotalFailed; "School Total Failed")
            {
            }
            column(SchoolTotalPassed; "School Total Passed")
            {
            }
            column(School_AcadYearTrans_Count; School_AcadYearTrans_Count)
            {
            }
            column(School_AcadYear_Count; School_AcadYear_Count)
            {
            }
            column(School_AcadYear_Status_Count; School_AcadYear_Status_Count)
            {
            }
            column(StatusMsg1; "Status Msg1")
            {
            }
            column(StatusMsg2; "Status Msg2")
            {
            }
            column(StatusMsg3; "Status Msg3")
            {
            }
            column(StatusMsg4; "Status Msg4")
            {
            }
            column(StatusMsg5; "Status Msg5")
            {
            }
            column(StatusMsg6; "Status Msg6")
            {
            }
            column(SummaryPageCaption; "Summary Page Caption")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(YearofStudy; "Year of Study")
            {
            }
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
