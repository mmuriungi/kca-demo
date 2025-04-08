page 50020 "Audit Plan"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                }
                field("Audit Manager Name"; "Audit Manager Name")
                {
                    Editable = false;
                }
                field("Audit Manager Email"; "Audit Manager Email")
                {
                    Editable = false;
                }
                label("Cut Off Period:")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Cut Off Start Date"; Rec."Cut Off Start Date")
                {
                }
                field("Cut Off End Date"; Rec."Cut Off End Date")
                {
                }
                field("Audit Status"; Rec."Audit Status")
                {
                    Editable = false;
                }
            }
            part(Control13; "Audit Plan SubForm")
            {
                SubPageLink = "Document No." = FIELD("No."), "Audit Line Type" = CONST("Audit Plan");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Plan)
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditHeader.RESET;
                    AuditHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(Report::"Audit Plan 2", TRUE, FALSE, AuditHeader);
                end;
            }
            action("Send Audit Committee")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec."Audit Stage" = Rec."Audit Stage"::new;
                trigger OnAction()
                begin
                    IF Rec."Audit Stage" = Rec."Audit Stage"::New THEN begin
                        Rec."Audit Stage" := Rec."Audit Stage"::Committee;
                        Message('Sent To Committee Successfully');
                        CurrPage.Close();
                    end;
                    Rec.Modify(true);
                end;

            }
            action("Final Approval")
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Audit Stage" = Rec."Audit Stage"::Committee;
                trigger OnAction()
                var
                    Employee: Record Employee;
                begin
                    IF Rec."Audit Stage" = Rec."Audit Stage"::Committee THEN begin
                        Rec."Audit Stage" := Rec."Audit Stage"::Council;
                        Message('Sent To Board Successfully');
                        CurrPage.Close();
                        // if Confirm('Do you want to notify CEO on the plan created?', false) = true then begin
                        //     Rec.FnSendAuditPlanNotification(Rec);
                    end;

                    Rec.Modify(true);
                end;


            }


        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;

    var
        AuditHeader: Record "Audit Header";
}

