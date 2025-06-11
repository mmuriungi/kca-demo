page 51397 "FLT-Transport Req."
{
    PageType = Document;
    SourceTable = "FLT-Transport Requisition";
    //SourceTableView = WHERE(Status = FILTER(Open));
    layout
    {
        area(Content)
        {
            Group("PART ONE: APPLICANT")
            {
                //Editable = group1;
                field("Transport Requisition No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Emp No"; Rec."Emp No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Emp No field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Driver Contact number"; rec."Driver Contact number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose of Trip field.';
                }
                field(Destination; Rec.Destination)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field("Nature of Trip"; Rec."Nature of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nature of Trip field.';
                }
                field("Time out"; Rec."Time out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time out field.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
                field("Number of Passangers"; Rec."Number of Passangers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Passangers field.';
                }
                field("Vehicle Number "; Rec."Vehicle  Registartion Number")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Vehicle Allocated field.';
                }

                field("Vehicle seat Capacity"; Rec."Veh Capacity")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Vehicle Capacity field.';
                }

                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Approval Stage"; Rec."Approval Stage")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Stage field.';
                }
            }
            Group("PART TWO: HEAD OF DEPARTMENT/FACULTY/SECTION")
            {
                Editable = group2;
                field("Recommed this Request"; Rec."Recommed this Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommed this Request field.';
                }
                field("Recommendation Reason"; Rec."Recommendation Reason")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommendation Reason field.';
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD Name field.';
                }
                field("HOD UserName"; Rec."HOD UserName")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD UserName field.';
                }
                field("HOD Approved Date"; rec."HOD Approved Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD UserName field.';
                }
                field("HoD Approval Time"; rec."HoD  Approval Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD UserName field.';
                }


            }
            group("PART THREE: REGISTRAR")
            {
                Editable = group4;
                field("Approved/Not Approved request"; Rec."Approved Request ?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved/Not Approved field.';
                }
                field("Admin Head Name"; Rec."Admin Head Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Admin Head Name field.';
                }
                field("Admin Head Username"; Rec."Admin Head Username")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Admin Head Username field.';
                }
                field("Registrar  Approval Date"; rec."VC  Approval Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registrar Approval Date field.';
                }
                field("Registrar Approval Time"; rec."VC Approval Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Registrar Approval Time field.';
                }
            }
            group("PART FOUR:ALLOCATION DETAILS BY TRANSPORT OFFICER ")
            {
                Editable = group3;

                field("Vehicle Allocated"; Rec."Vehicle Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Allocated field.';
                }
                field("Vehicle Capacity"; Rec."Vehicle Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Capacity field.';
                }
                field("Vehicle I Fuel Cost"; Rec."Vehicle I Fuel Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle I Fuel Cost field.';
                }
                field("Vehicle II"; Rec."Vehicle II")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle II field.', Comment = '%';
                }
                field("Vehicle II Fuel Cost"; Rec."Vehicle II Fuel Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle II Fuel Cost field.';
                }
                field("Vehicle II Capacity"; Rec."Vehicle II Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle II Capacity field.', Comment = '%';
                }
                field("Vehicle III"; Rec."Vehicle III")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle III field.', Comment = '%';
                }
                field("Vehicle III Fuel Cost"; Rec."Vehicle III Fuel Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle III Fuel Cost field.';
                }
                field("Vehicle III Capacity"; Rec."Vehicle III Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle III Capacity field.', Comment = '%';
                }

                field("Mileage Before Trip"; Rec."Mileage Before Trip")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Mileage Before Trip field.';
                }
                field("Driver Allocated"; Rec."Driver Allocated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Allocated field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field(DriverContact; REC.DriverContact)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Driver I DSA"; Rec."Driver I DSA")
                {
                    ApplicationArea = All;
                }
                field("Driver II"; Rec."Driver II")
                {
                    ApplicationArea = All;
                }
                field("Driver II Name"; Rec."Driver II Name")
                {
                    ApplicationArea = All;
                }
                field("Driver II Contact"; Rec."Driver II Contact")
                {
                    ApplicationArea = All;
                }
                field("Driver II DSA"; Rec."Driver II DSA")
                {
                    ApplicationArea = All;
                }
                field("Driver III"; Rec."Driver III")
                {
                    ApplicationArea = All;
                }
                field("Driver III Name"; Rec."Driver III Name")
                {
                    ApplicationArea = All;
                }
                field("Driver III Contact"; Rec."Driver III Contact")
                {
                    ApplicationArea = All;
                }
                field("Driver III DSA"; Rec."Driver III DSA")
                {
                    ApplicationArea = All;
                }
                field("Cost Per Kilometer"; Rec."Cost Per Kilometer")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Cost Per Kilometer field.';
                }

                field("Fuel Unit Cost"; Rec."Fuel Unit Cost")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Fuel Unit Cost field.';
                }
                field("Transport Available/Not Av."; Rec."Transport Availability.")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the value of the Transport Available/Not Av. field.';
                }
                field("Car Pool"; Rec."Car Pool")
                {
                    ApplicationArea = All;
                    visible = false;
                }

            }
            group("PART FOUR: ADMINISTRATION AND CENTRAL SERVICES")
            {
                Editable = group4;
                Visible = false;
                field("Approved/Not Approved"; Rec."Approved Request ?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Available/Not Av. field.';

                }
                field("Allocation Time"; Rec."Transport Approval Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Available/Not Av. field.';

                }

            }

            // group("PART FIVE: AFTER TRIP TRANSPORT DETAILS")
            // {
            //     field("Total Mileage Travelled"; Rec."Total Mileage Travelled")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Total Mileage Travelled field.';
            //     }
            //     field("Milleage after Trip"; Rec."Milleage after Trip")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Milleage after Trip field.';
            //     }
            //     field("Total Cost"; Rec."Total Cost")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Total Cost field.';
            //     }
            //     field("Return Date"; Rec."Return Date")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Return Date field.';
            //     }
            //     field("Time In"; Rec."Time In")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Time In field.';
            //     }


            // }

            part(Control29; "FLT-Transport Requisition St")
            {
                Visible = false;
                SubPageLink = "Req No" = FIELD("Transport Requisition No");
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        area(processing)
        {
            action(sendApproval)
            {
                Caption = 'Send Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Init Codeunit";
                begin
                    rec."Requested By" := UserId;
                    Rec."Date Requisition Received" := Today;
                    Rec."Time Requisition Received" := Time;
                    If Confirm('Send this Request for Approval ?', true) = false then ERROR('Cancelled');
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec."Approval Stage" := Rec."Approval Stage"::"Head of Department";
                    Rec.Modify();
                    Message('Sent Successfully to Head Of Department/Faculty/Section ');
                    CurrPage.Close();

                    ApprovalMgt.OnSendTransportReqforApproval(Rec);
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Requested By" = UserId then begin
                        If Confirm('cancel this Request from Approval ?', true) = false then ERROR('Cancelled');
                        if ((Rec.Status = Rec.Status::"Pending Approval") and (Rec."Approval Stage" = Rec."Approval Stage"::"Head of Department")) then begin
                            Rec.Status := Rec.Status::Open;
                            Rec."Approval Stage" := Rec."Approval Stage"::New;
                            Rec.Modify();
                        end else
                            ERROR('Contact Trasport officer to assist');

                    end else
                        ERROR('You Cannot Cancel this request');

                end;
            }
            action("Generate Carpool")
            {
                //Caption = 'Print/Preview';
                Image = PrintReport;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    carPool.createCarPool(Rec."Transport Requisition No");
                end;
            }
            action("Print/Preview")
            {
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    transRe.Reset;
                    transRe.SetFilter(transRe."Transport Requisition No", Rec."Transport Requisition No");
                    if transRe.Find('-') then
                        REPORT.Run(Report::"Transport Request", true, true, transRe);
                end;
            }
            action(Attachments2)
            {
                ApplicationArea = All;
                Caption = 'Applicant Attachments';
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    DocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(DocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    DocumentAttachment.OpenForRecReference(RecRef);
                    DocumentAttachment.RUNMODAL;
                end;
            }
            action(HODApprove)
            {
                Caption = 'Approve';
                image = Approve;
                Promoted = true;
                Visible = group2;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Head of Department" = UserID then begin
                        Rec.TestField("Transport Officer");
                        Rec.TestField("Recommed this Request");
                        Rec.TestField("Recommendation Reason");
                        if Confirm('Approve the request ?', true) = false then Error('Cancelled');
                        Rec."Approval Stage" := Rec."Approval Stage"::"Registra HRM";
                        Rec."HOD Approved" := true;
                        Rec."HOD Approved Date" := Today;
                        Rec.Modify();
                        Message('Record moved to the registrar (Vice Chancellors Office)');
                        CurrPage.Close();

                    end else
                        Error('You are not authorised to approve this request');

                end;
            }
            action(RegistraApprove)
            {
                Caption = 'Approve';
                image = Approve;
                Promoted = true;
                Visible = group4;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Registrar HRM" = UserID then begin
                        //  Rec.TestField("Vehicle Allocated");
                        // Rec.TestField("Driver Allocated");
                        if Confirm('Approve the request ?', true) = false then Error('Cancelled');
                        Rec."Approval Stage" := Rec."Approval Stage"::"Transport Officer";
                        Rec."Registra Approved" := true;

                        Rec."Admin Approved Date" := Today;

                        Rec.Modify();
                        Message('Record moved to Transport Officer for allocation and final approval');

                        CurrPage.Close();

                    end else
                        Error('You are not authorised to approve this request');

                end;
            }

            action(TRApprove)
            {
                Caption = 'Approve';
                image = Approve;
                Promoted = true;
                Visible = group3;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if Rec."Transport Officer" = UserID then begin
                        Rec.TestField("Registrar HRM");
                        Rec.TestField("Vehicle Allocated");
                        Rec.TestField("Driver Allocated");
                        if Confirm('Approve the request ?', true) = false then Error('Cancelled');
                        Rec."Approval Stage" := Rec."Approval Stage"::"Fully Approved";
                        Rec."TR Officer Approved" := true;
                        Rec.Status := Rec.Status::Approved;
                        Rec."TR Approved Date" := Today;
                        Rec."TO Approval Date" := Today;
                        Rec.Modify();
                        Message('Record Approved');

                        CurrPage.Close();

                    end else
                        Error('You are not authorised to approve this request');

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

    trigger OnOpenPage()
    begin
        group2Editable();
    end;

    var
        Text0001: Label 'You have not been setup as a Fleet Management User Contact your Systems Administrator';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        ApprovalEntries: Page "Approval Entries";
        UserSetup2: Record "User Setup";
        emp: Record "HRM-Employee C";
        UserSetup3: Record "User Setup";
        transRe: Record "FLT-Transport Requisition";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        carPool: Codeunit "FLT- Code Unit";
        FltMgtSetup: Record "FLT-Fleet Mgt Setup";
        group2: Boolean;
        group1: Boolean;
        group3: Boolean;
        group4: Boolean;
        group5: Boolean;



    procedure group2Editable()
    begin
        group1 := true;
        group2 := false;
        group3 := false;
        group4 := false;

        /* if Rec.Status <> Rec.status::Open then
            group1 := false;

        if Rec.Status = Rec.status::"Pending Approval" then
            group2 := true;

        if Rec."Recommed this Request" = Rec."Recommed this Request"::Yes then begin
            group3 := true;
            group2 := false;
        end;

        if Rec."Transport Available/Not Av." = Rec."Transport Available/Not Av."::Available then begin
            group2 := false;
            group3 := false;
            group4 := true;
        end; */
        if rec."Approval Stage" = Rec."Approval Stage"::"Transport Officer" then
            group3 := true;

        if rec."Approval Stage" = Rec."Approval Stage"::"Head of Department" then
            group2 := true;

        if rec."Approval Stage" = Rec."Approval Stage"::"Registra HRM" then
            group4 := true;


        if Rec.Status <> Rec.Status::Open then begin
            group1 := false;
        end;

    end;

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

