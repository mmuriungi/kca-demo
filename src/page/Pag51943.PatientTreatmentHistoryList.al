page 52124 "Patient Treatment History List"
{
    ApplicationArea = All;
    Caption = 'Patient Treatment History';
    PageType = List;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = WHERE(Status = FILTER(Completed));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Treatment date';
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Treatment time';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Patient name';
                }
                field("Signs and Symptoms"; GetSymptomsText())
                {
                    ApplicationArea = All;
                    Caption = 'Signs & Symptoms';
                    ToolTip = 'Signs and symptoms recorded';
                }
                field("Examination Findings"; Rec."Examination Findings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Examination findings';
                }
                field("Vital Signs"; Rec."Vital Signs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vital signs recorded';
                }
                field("Treatment Given"; GetTreatmentText())
                {
                    ApplicationArea = All;
                    Caption = 'Treatment Given';
                    ToolTip = 'Treatment and medications given';
                }
                field("Diagnosis"; GetDiagnosisText())
                {
                    ApplicationArea = All;
                    Caption = 'Diagnosis';
                    ToolTip = 'Diagnosis made';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Doctor who provided treatment';
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of treatment';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("View Treatment Details")
            {
                ApplicationArea = All;
                Caption = 'View Treatment Details';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(Page::"HMS-Treatment Form Header", Rec);
                end;
            }
            action("Patient Card")
            {
                ApplicationArea = All;
                Caption = 'Patient Card';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Patient: Record "HMS-Patient";
                begin
                    if Patient.Get(Rec."Patient No.") then
                        Page.Run(Page::"HMS-Patient Card", Patient);
                end;
            }
        }
        area(reporting)
        {
            action("Treatment History Report")
            {
                ApplicationArea = All;
                Caption = 'Treatment History Report';
                Image = Report;

                trigger OnAction()
                begin
                    // Generate treatment history report for this patient
                    Message('Treatment history report functionality will be implemented');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.GetFilter("Patient No.") = '' then begin
            Message('This page is intended to show treatment history for a specific patient. Please set a patient filter.');
        end;
    end;

    local procedure GetSymptomsText(): Text
    begin
        // Placeholder for symptoms retrieval
        exit('Symptoms will be retrieved from related records');
    end;

    local procedure GetTreatmentText(): Text
    var
        TreatmentDrug: Record "HMS-Treatment Form Drug";
        TreatmentText: Text;
    begin
        TreatmentDrug.SetRange("Treatment No.", Rec."Treatment No.");
        if TreatmentDrug.FindSet() then begin
            repeat
                if TreatmentText <> '' then
                    TreatmentText := TreatmentText + '; ';
                TreatmentText := TreatmentText + TreatmentDrug."Drug Name" + ' (' + Format(TreatmentDrug.Quantity) + ')';
            until TreatmentDrug.Next() = 0;
        end;
        exit(TreatmentText);
    end;

    local procedure GetDiagnosisText(): Text
    var
        Diagnosis: Record "HMS-Treatment Form Diagnosis";
        DiagnosisText: Text;
    begin
        Diagnosis.SetRange("Treatment No.", Rec."Treatment No.");
        if Diagnosis.FindSet() then begin
            repeat
                if DiagnosisText <> '' then
                    DiagnosisText := DiagnosisText + '; ';
                DiagnosisText := DiagnosisText + Diagnosis."Diagnosis Name";
            until Diagnosis.Next() = 0;
        end;
        exit(DiagnosisText);
    end;
}