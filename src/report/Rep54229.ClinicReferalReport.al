Report 54229 "Clinic Referal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClinicReferal.rdl';

    dataset
    {
        dataitem(LBTreat; "HMS-Treatment Form Header")
        {
            //RequestFilterFields = "Treatment Date";
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
            dataitem(refer; "HMS-Treatment Referral")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");

                column(HospitalNo_refer; "Hospital No.")
                {
                }
                column(HospitalName_refer; "Hospital Name")
                {
                }
                column(DateReferred_refer; format("Date Referred"))
                {
                }
                column(ReferralReason_refer; "Referral Reason")
                {
                }
                column(ReferralRemarks_refer; "Referral Remarks")
                {
                }
                column(PhoneNo_refer; "Phone No.")
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