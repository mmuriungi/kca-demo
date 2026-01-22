Report 50702 "Clinic Diagnosis Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClinicDiagnosis.rdl';

    dataset
    {
        dataitem(LBTreat; "HMS-Treatment Form Header")
        {
            RequestFilterFields = "Treatment Date", "Treatment No.";
            column(TreatmentNo_LBTreat; "Treatment No.")
            {
            }
            column(TreatmentType_LBTreat; "Treatment Type")
            {
            }
            column(TreatmentDate_LBTreat; format("Treatment Date"))
            {
            }
            column(TreatmentTime_LBTreat; format("Treatment Time"))
            {
            }
            column(DoctorID_LBTreat; "Doctor ID")
            {
            }
            column(PatientNo_LBTreat; "Patient No.")
            {
            }
            column(StudentNo_LBTreat; "Student No.")
            {
            }
            column(EmployeeNo_LBTreat; "Employee No.")
            {
            }
            column(TreatmentRemarks_LBTreat; "Treatment Remarks")
            {
            }
            column(PatientName_LBTreat; "Patient Name")
            {
            }
            column(logo; info.Picture)
            {

            }
            column(CompName; info.Name)
            {

            }
            column(CompAddress; info.Address)
            {

            }
            column(CompMail; info."E-Mail")
            {

            }
            column(compUrl; info."Home Page")
            {

            }
            dataitem(lst; "HMS-Treatment Form Diagnosis")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");

                column(DiagnosisNo_lst; "Diagnosis No.")
                {
                }
                column(DiagnosisName_lst; "Diagnosis Name")
                {
                }
                column(Confirmed_lst; Confirmed)
                {
                }
                column(Remarks_lst; Remarks)
                {
                }
                column(TreatmentDate_lst; format("Treatment Date"))
                {
                }
                column(PatientNo_lst; "Patient No")
                {
                }
                column(Gender_lst; Gender)
                {
                }
                column(PatientName_lst; "Patient Name")
                {
                }
            }


            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin

            end;
        }

    }

    var
        info: Record "Company Information";
}