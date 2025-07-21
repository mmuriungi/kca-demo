page 50112 "Audit Setup"
{
    Caption = 'Risk Setup';
    PageType = Card;
    SourceTable = "Audit Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Audit Management")
            {
                // Visible = false;
                field("Audit Nos."; Rec."Audit Nos.")
                {
                    ApplicationArea = All;
                }
                field("Consolidation No"; Rec."Consolidation No")
                {
                    ApplicationArea = All;
                }
                field("Department Risk No"; Rec."Department Risk No")
                { 
                    ApplicationArea = All;
                }
                field("Region Risk No"; Rec."Region Risk No")
                { 
                    ApplicationArea = All;
                }
                field("Program Risk No"; Rec."Program Risk No")
                { 
                    ApplicationArea = All;
                }
                field("Audit Notification Nos."; Rec."Audit Notification Nos.")
                {
                    ApplicationArea = All;
                }
                field("Audit Workplan Nos."; Rec."Audit Workplan Nos.")
                {
                    ApplicationArea = All;
                }
                field("Audit Record Requisition Nos."; Rec."Audit Record Requisition Nos.")
                {
                    ApplicationArea = All;
                }
                field("Audit Plan Nos."; Rec."Audit Plan Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Program Nos.';
                }
                field("Audit Report No"; Rec."Audit Report No")
                {
                    ApplicationArea = All;
                }
                field("Audit Period Lines No"; Rec."Audit Period Lines No")
                {
                    ApplicationArea = All;
                }
                field("Risk Exposure Line No"; Rec."Risk Exposure Line No")
                {
                    ApplicationArea = All;
                }
                field("WPO No"; Rec."WPO No")
                {
                    ApplicationArea = All;
                }
                field("WPF No"; Rec."WPF No")
                {
                    ApplicationArea = All;
                }
                field("WPR No"; Rec."WPR No")
                {
                    ApplicationArea = All;
                }
                field("AT No"; Rec."AT No")
                {
                    ApplicationArea = All;
                }
                field("A & D No"; Rec."A & D No")
                {
                    ApplicationArea = All;
                }
                field("Work Paper Nos."; Rec."Work Paper Nos.")
                {
                    ApplicationArea = All;
                }
                field("Audit Report Nos."; Rec."Audit Report Nos.")
                {
                    ApplicationArea = All;
                }
                field("Audit Program Nos."; Rec."Audit Program Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Plan Nos.';
                }
                field("Project Nos."; Rec."Project Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group("Risk Management")
            {

                Caption = 'Risk';
                label(RiskGeneral)
                {
                    Caption = 'General';
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Risk Details Line"; Rec."Risk Details Line")
                {
                    ApplicationArea = All;
                }
                field("CE No"; Rec."CE No")
                {
                    ApplicationArea = All;
                    Caption = 'Causes & Effects No';
                }
                field("Risk Survey Threshold"; Rec."Risk Survey Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Organization Threshold"; Rec."Organization Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Threshold"; Rec."Department Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Project Threshold"; Rec."Project Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Officer Job ID"; Rec."Risk Officer Job ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(RiskNumbering)
                {
                    Caption = 'Numbering';
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Risk Nos."; Rec."Risk Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Reporting Nos."; Rec."Risk Reporting Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Survey Nos."; Rec."Risk Survey Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk KRI Guideline Nos"; Rec."Risk KRI Guideline Nos")
                {
                    ApplicationArea = All;
                }
            }
            group("User Incidences")
            {
                Caption = 'Incident';
                field("Incident Reporting Nos."; Rec."Incident Reporting Nos.")
                {
                    Caption = 'Incident Nos.';
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Email"; Rec."Risk Email")
                {
                    Caption = 'Incident E-Mail';
                    ApplicationArea = Basic, Suite;
                }
                field("Attachment Path"; Rec."Attachment Path")
                {
                    Caption = 'Attachment Path';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Compliance)
            {
                Caption = 'Compliance';
                field("Compliance Nos."; Rec."Compliance Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;


}

