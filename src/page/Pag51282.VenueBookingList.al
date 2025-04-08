page 51282 "Venue Booking List"
{
    CardPageID = "Venue Booking Header";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Gen-Venue Booking";
    //SourceTableView = WHERE(Status = FILTER(New));
    PromotedActionCategories = 'New,Process,Report,Approval';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Booking Id"; Rec."Booking Id")
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Request Date"; Rec."Request Date")
                {
                }
                field("Booking Date"; Rec."Booking Date")
                {
                }
                field("Booking Time"; Rec."Booking Time")
                {
                }
                field("Meeting Description"; Rec."Meeting Description")
                {
                }
                field("Required Time"; Rec."Required Time")
                {
                }
                field("Venue Dscription"; Rec."Venue Dscription")
                {
                }
                field("Contact Person"; Rec."Contact Person")
                {
                }
                field("Contact Number"; Rec."Contact Number")
                {
                }
                field("Contact Mail"; Rec."Contact Mail")
                {
                }
                field(Pax; Rec.Pax)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Requested By"; Rec."Requested By")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
                field("Total Cost"; Rec."Total Cost")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(sendApproval)
            {
                Caption = 'Send Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit "Approval Workflows V1";
                    showmessage: Boolean;
                    ManualCancel: Boolean;
                    State: Option Open,"Pending Approval",Cancelled,Approved;
                    DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
                    tableNo: Integer;
                    variant: Variant;
                begin
                    Rec.TESTFIELD(Department);
                    Rec.TESTFIELD("Request Date");
                    Rec.TESTFIELD("Booking Date");
                    Rec.TESTFIELD("Meeting Description");
                    Rec.TESTFIELD("Required Time");
                    Rec.TESTFIELD(Venue);
                    Rec.TESTFIELD("Contact Person");
                    Rec.TESTFIELD("Contact Number");
                    Rec.TESTFIELD(Pax);

                    variant := Rec;
                    if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovalMgt.OnSendDocForApproval(variant);
                    CurrPage.UPDATE;
                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Enabled = Rec.Status = Rec.Status::"Pending Approval";

                trigger OnAction()
                var
                    variant: Variant;
                    ApprovalMgt: Codeunit "Approval Workflows V1";
                begin
                    variant := Rec;
                    if ApprovalMgt.CheckApprovalsWorkflowEnabled(variant) then
                        ApprovalMgt.OnCancelDocApprovalRequest(variant);

                    CurrPage.UPDATE;
                end;
            }
            separator(trewy)
            {
            }
            action("Print Form")
            {
                Caption = 'Print Form';
                Image = PrintReport;
                Promoted = true;

                trigger OnAction()
                begin

                    Rec.RESET;
                    Rec.SETFILTER("Booking Id", Rec."Booking Id");
                    REPORT.RUN(77707, TRUE, TRUE, Rec);
                    Rec.RESET;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
     
    end;

    var
        // UserMgt: Codeunit "50114";
        // ApprovalMgt: Codeunit "439";
        // InventorySetup: Record "313";
        // GenJnline: Record "83";
        // LineNo: Integer;
        // Post: Boolean;
        // JournlPosted: Codeunit "50113";
        // HasLines: Boolean;
        // AllKeyFieldsEntered: Boolean;
        // FixedAsset: Record "5600";
        // ApprovalEntries: Page "658";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        RelNoEditable: Boolean;
        RelNameEditable: Boolean;
        EmpNameEditable: Boolean;
        LeaveTypeEditable: Boolean;
        RespCenter: Code[10];
    //ApprovalsMgtNotification: Codeunit "440";
}

