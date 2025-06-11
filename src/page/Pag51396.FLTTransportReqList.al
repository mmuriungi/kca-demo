page 51396 "FLT-Transport Req. List"
{
    CardPageID = "FLT-Transport Req.";
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    //SourceTableView = WHERE(Status = FILTER(Open));
    Caption = 'FLT-Transport Req. List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field("Emp No"; Rec."Emp No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Emp No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Request")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;
                Image = SendApprovalRequest;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Codeunit";
                begin
                    if ApprovalMgt.IsTransportReqEnabled(Rec) then begin
                        ApprovalMgt.OnSendTransportReqforApproval(Rec);
                    end ELSE
                        ERROR('Check Your Workflow and try again')
                end;
            }
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = field("Transport Requisition No");
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Codeunit";
                begin
                    ApprovalMgt.OnCancelTransportReqforApproval(Rec);
                end;
            }

            action("Print/Preview")
            {
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //RESET;
                    //SETFILTER("No.","No.");
                    //REPORT.RUN(39006200,TRUE,TRUE,Rec);
                    //RESET;
                end;
            }
            action("Generate Trip Schedule")
            {
                Caption = 'Generate Trip Schedule';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TripSchedule: Record "Trip Schedule";
                    TransportReq: Record "FLT-Transport Requisition";
                    ConfirmMsg: Label 'Do you want to generate trip schedules for the selected approved transport requisitions?';
                    NoApprovedReqMsg: Label 'Please select only approved transport requisitions.';
                    SuccessMsg: Label '%1 trip schedule(s) generated successfully.';
                    AlreadyExistsMsg: Label 'Trip schedule already exists for Transport Requisition %1';
                    NoVehicleMsg: Label 'Transport Requisition %1 has no vehicles allocated.';
                    Counter: Integer;
                begin
                    if not Confirm(ConfirmMsg) then
                        exit;

                    CurrPage.SetSelectionFilter(TransportReq);
                    TransportReq.SetRange(Status, TransportReq.Status::Approved);

                    if not TransportReq.FindSet() then begin
                        Message(NoApprovedReqMsg);
                        exit;
                    end;

                    Counter := 0;
                    repeat
                        // Check if at least one vehicle is allocated
                        if (TransportReq."Vehicle Allocated" = '') and
                           (TransportReq."Vehicle II" = '') and
                           (TransportReq."Vehicle III" = '') then begin
                            Message(NoVehicleMsg, TransportReq."Transport Requisition No");
                        end else begin
                            // Check if trip schedule already exists for this requisition
                            TripSchedule.Reset();
                            TripSchedule.SetRange("Transport Requisition No.", TransportReq."Transport Requisition No");
                            if TripSchedule.IsEmpty then begin
                                // Create trip schedule for Vehicle I if allocated
                                if TransportReq."Vehicle Allocated" <> '' then begin
                                    if CreateTripSchedule(TransportReq, 1) then
                                        Counter += 1;
                                end;

                                // Create trip schedule for Vehicle II if allocated
                                if TransportReq."Vehicle II" <> '' then begin
                                    if CreateTripSchedule(TransportReq, 2) then
                                        Counter += 1;
                                end;

                                // Create trip schedule for Vehicle III if allocated
                                if TransportReq."Vehicle III" <> '' then begin
                                    if CreateTripSchedule(TransportReq, 3) then
                                        Counter += 1;
                                end;

                                // Mark the transport requisition as loaded to trip schedule
                                if Counter > 0 then begin
                                    TransportReq."Loaded to WorkTicket" := true;
                                    TransportReq.Modify();
                                end;
                            end else
                                Message(AlreadyExistsMsg, TransportReq."Transport Requisition No");
                        end;
                    until TransportReq.Next() = 0;

                    if Counter > 0 then
                        Message(SuccessMsg, Counter);
                end;

            }
        }

    }

    var
        //UserMgt: Codeunit "User Setup Management BR";
        //ApprovalMgt: Codeunit "Approvals Management";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        ApprovalEntries: Page "Approval Entries";
        UserSetup2: Record "User Setup";
        hremp: Record "HRM-Employee C";
        UserSetup3: Record "User Setup";

    local procedure CreateTripSchedule(TransportReq: Record "FLT-Transport Requisition"; VehicleNo: Integer): Boolean
    var
        TripSchedule: Record "Trip Schedule";
        VehicleReg: Code[20];
        DriverCode: Code[20];
        DriverName: Text[100];
        DSAAmount: Decimal;
        FuelAmount: Decimal;
    begin
        // Get vehicle and driver details based on vehicle number
        case VehicleNo of
            1:
                begin
                    VehicleReg := TransportReq."Vehicle Allocated";
                    DriverCode := TransportReq."Driver Allocated";
                    DriverName := TransportReq."Driver Name";
                    DSAAmount := TransportReq."Driver I DSA";
                    FuelAmount := TransportReq."Vehicle I Fuel Cost";
                end;
            2:
                begin
                    VehicleReg := TransportReq."Vehicle II";
                    DriverCode := TransportReq."Driver II";
                    DriverName := TransportReq."Driver II Name";
                    DSAAmount := TransportReq."Driver II DSA";
                    FuelAmount := TransportReq."Vehicle II Fuel Cost";
                end;
            3:
                begin
                    VehicleReg := TransportReq."Vehicle III";
                    DriverCode := TransportReq."Driver III";
                    DriverName := TransportReq."Driver III Name";
                    DSAAmount := TransportReq."Driver III DSA";
                    FuelAmount := TransportReq."Vehicle III Fuel Cost";
                end;
        end;

        // Skip if no driver is allocated for this vehicle
        if DriverCode = '' then
            exit(false);

        // Create new trip schedule
        TripSchedule.Init();
        TripSchedule."Transport Requisition No." := TransportReq."Transport Requisition No";
        TripSchedule."Driver Code " := DriverCode;
        TripSchedule."Driver Name" := DriverName;
        TripSchedule.Date := TransportReq."Date of Trip";
        TripSchedule.Destination := TransportReq.Destination;
        TripSchedule."No Of Days" := Format(TransportReq."No of Days Requested");
        TripSchedule."Vehicle Reg No" := VehicleReg;

        // Calculate DSA amount
        if DSAAmount <> 0 then
            TripSchedule.Amount := DSAAmount
        else if TransportReq."No of Days Requested" <> 0 then
            TripSchedule.Amount := TransportReq."No of Days Requested" * 1000; // Default DSA rate

        // Set fuel amount
        if FuelAmount <> 0 then
            TripSchedule."Fuel Amount" := FuelAmount
        else if (VehicleNo = 1) and (TransportReq."Estimated Cost" <> 0) then
            TripSchedule."Fuel Amount" := TransportReq."Estimated Cost" / 3 // Divide estimated cost by number of vehicles
        else if TransportReq."Estimated Cost" <> 0 then
            TripSchedule."Fuel Amount" := TransportReq."Estimated Cost" / 3;

        TripSchedule.Insert();
        exit(true);
    end;

}

