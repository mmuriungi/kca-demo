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
                field("Incident Reference"; "Incident Reference")
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
                field(User; User)
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("User email Address"; "User email Address")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No"; "Employee No")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; "Employee Name")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
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
                field("Incidence Location Name"; "Incidence Location Name")
                {
                    Enabled = Status = Status::Open;
                    Caption = 'Incidence Location';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Date"; "Incident Date")
                {
                    Enabled = Status = Status::Open;
                    Caption = 'Incident Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Time"; "Incident Time")
                {
                    Enabled = Status = Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Description"; "Incident Description")
                {
                    Enabled = Status = Status::Open;
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Incident Status"; "Incident Status")
                {
                    Enabled = false;
                    ApplicationArea = Basic, Suite;
                }
                field("System Support Email Address"; "System Support Email Address")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                    Visible = false;
                }
                field(Sent; Sent)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Incident Cause"; "Incident Cause")
                {
                    Enabled = Status = Status::Open;
                    ApplicationArea = Basic, Suite;
                    MultiLine = true;
                }
                field("Action taken"; "Action taken")
                {
                    Enabled = Status = Status::Pending;
                    ApplicationArea = Basic, Suite;
                }
                field(Priority; Priority)
                {
                    Enabled = Status = Status::Open;
                    ApplicationArea = Basic, Suite;
                }
                field("User Remarks"; "User Remarks")
                {
                    Enabled = Status = Status::Open;
                    Caption = 'Recommendation';
                    MultiLine = true;
                }
                field("Incident Rating"; "Incident Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field("Image:"; "Screen Shot")
                {
                    Caption = 'Image';
                }
                field("Linked Risk"; "Linked Risk")
                {
                    ApplicationArea = All;
                }
                field("Linked Risk Description"; "Linked Risk Description")
                {
                    trigger OnValidate()
                    begin
                        CALCFIELDS("Linked Risk Description");
                        "Linked Risk Description".CREATEINSTREAM(Instr);
                        RiskNote.READ(Instr);

                        IF RiskNotesText <> FORMAT(RiskNote) THEN BEGIN
                            CLEAR("Linked Risk Description");
                            CLEAR(RiskNote);
                            RiskNote.ADDTEXT(RiskNotesText);
                            "Linked Risk Description".CREATEOUTSTREAM(OutStr);
                            RiskNote.WRITE(OutStr);
                        END;
                    end;
                }
                field("Rejection reason"; "Rejection reason")
                {
                    Enabled = Status = Status::Pending;
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
                        CalcFields("Screen Shot");
                        clear("Screen Shot");
                        Modify();
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
                    Incident.SETRANGE("Incident Reference", "Incident Reference");
                    REPORT.RUN(Report::"Incident Report", TRUE, FALSE, Incident);
                end;
            }
            action("Send Incident")
            {
                Visible = Status = Status::Open;
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
                Visible = (Status = Status::Pending) OR (Status = Status::Escalated);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Status := Status::Solved;
                    "Action Date" := Today;
                    "Incident Status" := "Incident Status"::Resolved;
                    Modify(true);
                end;
            }
            action("Escalate")
            {
                Visible = Status = Status::Pending;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Status := Status::Escalated;
                    Modify(true);
                end;
            }
            action(Reject)
            {
                Caption = 'Reject Incident';
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = Status = Status::Pending;

                trigger OnAction()
                begin
                    if "Rejection Reason" = '' then
                        Error('Please input reject reason');
                    AuditMgt.NotifyIncidSenderOnChanges(Rec);
                    Status := Status::Open;
                    Modify();
                    CurrPage.CLOSE;
                end;
            }
            action("Close")
            {
                Visible = (Status = Status::Pending) OR (Status = Status::Escalated) OR (Status = Status::Solved);
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Status := Status::Closed;
                    Modify(true);
                end;
            }

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::AUDIT;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::AUDIT;
    end;

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Linked Risk Description");
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

