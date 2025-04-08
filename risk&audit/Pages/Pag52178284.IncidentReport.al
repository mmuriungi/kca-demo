page 50121 "Incident Report"
{
    PageType = Card;
    SourceTable = "User Support Incident";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Incident Reference"; Rec."Incident Reference")
                {
                    Caption = 'No.';
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                label("Raised By:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
                field(User; Rec.User)
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("User email Address"; Rec."User email Address")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                }
                label("Description:")
                {

                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
                field("Incidence Location Name"; Rec."Incidence Location Name")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Incidence Location';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Incident Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; Rec."Incident Description")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; Rec."Incident Status")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("System Support Email Address"; Rec."System Support Email Address")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field(Sent; Rec.Sent)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Incident Cause"; Rec."Incident Cause")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("Action taken"; Rec."Action taken")
                {
                    Enabled = Rec.Status = Rec.Status::Pending;
                    ApplicationArea = Basic, Suite;
                }
                field(Priority; Rec.Priority)
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("User Remarks"; Rec."User Remarks")
                {
                    Enabled = Rec.Status = Rec.Status::Open;
                    Caption = 'Recommendation';
                    MultiLine = true;
                }
                field("Incident Rating"; Rec."Incident Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Image:"; Rec."Screen Shot")
                {
                    Caption = 'Image';
                }
                field("Linked Risk"; Rec."Linked Risk")
                {
                    ApplicationArea = All;
                }
                field("Linked Risk Description"; Rec."Linked Risk Description")
                {
                    
                }
                field("Rejection reason"; Rec."Rejection reason")
                {
                    Enabled = Rec.Status = Rec.Status::Pending;
                }
            }
        }
        area(FactBoxes)
        {
            systempart("Links"; Links)
            {
            }

        }
    }

    actions
    {
        area(processing)
        {
            group("Attachments")
            {
                action("Upload Document")
                {
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Upload documents for the record.';

                    trigger OnAction()
                    var
                    begin
                        //FromFile := DocumentManagement.UploadDocument("Incident Reference", CurrPage.Caption, RecordId);
                    end;
                }
                action("Clear Screenshot")
                {
                    //Image = delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                    begin
                        Rec.CalcFields("Screen Shot");
                        clear(Rec."Screen Shot");
                        Rec.Modify();
                    end;
                }
            }
            action("Incident Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Incident.RESET;
                    Incident.SETRANGE("Incident Reference", Rec."Incident Reference");
                    REPORT.RUN(Report::"Incident Report", TRUE, FALSE, Incident);
                end;
            }
            action("Send Incident")
            {
                Visible = Rec.Status = Rec.Status::Open;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                var
                    Text0001: Label 'Do you want to Send the Incident %1?';
                begin
                    // if Confirm(Text0001, false, "Incident Reference") then
                    //     AuditMgt.SendRiskIncident("Incident Reference");
                end;
                //exit(true);
            }
            action("Solve")
            {
                Visible = (Rec.Status = Rec.Status::Pending) OR (Rec.Status = Rec.Status::Escalated);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Solved;
                    Rec."Action Date" := Today;
                    Rec."Incident Status" := Rec."Incident Status"::Resolved;
                    Rec.Modify(true);
                end;
            }
            action("Escalate")
            {
                Visible = Rec.Status = Rec.Status::Pending;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Escalated;
                    Rec.Modify(true);
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Incident';
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                begin
                    if Rec."Rejection Reason" = '' then
                        Error('Please input reject reason');
                    AuditMgt.NotifyIncidSenderOnChanges(Rec);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.CLOSE;
                end;
            }
            action("Close")
            {
                Visible = (Rec.Status = Rec.Status::Pending) OR (Rec.Status = Rec.Status::Escalated) OR (Rec.Status = Rec.Status::Solved);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify(true);
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::AUDIT;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Linked Risk Description");
        "Linked Risk Description".CREATEINSTREAM(Instr);
        RiskNote.READ(Instr);
        RiskNotesText := FORMAT(RiskNote);
    end;

    var
        Incident: Record "User Support Incident";
        AuditMgt: Codeunit "Internal Audit Management";
        DocumentManagement: Codeunit "Document Management";
        FromFile: Text;
        RiskNote: BigText;
        RiskNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
}

