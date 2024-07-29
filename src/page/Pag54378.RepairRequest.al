page 54378 "Repair Request"
{
    Caption = 'Repair Request';
    PageType = Card;
    SourceTable = "Repair Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = Rec.Status::Open;
                field("No.";
                Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field("Facility Name"; Rec."Facility No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facility No. field.';
                }

                field("Faculty Description"; Rec."Facility Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facilty Description field.';
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Request Date field.';
                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                // field("VoIP No"; Rec."VoIP No")
                // {
                //     ApplicationArea = All;
                // }
                // field("Repair Description"; Rec."Repair Description")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Repair Description field.';
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
            group("Repair Date")
            {
                Editable = Rec.Status = Rec.Status::Open;
                Visible = false;
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repair Period"; Rec."Repair Period")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(RRL; "RepairRequest Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
                Editable = Rec.Status = Rec.Status::Open;
            }
            part(MO; "Maintenance Officers")
            {
                Caption = 'Head Of Estates';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Repair No." = field("No.");
                Visible = not (Rec.Status = Rec.Status::Open);
            }

        }
    }
    actions
    {
        area(Processing)
        {

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
            action("Request Approval")
            {
                Caption = 'Submit for assignment ';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = SendApprovalRequest;
                Visible = (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                var
                    suggmessage: Label 'Repair request have been fully confirmed and moved for assignment request list';
                begin
                    rec.Status := rec.Status::Approved;
                    rec.Modify();
                    Message(suggmessage);
                    CurrPage.Update();

                    // If ApprovalsMgmt.CheckRepairRequestsWorkflowEnable(Rec) then
                    //     ApprovalsMgmt.OnSendRepairRequestForApproval(Rec);

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
                    ApprovalsMgmt.OnCancelRepairRequestForApproval(Rec);
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = ReOpen;
                Visible = (Rec.Status = Rec.Status::Closed) or (Rec.Status = Rec.Status::Rejected);

                trigger OnAction()
                var
                    SuccessMsg: Label 'The Document has been re-openned successfully';
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    Message(SuccessMsg);
                    CurrPage.Update();
                end;
            }
            action("Complete and Close")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Image = Closed;
                Visible = (Rec.Status = Rec.Status::Approved);

                trigger OnAction()
                var
                    SuccessMsg: Label 'The repair request  has been closed successfully';
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify();
                    Message(SuccessMsg);
                    CurrPage.Update();
                end;
            }

        }

    }
    trigger OnOpenPage()
    begin

        /* if (Rec.Status <> Rec.Status::Open) or (Rec.Status <> Rec.Status::Approved) then
            CurrPage.Editable := false; */
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgnt. Util.";
}
