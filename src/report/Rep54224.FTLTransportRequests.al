report 54224 "FTL- Transport Requests"
{
    DefaultLayout = Word;
    WordLayout = './Transport/Report/SSR/54224.TransportRequests.docx';

    dataset
    {
        dataitem(TRequests; "FLT-Transport Requisition")
        {
            column(EmpNo_TRequests; "Emp No")
            {
            }
            column(EmployeeName_TRequests; "Employee Name")
            {
            }
            column(DepartmentCode_TRequests; "Department Code")
            {
            }
            column(DepartmentName_TRequests; "Department Name")
            {
            }
            column(Designation_TRequests; Designation)
            {
            }
            column(Destination_TRequests; Destination)
            {
            }
            column(PurposeofTrip_TRequests; "Purpose of Trip")
            {
            }
            column(DateofTrip_TRequests; format("Date of Trip"))
            {
            }
            column(Timeout_TRequests; "Time out")
            {
            }
            column(NoOfPassangers_TRequests; "No Of Passangers")
            {
            }
            column(NoofDaysRequested_TRequests; "No of Days Requested")
            {
            }
            column(VehicleAllocated_TRequests; "Vehicle Allocated")
            {
            }
            column(VehicleCapacity_TRequests; "Vehicle Capacity")
            {
            }
            column(RecommedthisRequest_TRequests; "Recommed this Request")
            {
            }
            column(RecommendationReason_TRequests; "Recommendation Reason")
            {
            }
            column(HODName_TRequests; "HOD Name")
            {
            }
            column(HODUserName_TRequests; "HOD UserName")
            {
            }
            column(MileageBeforeTrip_TRequests; "Mileage Before Trip")
            {
            }
            column(MilleageafterTrip_TRequests; "Milleage after Trip")
            {
            }
            column(TotalMileageTravelled_TRequests; "Total Mileage Travelled")
            {
            }
            column(TotalCost_TRequests; "Total Cost")
            {
            }
            column(CostPerKilometer_TRequests; "Cost Per Kilometer")
            {
            }
            column(DateofRequest_TRequests; format("Date of Request"))
            {
            }
            column(DurationtobeAway_TRequests; "Duration to be Away")
            {
            }
            column(ReturnDate_TRequests; format("Return Date"))
            {
            }
            column(DriverAllocated_TRequests; "Driver Allocated")
            {
            }
            column(DriverName_TRequests; "Driver Name")
            {
            }
            column(complogo; info.Picture)
            {

            }
            column(compName; info.Name)
            {

            }
            column(TransportOfficerName_TRequests; "Transport Officer Name")
            {
            }
            column(TransportRequisitionNo_TRequests; "Transport Requisition No")
            {
            }
            column(TimeIn_TRequests; format("Time In"))
            {
            }
            column(ApprovedRequest_TRequests; "Approved Request ?")
            {
            }
            column(AdminHeadName_TRequests; "Admin Head Name")
            {
            }
            column(AdminHeadUsername_TRequests; "Admin Head Username")
            {
            }
            column(HeadofDepartment_TRequests; "Head of Department")
            {
            }
            column(TransportOfficer_TRequests; "Transport Officer")
            {
            }
            column(RegistrarHRM_TRequests; "Registrar HRM")
            {
            }
            column(Timeoftrip_TRequests; format("Time of trip"))
            {
            }
            column(TransportAvailability_TRequests; "Transport Availability.")
            {
            }
            column(HODApprovedDate_TRequests; format("HOD Approved Date"))
            {
            }
            column(TRApprovedDate_TRequests; format("TR Approved Date"))
            {
            }
            column(AdminApprovedDate_TRequests; format("Admin Approved Date"))
            {
            }
            column(RequestorSign; usersetup1."User Signature")
            {

            }
            column(HODSign; usersetup2."User Signature")
            {

            }
            column(TRSign; usersetup3."User Signature")
            {

            }
            column(AdminSign; usersetup4."User Signature")
            {

            }
            column(compAddress; info.Address)
            {

            }
            column(CompEmail; info."E-Mail")
            {

            }
            column(CompUrl; info."Home Page")
            {

            }

            trigger OnAfterGetRecord()
            begin
                info.get;
                info.CalcFields(Picture);
                if TRequests."Requested By" <> '' then begin
                    usersetup1.get("Requested By");
                    usersetup1.CalcFields("User Signature");
                end;

                if TRequests."Head of Department" <> '' then begin
                    usersetup2.get("Head of Department");
                    usersetup2.CalcFields("User Signature");
                end;

                if TRequests."Transport Officer" <> '' then begin
                    usersetup3.get("Transport Officer");
                    usersetup3.CalcFields("User Signature");
                end;

                if TRequests."Admin Head Username" <> '' then begin

                    usersetup4.get("Admin Head Username");
                    usersetup4.CalcFields("User Signature");
                end;
            end;
        }
    }

    var
        info: Record "Company Information";

        usersetup1: Record "User Setup";
        usersetup2: Record "User Setup";
        usersetup3: Record "User Setup";
        usersetup4: Record "User Setup";



}