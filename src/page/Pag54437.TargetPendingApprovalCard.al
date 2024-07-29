page 54437 "Target Pending Approval Card"
{
    Caption = 'Target Pending Approval Card';
    PageType = Card;
    SourceTable = "Employee Perfomance Target";
    PromotedActionCategories = 'New,Process,Report,Approve';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    trigger OnValidate()
                    var
                        Employee: Record "HRM-Employee (D)";
                    begin
                        if Employee.Get(rec."Employee No.") then begin
                            Rec."Employee Name" := Employee.FullName();
                        end;
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("Target Year"; Rec."Target Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Year field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Level field.';
                }

            }
            part(lines; "Employee Perf Line")
            {
                
               // SubPageLink = "Document No." = field("No.");
                ApplicationArea = all;
                Caption = 'Employee Perf Line';
            }
            // part(line2; "WorkPlan Sub Categories List")
            // {
            //     SubPageLink = "Document No." = field("No.");
            //     ApplicationArea = all;
            // }

        }
    }
    actions
    {
        area(Processing)
        {
            /*action("Send for Appoval")
            {
                ApplicationArea = Suite;
                Caption = 'Send for Appoval';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Send for Appoval';
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::"Pending Approval";
                    Rec.Modify();
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Re&quest';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                begin
                    ApprovalsMgmtCut.OnCancelEmployeePerfomanceTargetsForApproval(Rec);
                    WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                end;
            }
            action("Populate Targets")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    WorkplanLines: Record "Dept Activities";
                    //WorkplanLines: Record "Work Plan Lines";
                    EmployeePerfTargets: Record "Employee Perf Targets Line";
                    LineNo: Integer;
                begin
                    EmployeePerfTargets.Init();
                    EmployeePerfTargets.Reset();
                    repeat
                        if EmployeePerfTargets.FindLast() then
                            LineNo := EmployeePerfTargets."Line No." + 10000
                        else
                            LineNo := 10000;
                        WorkplanLines.CalcFields("Department Code", "Plan Year");
                        WorkplanLines.SetRange("Department Code", Rec."Department Code");
                        WorkplanLines.SetRange("Plan Year", Rec."Target Year");
                        EmployeePerfTargets."Line No." := LineNo;
                        EmployeePerfTargets."Document No." := Rec."No.";
                        EmployeePerfTargets.Category := WorkplanLines.Category;
                        EmployeePerfTargets."Category Description" := WorkplanLines."Category Description";
                        EmployeePerfTargets."Weight (%)" := WorkplanLines."Weight (%)";
                        EmployeePerfTargets."Performance Criteria" := WorkplanLines."Description";
                        EmployeePerfTargets."S/No." := WorkplanLines.Code;
                        EmployeePerfTargets."Status Previous Year" := WorkplanLines."Status Previous Year";
                        EmployeePerfTargets.Target := WorkplanLines.Target;
                        EmployeePerfTargets."Unit of Measure" := WorkplanLines."Unit of Measure";
                        EmployeePerfTargets.Select := false;
                        EmployeePerfTargets.Insert();
                    until WorkplanLines.Next() = 0;
                    EmployeePerfTargets.SetRange("S/No.", '');
                    EmployeePerfTargets.DeleteAll();
                end;
            }*/
            action(Approve)
            {
                ApplicationArea = Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Approve the requested changes.';
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Released;
                    Rec.Modify();
                    //ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Reject)
            {
                ApplicationArea = Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Reject the requested changes.';
                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    //ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'Delegate the requested changes to the substitute approver.';
                trigger OnAction()
                begin
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                end;
            }
            // action("Notify the HOD")
            // {
            //     ApplicationArea = Suite;
            //     Caption = 'Notify the HOD';
            //     Image = Delegate;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedOnly = true;
            //     ToolTip = 'Notify the HOD';
            //     trigger OnAction()
            //     var
            //         EmailMessage: Codeunit "Email Message";
            //         Email: Codeunit Email;
            //         Recipients: List of [Text];
            //         Subject: Text;
            //         Body: Text;
            //     begin
            //         Recipients.Add('markokoth96@outlook.com');
            //         Subject := StrSubstNo('My perfomance target for the year %1..%2', 2022, 2023);
            //         Body := StrSubstNo('I have forwared my appraisal target for the kindly review and approve', UserId);
            //         EmailMessage.Create(Recipients, Subject, Body, true);
            //         Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            //     end;
            // }
            // action("Forward to Reporting")
            // {
            //     ApplicationArea = Suite;
            //     Caption = 'Forward to Reporting';
            //     Image = Delegate;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedOnly = true;
            //     ToolTip = 'Forward to Reporting';
            //     trigger OnAction()
            //     begin
            //         REC.Level := REC.Level::Report;
            //         Rec.Modify()
            //     end;
            // }
            // action("Print")
            // {
            //     ApplicationArea = Suite;
            //     Caption = 'Print';
            //     Image = Delegate;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedOnly = true;
            //     ToolTip = 'Print';
            //     trigger OnAction()

            //     begin
            //         Rec.SetRange("No.", Rec."No.");
            //         if Rec.FindFirst() then begin
            //             Report.Run(report::"WorkPlan Report", true, true, Rec);
            //         end;
            //     end;
            // }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    //DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;

            }
        }
    }
    var
        // ApprovalsMgmtCut: Codeunit "ET Approval Mgmt. Ext";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}