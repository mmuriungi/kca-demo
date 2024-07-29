page 54265 "FLT-Transport Req."
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
                Editable = group1;
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
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("Date of Trip"; Rec."Date of Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Trip field.';
                }
                field("Time out"; Rec."Time out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time out field.';
                }
                field("Duration to be Away"; Rec."Duration to be Away")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration to be Away field.';
                }
                field("Number of Passangers"; Rec."Number of Passangers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Passangers field.';
                }
                field("Vehicle Number "; Rec."Vehicle  Registartion Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Allocated field.';
                }

                field("Vehicle seat Capacity"; Rec."Veh Capacity")
                {
                    ApplicationArea = All;
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
            group("PART THREE: REGISTRAR (VICE-CHANCELLOR'S OFFICE)")
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
                    ToolTip = 'Specifies the value of the HOD UserName field.';
                }
                field("Registrar Approval Time"; rec."VC Approval Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD UserName field.';
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
                field("Mileage Before Trip"; Rec."Mileage Before Trip")
                {
                    ApplicationArea = All;
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
                field("Cost Per Kilometer"; Rec."Cost Per Kilometer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Per Kilometer field.';
                }

                field("Fuel Unit Cost"; Rec."Fuel Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel Unit Cost field.';
                }
                field("Transport Available/Not Av."; Rec."Transport Availability.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Available/Not Av. field.';
                }
                field("Car Pool"; Rec."Car Pool")
                {
                    ApplicationArea = All;
                }

            }
            group("PART FOUR: ADMINISTRATION AND CENTRAL SERVICES")
            {
                Editable = group4;
                field("Approved/Not Approved"; Rec."Approved Request ?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Available/Not Av. field.';

                }
                field("Allocation Time"; "Transport Approval Time")
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
                        REPORT.Run(Report::"FTL- Transport Requests", true, true, transRe);
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


}

