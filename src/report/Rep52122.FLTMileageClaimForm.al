report 52122 "FLT-Mileage Claim Form"
{
    DefaultLayout = Word;
    //RDLCLayout = './Layouts/FLT-Mileage Claim Form.rdl';
    WordLayout = './Layouts/FLT-Mileage Claim Form.docx';
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
            column(TransportOfficerSignature; UserSetup."User Signature")
            {
            }
            column(ApproverSignature; UserSetup2."User Signature")
            {
            }
            column(TransportOfficerName; UserSetup.UserName)
            {
            }
            column(ApproversName; UserSetup2.UserName)
            {
            }
            column(TransportOfficersDate; TransportOfficerDate)
            {
            }
            column(ApproverDate; ApproverDate)
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
            trigger OnAfterGetRecord()
            begin
                ShowCompanyLogo := true;
                ShowLineDetails := true;
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Table ID", DATABASE::"FLT-Mileage Claim Header");
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", Header."No.");
                ApprovalEntry.SetRange("Sequence No.", 1);
                if ApprovalEntry.FindFirst() then begin
                    if UserSetup.Get(ApprovalEntry."Approver ID") then begin
                        UserSetup.CalcFields(UserSetup."User Signature");
                    end;
                    TransportOfficerDate := ApprovalEntry."Last Date-Time Modified";
                end;
                ApprovalEntry.Reset();
                ApprovalEntry.SetRange(ApprovalEntry."Table ID", DATABASE::"FLT-Mileage Claim Header");
                ApprovalEntry.SetRange(ApprovalEntry."Document No.", Header."No.");
                ApprovalEntry.SetRange("Sequence No.", 2);
                if ApprovalEntry.FindFirst() then begin
                    if UserSetup.Get(ApprovalEntry."Approver ID") then begin
                        UserSetup.CalcFields(UserSetup."User Signature");
                        ApproverDate := ApprovalEntry."Last Date-Time Modified";
                    end;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                // group(Options)
                // {
                //     Caption = 'Options';
                //     field(ShowCompanyLogo; ShowCompanyLogo)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Show Company Logo';
                //         ToolTip = 'Specifies if the company logo should be shown on the report.';
                //     }
                //     field(ShowLineDetails; ShowLineDetails)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Show Line Details';
                //         ToolTip = 'Specifies if detailed line information should be shown on the report.';
                //     }
                // }
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
        ApprovalEntry: Record "Approval Entry";
        UserSetup: Record "User Setup";
        UserSetup2: Record "User Setup";
        TransportOfficerDate: DateTime;
        ApproverDate: DateTime;
}