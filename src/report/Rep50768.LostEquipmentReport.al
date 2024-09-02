// Report: Lost Equipment Report
report 50768 "Lost Equipment Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'LostEquipmentReport.rdl';

    dataset
    {
        dataitem("Equipment Issuance"; "Equipment Issuance")
        {
            DataItemTableView = where(Status = const(Lost));

            column(Item_No_; "Item No.")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(User_Type; "User Type")
            {
            }
            column(Issue_Date; "Issue Date")
            {
            }
        }
    }
}
