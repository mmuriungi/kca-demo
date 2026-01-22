page 50242 "Audit Plan"
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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Audit Period"; Rec."Audit Period")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Audit Manager"; Rec."Audit Manager")
                {
                    ApplicationArea = All;
                }
                field("Audit Manager Name"; Rec."Audit Manager Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Audit Manager Email"; Rec."Audit Manager Email")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                label("Cut Off Period:")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Cut Off Start Date"; Rec."Cut Off Start Date")
                {
                    ApplicationArea = All;
                }
                field("Cut Off End Date"; Rec."Cut Off End Date")
                {
                    ApplicationArea = All;
                }
                field("Audit Status"; Rec."Audit Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control13; "Audit Plan SubForm")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                Visible = Rec."Audit Stage" = Rec."Audit Stage"::New;
                trigger OnAction()
                begin
                    IF Rec."Audit Stage" = Rec."Audit Stage"::New THEN begin
                        Rec."Audit Stage" := Rec."Audit Stage"::Council;
                        Message('Sent To Committee Successfully');
                        CurrPage.Close();
                    end;
                    Rec.Modify(true);
                end;

            }
            action("Final Approval")
            {
                ApplicationArea = All;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Audit Stage" = Rec."Audit Stage"::Council;
                trigger OnAction()
                var
                    Employee: Record "HRM-Employee C";
                begin
                    IF Rec."Audit Stage" = Rec."Audit Stage"::Council THEN begin
                        Rec."Audit Stage" := Rec."Audit Stage"::Auditor;
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

