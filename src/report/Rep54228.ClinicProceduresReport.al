Report 54228 "Clinic Procedures Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClinicProcedures.rdl';

    dataset
    {
        dataitem(LBTreat; "HMS-Treatment Form Header")
        {

            RequestFilterFields = "Treatment Date";
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
            dataitem(lst; "HMS-Treatment Form Process")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");

                column(TreatmentNo_lst; "Treatment No.")
                {
                }
                column(ProcessNo_lst; "Process No.")
                {
                }
                column(ProcessName_lst; "Process Name")
                {
                }
                column(Mandatory_lst; Mandatory)
                {
                }
                column(ProcessRemarks_lst; "Process Remarks")
                {
                }
                column(Performed_lst; Performed)
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