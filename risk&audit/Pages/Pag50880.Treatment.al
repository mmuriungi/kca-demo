page 50224 Treatment
{
    Caption = 'Treatment';
    PageType = List;
    SourceTable = Treatment;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Treatment"; Rec."Treatment (risk champion suggestions)")
                {
                    ApplicationArea = All;
                    Caption = 'Treatment';
                }
                field("Action points To have a treatment action plan on the side"; Rec."Action points (risk owner in point form) To have a treatment action plan on the side")
                {
                    ApplicationArea = All;
                    Caption = 'Action points';
                }
                field("Areas to review evidences"; Rec."Areas to review (risk champion)-evidences")
                {
                    ApplicationArea = All;
                    Caption = 'Areas to review evidences';
                }
                field("Responsibility"; Rec."Responsibility (for each action plan)")

                { 
                    ApplicationArea = All;
                    Caption = 'Responsibility'; }
                field("Responsibility Name"; Rec."Responsibility Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Responsibility Name';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Timelines"; Rec."Timelines(when I will be carried out)")
                {
                    ApplicationArea = All;
                    Caption = 'Timelines';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Causes; Rec.Causes)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Effects; Rec.Effects)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

        }
    }
    actions
    {
        area(Processing)
        {
            action("Notify Assigned Employee")
            {
                ApplicationArea = All;
                Caption = 'Notify Assigned Employee';
                Image = ExportSalesPerson;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ObjTreatments: Record Treatment;
                begin

                    ObjTreatments.RESET;
                    ObjTreatments.SETRANGE(ObjTreatments."Entry No.", Rec."Entry No.");
                    if ObjTreatments.findset() then begin
                        ObjTreatments.FnReportTreatment(Rec, ObjTreatments.Email);
                        CurrPage.CLOSE;
                    end

                end;
            }

            action("Upload Documents")
            {
                ApplicationArea = all;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                // Enabled = "Entry No." <> '';

                trigger OnAction()
                var
                    RecRef: RecordRef;
                    PgDocumentAttachment: Page "Document Attachment Custom";
                begin
                    Clear(PgDocumentAttachment);
                    RecRef.GETTABLE(Rec);
                    PgDocumentAttachment.OpenForRecReference(RecRef);
                    //if Status = Status::Released then
                    PgDocumentAttachment.Editable(false);
                    PgDocumentAttachment.RUNMODAL;
                end;

            }

        }
    }
    var
        //  RegistrationMgt: Codeunit "Registration Payment Process";
        ObjCausesEffects: Record "Causes & Effects2";

    trigger OnInit()
    begin
        // ObjCausesEffects.Reset();
        // ObjCausesEffects.SetRange(ObjCausesEffects."Entry No", "Entry No");
        // if ObjCausesEffects.FindFirst() then begin
        //     ObjCausesEffects.Causes := Causes;
        //     ObjCausesEffects.Effects := Effects;
        //     ObjCausesEffects.Modify();
        // end;
    end;

}
