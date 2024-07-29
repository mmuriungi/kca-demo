page 54388 "Maintenance Request"
{
    Caption = 'Maintenance Request';
    PageType = Card;
    SourceTable = "Maintenance Request";

    layout
    {
        area(content)
        {
            group(General)

            {
                Editable = rec.Status = rec.Status::Open;
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
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

                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }



                // field("Start Date"; Rec."Start Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Start Date field.';
                // }
                // field("End Date"; Rec."End Date")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the End Date field.';
                // }
                // field("Maintenance Period"; Rec."Maintenance Period")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Maintenance Period(Days) field.';
                // }
                group(SD)
                {
                    ShowCaption = false;
                    Visible = Rec.Status = Rec.Status::Scheduled;
                    field("Scheduled Date"; Rec."Maintenance Period")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }



            }
            group("Maintenance Request")
            {
                Caption = 'Maintenance Request';
                Editable = rec.Status = rec.Status::Open;

                field("Facility No."; Rec."Facility No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facility No. field.';
                }
                field("Facility Description"; Rec."Facility Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facility Description field.';
                }
                field("maintenance Requests"; Rec."maintenance Requests")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the maintenance Requests field.', Comment = '%';

                }
                group(MD)
                {
                    ShowCaption = false;
                    field("Maintenance Description"; Rec."Maintenance Description")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        ToolTip = 'Specifies the value of the Maintenance Description field.';
                    }
                }



            }
            group("Estates Officer ")
            {
                Visible = not (rec.Status = rec.Status::Open);
                Editable = rec.Status = rec.Status::unClassified;
                Caption = 'Estates Officer';
                field("Type Of Request"; Rec."Type Of Request")
                {
                    Caption = 'Type Of Request';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the IsMaintenance field.', Comment = '%';
                }
                field(AssignedMo; Rec.AssignedMo)
                {
                    Caption = 'assigned MO';
                    ApplicationArea = All;

                    ToolTip = 'Specifies the value of the AssignedMo field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(email; Rec.email)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the email field.', Comment = '%';
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Estimated Cost field.', Comment = '%';
                }
                field("Estates Officer"; Rec."User ID")
                {
                    Caption = 'Estates Officer';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Maintenance Year"; rec."Maintenance Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Period(Days) field.';
                }
                field("Maintenance Period"; Rec."Maintenance Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Period(Days) field.';
                }

            }
            // group("maintenance request lines")
            // {
            //     part(MNR; "maintenance request lines")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         SubPageLink = "No." = field("No.");


            //     }
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments)
            {
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
            action(ForwardForClassification)
            {
                Caption = 'Forward to Classification list';
                ApplicationArea = All;
                Visible = rec.Status = rec.Status::Open;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::unClassified;
                    Message('Request have  been  forwarded to classification  list successfully');

                end;
            }
            action("Classify as maintenance")
            {
                Caption = 'Classify as maintenance';
                ApplicationArea = All;
                Visible = rec.Status = rec.Status::unClassified;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::Approved;
                    rec."Type Of Request" := rec."Type Of Request"::Maintenance;
                    Message('Request have  been classified and forwarded to Maintenance list successfully');

                end;
            }
            action("Classify as repair")
            {
                Caption = 'Classify as Repair';
                ApplicationArea = All;
                Visible = rec.Status = rec.Status::unClassified;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    rec.Status := rec.Status::repair;
                    rec."Type Of Request" := rec."Type Of Request"::Repair;
                    Message('Request have  been classified and forwarded to Repair list successfully');

                end;
            }
            // action(Approvals)
            // {
            //     Image = Approvals;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     ApplicationArea = Basic, Suite;
            //     RunObject = page "Approval Entries";
            //     RunPageLink = "Document No." = field("No.");
            //     Visible = not (Rec.Status = Rec.Status::Open);
            // }
            // action("Request Approval")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = SendApprovalRequest;
            //     Visible = Rec.Status = Rec.Status::Open;

            //     trigger OnAction()
            //     begin
            //         If ApprovalsMgmt.CheckMaintenanceRequestsWorkflowEnable(Rec) then
            //             ApprovalsMgmt.OnSendMaintenanceRequestForApproval(Rec);
            //     end;
            // }
            // action("Cancel Approval")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = CancelApprovalRequest;
            //     Visible = Rec.Status = Rec.Status::Pending;

            //     trigger OnAction()
            //     begin
            //         ApprovalsMgmt.OnCancelMaintenanceRequestForApproval(Rec);
            //     end;
            // }
            // action("Re-Open")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = ReOpen;
            //     Visible = (Rec.Status = Rec.Status::Cancelled);

            //     trigger OnAction()
            //     var
            //         SuccessMsg: Label 'The Document has been re-openned successfully';
            //     begin
            //         Rec.Status := Rec.Status::Open;
            //         Rec.Modify();
            //         Message(SuccessMsg);
            //         CurrPage.Update();
            //     end;
            // }

        }
    }

    var
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
}
