report 52122 "FLT-Mileage Claim Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FLT-Mileage Claim Form.rdl';
    Caption = 'Transport Mileage Claim Form';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "FLT-Mileage Claim Header")
        {
            column(No_; "No.")
            {
            }
            column(Date_; "Date")
            {
            }
            column(EmployeeNo_; "Employee No.")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            column(Designation; Designation)
            {
            }
            column(PhoneNumber; "Phone Number")
            {
            }
            column(TotalEstimatedMileage; "Total Estimated Mileage")
            {
            }
            column(TotalEstimatedCost; "Total Estimated Cost")
            {
            }
            column(ApprovedRatePerKm; "Approved Rate Per Km")
            {
            }
            column(TransportOfficer; "Transport Officer")
            {
            }
            column(TransportOfficerDate; "Transport Officer Date")
            {
            }
            column(ApproverName; "Approver Name")
            {
            }
            column(ApprovedDate; "Approved Date")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Status; Status)
            {
            }
            column(ApprovalStage; "Approval Stage")
            {
            }
            column(RequestedBy; "Requested By")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(ReportTitle; 'TRANSPORT MILEAGE CLAIM FORM')
            {
            }
            
            dataitem(Lines; "FLT-Mileage Claim Lines")
            {
                DataItemLink = "Mileage Claim No." = field("No.");
                column(LineNo_; "Line No.")
                {
                }
                column(TravelDate; "Travel Date")
                {
                }
                column(VehicleRegistrationNo_; "Vehicle Registration No.")
                {
                }
                column(VehicleMake; "Vehicle Make")
                {
                }
                column(VehicleModel; "Vehicle Model")
                {
                }
                column(EngineCapacity; "Engine Capacity")
                {
                }
                column(StartingPoint; "Starting Point")
                {
                }
                column(Destination; Destination)
                {
                }
                column(PurposeofTrip; "Purpose of Trip")
                {
                }
                column(NumberofPassengers; "Number of Passengers")
                {
                }
                column(DistanceKM_; "Distance (KM)")
                {
                }
                column(RatePerKM; "Rate Per KM")
                {
                }
                column(TotalCost; "Total Cost")
                {
                }
                column(DepartureTime; "Departure Time")
                {
                }
                column(ReturnDate; "Return Date")
                {
                }
                column(ReturnTime; "Return Time")
                {
                }
                column(StartingOdometerReading; "Starting Odometer Reading")
                {
                }
                column(EndingOdometerReading; "Ending Odometer Reading")
                {
                }
                column(ActualDistanceKM_; "Actual Distance (KM)")
                {
                }
                column(ActualTotalCost; "Actual Total Cost")
                {
                }
                column(FuelReceiptsAttached; "Fuel Receipts Attached")
                {
                }
                column(MaintenanceReceiptsAttached; "Maintenance Receipts Attached")
                {
                }
                column(TransportOfficerRemarks; "Transport Officer Remarks")
                {
                }
                column(LineStatus; Status)
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowCompanyLogo; ShowCompanyLogo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Company Logo';
                        ToolTip = 'Specifies if the company logo should be shown on the report.';
                    }
                    field(ShowLineDetails; ShowLineDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Line Details';
                        ToolTip = 'Specifies if detailed line information should be shown on the report.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        ShowCompanyLogo: Boolean;
        ShowLineDetails: Boolean;
}