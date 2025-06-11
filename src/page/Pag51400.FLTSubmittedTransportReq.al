page 51400 "FLT-Submitted Transport Req"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "FLT-Transport Requisition";
    SourceTableView = WHERE(Status = FILTER(<> Open),
                            Status = FILTER(<> Approved));
    layout
    {
        area(Content)
        {
            Group("PART ONE: APPLICANT")
            {
                //Editable = False;
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
                field("Number of Passangers"; Rec."Number of Passangers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Number of Passangers field.';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested By field.';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    //Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommendation Reason field.';
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD Name field.';
                }
                field("HOD UserName"; Rec."HOD UserName")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HOD UserName field.';
                }
            }
            group("PART THREE: TRANSPORT AND OPERATIONS OFFICER")
            {
                Editable = group3;
                field("Mileage Before Trip";
                Rec."Mileage Before Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mileage Before Trip field.';
                }
                field("Time out"; Rec."Time out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time out field.';
                }
                field("Total Mileage Travelled"; Rec."Total Mileage Travelled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Mileage Travelled field.';
                }
                field("Cost Per Kilometer"; Rec."Cost Per Kilometer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost Per Kilometer field.';
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Cost field.';
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
                field("Reg. No."; Rec."Reg. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reg. No. field.';
                }
                field("Milleage after Trip"; Rec."Milleage after Trip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Milleage after Trip field.';
                }
            }
            group("PART FOUR: ADMINISTRATION AND CENTRAL SERVICES")
            {
                Editable = group4;

                field("Approved/Not Approved"; Rec."Approved Request ?")
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
            }
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
            group("&Functions")
            {
                Caption = '&Functions';
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    RunObject = Page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("Transport Requisition No");

                }
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approval Workflows V1";
                        Variant: Variant;
                    begin
                        rec."Requested By" := UserId;
                        Rec."Date Requisition Received" := Today;
                        Rec."Time Requisition Received" := Time;
                        Variant := Rec;
                        if ApprovalMgt.CheckApprovalsWorkflowEnabled(Variant) then
                            ApprovalMgt.OnSendDocForApproval(Variant);
                    end;
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
                        ApprovalMgt: Codeunit "Approval Workflows V1";
                        Variant: Variant;
                        // showmessage: Boolean;
                        // ManualCancel: Boolean;
                        // State: Option Open,"Pending Approval",Cancelled,Approved;
                        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    // tableNo: Integer;
                    begin
                        DocType := DocType::TR;
                        //  showmessage:=true;
                        //  ManualCancel:=true;
                        //  Clear(tableNo);
                        //  tableNo:=52018054;
                        Variant := Rec;
                        ApprovalMgt.OnCancelDocApprovalRequest(Variant);
                    end;
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        transRe.Reset;
                        transRe.SetFilter(transRe."Transport Requisition No", Rec."Transport Requisition No");
                        if transRe.Find('-') then
                            REPORT.Run(54201, true, true, transRe);
                        //RESET;
                    end;
                }
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
        group2: Boolean;
        group1: Boolean;
        group3: Boolean;
        group4: Boolean;
        group5: Boolean;

    procedure group2Editable()
    begin
        group1 := true;
        group2 := true;
        group3 := true;
        group4 := true;

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
        if Rec.Status = Rec.Status::Open then begin
            group2 := false;
            group3 := false;
            group4 := false;
        end;

    end;


}

