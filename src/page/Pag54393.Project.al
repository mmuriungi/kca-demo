page 54393 Project
{
    Caption = 'Project';
    PageType = Card;
    SourceTable = Project;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Project Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Project Type"; Rec."Project Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Type field.';
                }
                field("Project Description"; Rec."Contract Summary")
                {
                    caption = 'project Description';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Summary field.';
                    MultiLine = true;
                    Width = 4500;

                }
                field(user; rec.user)
                {
                    caption = 'User';
                    ApplicationArea = All;

                }
                // field("Perfomance Bond"; Rec."Perfomance Bond")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Perfomance Bond field.';
                // }
                field("Start Date"; Rec."Start Date")
                {
                    Visible = rec.Status = rec.Status::Approved;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("Expected End Date"; Rec."Expected End Date")
                {
                    Visible = rec.Status = rec.Status::Approved;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected End Date field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created by field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Estimated Cost"; rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            group("Project Supervisor")
            {
                Visible = rec.Status = rec.Status::Approved;

                field(Requester; rec.Requester)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Requester Name"; rec."Requester Name")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field(Department; rec.Department)
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }

            }
            part("Assigned Staff"; "Assigned staffs list")
            {
                ApplicationArea = basic, suit;
                SubPageLink = no = field("No.");
                Editable = rec.Status = rec.Status::Approved;
                Visible = rec.Status = rec.Status::Approved;

            }
            part("Monthly Report"; "Project Report list")
            {
                Visible = rec.Status = rec.Status::Approved;
                ApplicationArea = basic, suit;
                SubPageLink = "Report Code" = field("No.");
                Editable = rec.Status = rec.Status::Approved;

            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Attachments)
            {
                caption = 'Project Design template';
                ApplicationArea = Basic, Suite;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
            action(Approvals)
            {
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                RunObject = page "Approval Entries";
                RunPageLink = "Document No." = field("No.");
                Visible = not (Rec.Status = Rec.Status::Open);
            }
            action("Request Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Pending;
                    // If ApprovalsMgmt.CheckMaintenanceRequestsWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMaintenanceRequestForApproval(Rec);
                end;
            }
            action("Approve")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Approved;
                    // If ApprovalsMgmt.CheckMaintenanceRequestsWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMaintenanceRequestForApproval(Rec);
                end;
            }
            action("Cancelled")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Cancelled;
                    // If ApprovalsMgmt.CheckMaintenanceRequestsWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMaintenanceRequestForApproval(Rec);
                end;
            }
            action("Re-do")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Cancelled;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Open;
                    // If ApprovalsMgmt.CheckMaintenanceRequestsWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMaintenanceRequestForApproval(Rec);
                end;
            }
            action("Start The Project")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::InProgress;
                    // If ApprovalsMgmt.CheckMaintenanceRequestsWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendMaintenanceRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = CancelApprovalRequest;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelMaintenanceRequestForApproval(Rec);
                end;
            }
        }


    }
    var
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
}
