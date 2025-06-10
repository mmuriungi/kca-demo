report 50827 "FuelRequest Form"
{
    ApplicationArea = All;
    Caption = 'FuelRequest Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout=RDLC;
    RDLCLayout='./Layouts/FuelRequestForm.rdl';
    dataset
    {
        dataitem(FLTFuelMaintenanceReq; "FLT-Fuel & Maintenance Req.")
        {
            column(CompName;CompanyInformation.Name)
            {
            }
            column(Address;CompanyInformation.Address+' ,'+CompanyInformation."Address 2"+' ,'+CompanyInformation.City)
            {
            }
            column(conts;CompanyInformation."Phone No."+' '+CompanyInformation."Phone No. 2")
            {
            }
            column(mails;CompanyInformation."E-Mail"+' '+CompanyInformation."Home Page")
            {
            }
            column(Logo;CompanyInformation.Picture)
            {
            }
            column(BatteryWater; "Battery Water")
            {
            }
            column(CarWash; "Car Wash")
            {
            }
            column(ClosedBy; "Closed By")
            {
            }
            column(Coolant; Coolant)
            {
            }
            column(DateClosed; "Date Closed")
            {
            }
            column(DateTakenforFueling; "Date Taken for Fueling")
            {
            }
            column(DateTakenforMaintenance; "Date Taken for Maintenance")
            {
            }
            column(DateofService; "Date of Service")
            {
            }
            column(Department; Department)
            {
            }
            column(Description; Description)
            {
            }
            column(Designation2; "Designation2 ")
            {
            }
            column(Driver; Driver)
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(FixedAssetNo; "Fixed Asset No")
            {
            }
            column(FuelFor; "Fuel For")
            {
            }
            column(LitresofOil; "Litres of Oil")
            {
            }
            column(MaintananceType; "Maintanance Type")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(OdometerReading; "Odometer Reading")
            {
            }
            column(PostedInvoiceNo; "Posted Invoice No")
            {
            }
            column(PreparedBy; "Prepared By")
            {
            }
            column(PriceLitre; "Price/Litre")
            {
            }
            column(QuantityofFuelLitres; "Quantity of Fuel(Litres)")
            {
            }
            column(QuoteNo; "Quote No")
            {
            }
            column(RequestDate; "Request Date")
            {
            }
            column(RequesterName; "Requester Name")
            {
            }
            column(Requestingofficer; "Requesting officer")
            {
            }
            column(RequisitionNo; "Requisition No")
            {
            }
            column(Status; Status)
            {
            }
            column(TimeFuelIsRequired; "Time Fuel Is Required")
            {
            }
            column(TotalPriceofFuel; "Total Price of Fuel")
            {
            }
            column(Type; "Type")
            {
            }
            column(TypeofFuel; "Type of Fuel")
            {
            }
            column(TypeofFuelRequisition; "Type of Fuel Requisition")
            {
            }
            column(TypeofMaintenance; "Type of Maintenance")
            {
            }
            column(VehicleRegNo; "Vehicle Reg No")
            {
            }
            column(VendorInvoiceNo; "Vendor Invoice No")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(VendorDealer; "Vendor(Dealer)")
            {
            }
            column(WheelAlignment; "Wheel Alignment")
            {
            }
            column(WheelBalancing; "Wheel Balancing")
            {
            }
            column(mileageatrequestofservices; "mileage at request of services")
            {
            }
            column(mileageatservice; "mileage at service")
            {
            }
            column(requesterContactnumber; "requester Contact number")
            {
            }
            column(UserSignature; UserSetup."User Signature")
            {
            }
            column(UserName; UserSetup.UserName)
            {
            }
            column(ApprovalDate; Approv."Last Date-Time Modified")
            {
            }
            column(ApproverID; Approv."Approver ID")
            {
            }
            trigger OnAfterGetRecord()  
            begin
                Approv.Reset();
                approv.SetRange("Document No.","Requisition No");
                Approv.SetRange("Table ID",Database::"FLT-Fuel & Maintenance Req.");
                Approv.SetRange("Status",Approv.Status::Approved);
                if Approv.FindLast() then begin
                    if UserSetup.Get(Approv."Approver ID") then begin
                        UserSetup.CalcFields("User Signature");
                    end;  
                end;
                
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;
    var
        CompanyInformation: Record "Company Information";
        Approv: Record "Approval Entry";
        UserSetup: Record "User Setup";
}
