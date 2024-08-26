Report 50700 "Laboratory Requests Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LaboratoryRequests.rdl';

    dataset
    {
        dataitem(LBTreat; "HMS-Treatment Form Header")
        {
            DataItemTableView = where("sent to lab" = filter(true));
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

            dataitem(lst; "HMS-Treatment Form Laboratory")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");

                column(LaboratoryTestPackageCode_lst; "Laboratory Test Package Code")
                {
                }
                column(LaboratoryTestPackageName_lst; "Laboratory Test Package Name")
                {
                }
                column(DateDue_lst; format("Date Due"))
                {
                }
                column(Results_lst; Results)
                {
                }
                column(Status_lst; Status)
                {
                }
                column(Diagnosis_lst; Diagnosis)
                {
                }
                column(TreatmentNo_lst; "Treatment No.")
                {
                }
                column(Specimen_lst; Specimen)
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