// Report: Periodic Guest Register
report 50057 "Periodic Guest Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'GuestRegister.rdl';

    dataset
    {
        dataitem("Guest Registration"; "Guest Registration")
        {
            column(Entry_No_; "Entry No.")
            {
            }
            column(Visitor_Name; "Visitor Name")
            {
            }
            column(Reason_for_Visit; "Reason for Visit")
            {
            }
            column(Time_In; "Time In")
            {
            }
            column(Time_Out; "Time Out")
            {
            }
            column(Vehicle_Plate_Number; "Vehicle Plate Number")
            {
            }
            column(Is_Staff; "Is Staff")
            {
            }
        }
    }
}
