page 50380 "HRM-Leave Requisition"
{
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "HRM-Leave Requisition";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = NoEditable;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    Editable = DateEditable;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = EmpNameEditable;
                }
                field("Reliever No."; Rec."Reliever No.")
                {
                    ApplicationArea = all;
                    Editable = RelNoEditable;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = all;
                    Editable = RelNameEditable;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    //ApplicationArea = all;
                    Visible = false;
                    Caption = 'Cost  Centre';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                    Editable = DepartmentCodeEditable;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = all;
                    Editable = LeaveTypeEditable;
                }
                field("Applied Days"; Rec."Applied Days")
                {
                    ApplicationArea = all;
                    Editable = AppliedDaysEditable;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    Editable = StartingDateEditable;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = all;
                    Editable = PurposeEditable;
                }
                field("Availlable Days"; Rec."Availlable Days")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approvals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                RunObject = Page "HR-Approval Entries";
                RunPageLink = "Document No." = field("No.");
            }
            // action(sendApproval)
            // {
            //     Caption = 'Send A&pproval Request';
            //     Image = SendApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         ApprovalMgnt: Codeunit IntCodeunit;

            //     begin
            //         if ApprovalMgnt.IsLeaveReqEnabled(Rec) then
            //             ApprovalMgnt.OnSendLeaveReqforApproval(Rec)
            //         else
            //             Error('Check Your workflow setup');
            //     end;
            // }
            action(sendApproval)
            {
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    approvalmgt: Codeunit IntCodeunit;
                begin
                    if Rec.Status = Rec.Status::Open then
                    begin
                        approvalmgt.UpdateLeaveWorkflow(Rec);
                        approvalmgt.OnSendLeavesforApproval(Rec)
                    end
                    else
                        Error('Status is not open');
                end;
            }
            action(cancellsApproval)
            {
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalMgt: Codeunit IntCodeunit;
                    showmessage: Boolean;

                begin

                    showmessage := true;
                    if Rec.Status = Rec.Status::"Pending Approval" then
                        ApprovalMgt.OnCancelLeaveforApproval(Rec)
                    else
                        error('Status must be pending approval');

                end;
            }
            action("Print/Preview")
            {
                ApplicationArea = all;
                Caption = 'Print/Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(report::"HR Leave Application (1)", true, true, Rec);
                    Rec.Reset;
                end;
            }
            separator(Separator24)
            {
            }
            action("Post Leave Application")
            {
                ApplicationArea = all;
                Caption = 'Post Leave Application';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Released then Error('The Document Approval is not Complete');

                    Rec.TestField("Employee No");
                    Rec.TestField("Applied Days");
                    Rec.TestField("Starting Date");

                    LeaveEntry.Init;
                    LeaveEntry."Document No" := Rec."No.";
                    LeaveEntry."Leave Period" := Date2DWY(Today, 3);
                    LeaveEntry."Transaction Date" := Rec.Date;
                    LeaveEntry."Employee No" := Rec."Employee No";
                    LeaveEntry."Leave Type" := Rec."Leave Type";
                    LeaveEntry."No. of Days" := -Rec."Applied Days";
                    LeaveEntry."Transaction Description" := Rec.Purpose;
                    LeaveEntry."Entry Type" := LeaveEntry."Entry Type"::Application;
                    LeaveEntry."Created By" := UserId;
                    LeaveEntry."Transaction Type" := LeaveEntry."Transaction Type"::Application;
                    LeaveEntry.Insert(true);

                    Rec.Posted := true;
                    Rec."Posted By" := UserId;
                    Rec."Posting Date" := Today;
                    Rec.Modify;

                    if HREmp.Get(Rec."Employee No") then begin
                        HREmp."On Leave" := true;
                        HREmp."Current Leave No" := Rec."No.";
                        HREmp.Modify;
                    end;
                    Message('Leave Posted Successfully');
                end;
            }

        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        /*PurposeEditable := TRUE;
        "Starting DateEditable" := TRUE;
        "Applied DaysEditable" := TRUE;
        "Department CodeEditable" := TRUE;
        "Campus CodeEditable" := TRUE;
        "Employee NoEditable" := TRUE;
        DateEditable := TRUE;
        "No.Editable" := TRUE;
        UpdateControls;

    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */
        //SETFILTER("User ID",USERID);

    end;

    var
        UserMgt: Codeunit "User Setup Management";
        //todo  ApprovalMgt: Codeunit "Approvals Management";
        ReqLine: Record "HMS-Setup Blood Group";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        //   JournlPosted: Codeunit "Journal Post Successful";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        FixedAsset: Record "Fixed Asset";
        //MinorAssetsIssue: Record "HMS-Patient";
        LeaveEntry: Record "HRM-Leave Ledger";
        [InDataSet]
        NoEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        EmployeeNoEditable: Boolean;
        [InDataSet]
        CampusCodeEditable: Boolean;
        [InDataSet]
        DepartmentCodeEditable: Boolean;
        [InDataSet]
        AppliedDaysEditable: Boolean;
        [InDataSet]
        StartingDateEditable: Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        ApprovalEntries: Page "HR-Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        HREmp: Record "HRM-Employee C";
        RelNoEditable: Boolean;
        RelNameEditable: Boolean;
        EmpNameEditable: Boolean;
        LeaveTypeEditable: Boolean;

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            NoEditable := false;
            DateEditable := false;
            //EmployeeNoEditable:=FALSE;
            CampusCodeEditable := false;
            DepartmentCodeEditable := false;
            AppliedDaysEditable := false;
            StartingDateEditable := false;
            PurposeEditable := false;
            RelNoEditable := false;
            RelNameEditable := false;
            EmpNameEditable := false;
            LeaveTypeEditable := false;


            //  CurrForm."Process Leave Allowance".EDITABLE:=FALSE;
        end else begin
            NoEditable := false;
            DateEditable := true;
            //EmployeeNoEditable:=FALSE;
            CampusCodeEditable := false;
            DepartmentCodeEditable := true;
            AppliedDaysEditable := true;
            StartingDateEditable := true;
            PurposeEditable := true;
            RelNoEditable := true;
            RelNameEditable := false;
            EmpNameEditable := false;
            LeaveTypeEditable := true;
            // CurrForm."Process Leave Allowance".EDITABLE:=TRUE;

        end;
    end;
}

