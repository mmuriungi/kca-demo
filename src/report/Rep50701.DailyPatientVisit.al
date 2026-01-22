report 50701 "Daily Patient Visit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/DailyClinicRequests.rdl';
    dataset
    {
        dataitem(DVisit; "HMS-Observation Form Header")
        {
            RequestFilterFields = "Observation Date", "Observation Type";
            column(ObservationNo_DVisit; "Observation No.")
            {
            }
            column(Status_DVisit; Status)
            {
            }
            column(ObservationType_DVisit; "Observation Type")
            {
            }
            column(ObservationDate_DVisit; format("Observation Date"))
            {
            }
            column(ObservationTime_DVisit; format("Observation Time"))
            {
            }
            column(PatientNo_DVisit; "Patient No.")
            {
            }
            column(PatientName_DVisit; "Patient Name")
            {
            }
            column(StudentNo_DVisit; "Student No.")
            {
            }
            column(EmployeeNo_DVisit; "Employee No.")
            {
            }
            column(ObservationRemarks_DVisit; "Observation Remarks")
            {
            }
            column(ObservationUserID_DVisit; "Observation User ID")
            {
            }
            column(RelativeNo_DVisit; "Relative No.")
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
            column(CompEmail; info."E-Mail")
            {
            }
            column(CompUrl; info."Home Page")
            {

            }

            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);
            end;
        }
    }

    var
        info: Record "Company Information";
}