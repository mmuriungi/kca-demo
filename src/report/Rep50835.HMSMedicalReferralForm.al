report 50835 "HMS Medical Referral Form"
{
    DefaultRenderingLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Medical Referral Form';

    dataset
    {
        dataitem("HMS-Referral Header"; "HMS-Referral Header")
        {
            RequestFilterFields = "Referral No.", "Treatment no.";

            column(ReferralNo; "Referral No.")
            {
            }
            column(TreatmentNo; "Treatment no.")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(DateReferred; "Date Referred")
            {
            }
            column(PFSTDNo; "PF/STD No.")
            {
            }
            column(ReferredHospital; "Referred Hospital")
            {
            }
            column(ClinicalHistory; "Clinical History")
            {
            }
            column(ExaminationFindings; "Examination Findings")
            {
            }
            column(InvestigationsDone; "Investigations Done")
            {
            }
            column(ProvisionalDiagnosis; "Provisional Diagnosis")
            {
            }
            column(PresentTreatment; "Present Treatment")
            {
            }
            column(Comments; Comments)
            {
            }
            column(OpinionAdvice; "Opinion/Advice")
            {
            }
            column(InvestigationSpecify; "Investigation (Specify)")
            {
            }
            column(FurtherManagement; "Further Management")
            {
            }
            column(ForReview; "For Review")
            {
            }
            column(CMOName; "CMO Name")
            {
            }
            column(CMOSignatureStamp; "CMO Signature/Stamp")
            {
            }
            column(CMODate; "CMO Date")
            {
            }
            column(ClinicalLabFindings; "Clinical Lab Findings")
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }
            column(FurtherInvestRequired; "Further Invest Required")
            {
            }
            column(TreatmentStarted; "Treatment Started")
            {
            }
            column(OtherRemarks; "Other Remarks")
            {
            }
            column(DoctorName; "Doctor Name")
            {
            }
            column(DoctorSign; "Doctor Sign")
            {
            }
            column(ReportDate; "Report Date")
            {
            }
            column(OfficialRubberStamp; "Official Rubber Stamp")
            {
            }
            column(ConsultantSpecialistName; "Consultant/Specialist Name")
            {
            }
            column(ConsultantPFNo; "Consultant PF No.")
            {
            }
            column(ConsultantSignature; "Consultant Signature")
            {
            }
            column(ConsultantDateStamp; "Consultant Date/Stamp")
            {
            }
            // Patient Info
            column(Surname; Surname)
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(IDNumber; "ID Number")
            {
            }
            column(CorrespondenceAddress1; "Correspondence Address 1")
            {
            }
            column(TelephoneNo1; "Telephone No. 1")
            {
            }
            column(Email; Email)
            {
            }
            // Company Info
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(UniversityTitle; CompanyInfo.Name)
            {
            }
            column(DepartmentTitle; 'Health Services Department')
            {
            }
            column(FormCode; 'HS/F006')
            {
            }
            column(FormTitle; 'MEDICAL REFERRAL FORM')
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Surname, "Middle Name", "Last Name");
                PatientName := Surname + ' ' + "Middle Name" + ' ' + "Last Name";
            end;
        }
    }

    rendering
    {
        layout(RDLC)
        {
            Type = RDLC;
            Caption = 'Medical Referral Form';
            Summary = 'Medical Referral Form Layout';
            LayoutFile = './Layouts/MedicalReferralForm.rdl';
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;



    var
        CompanyInfo: Record "Company Information";
        PatientName: Text[250];
}