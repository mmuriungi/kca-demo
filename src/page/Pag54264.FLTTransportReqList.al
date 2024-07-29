page 54264 "FLT-Transport Req. List"
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
}

