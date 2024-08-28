page 51579 "Combined Transport Req"
{
    Caption = 'Combined Transport Requisition';
    PageType = List;
    SourceTable = "FLT-Transport Requisition";
    CardPageId = "Combined Transport Req card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Combined Req No"; Rec."Transport Requisition No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transport Requisition No field.';
                }
                field("Date of Request"; Rec."Date of Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Request field.';
                }
                field("Purpose of Trip"; Rec."Purpose of Trip")
                {
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
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
                        ApprovalMgt: Codeunit "Init Codeunit";
                    begin
                        rec."Requested By" := UserId;
                        Rec."Date Requisition Received" := Today;
                        Rec."Time Requisition Received" := Time;
                        ApprovalMgt.OnSendTransportReqforApproval(Rec);
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
                        ApprovalMgt: Codeunit "Init Codeunit";
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
                        ApprovalMgt.OnCancelTransportReqforApproval(Rec);
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
