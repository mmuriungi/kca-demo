page 52178274 "Audit Setup"
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
                field("Audit Nos."; "Audit Nos.")
                {
                }
                field("Consolidation No"; "Consolidation No")
                {

                }
                field("Department Risk No"; "Department Risk No")
                { }
                field("Region Risk No"; "Region Risk No")
                { }
                field("Program Risk No"; "Program Risk No")
                { }
                field("Audit Notification Nos."; "Audit Notification Nos.")
                {
                }
                field("Audit Workplan Nos."; "Audit Workplan Nos.")
                {
                }
                field("Audit Record Requisition Nos."; "Audit Record Requisition Nos.")
                {
                }
                field("Audit Plan Nos."; "Audit Plan Nos.")
                {
                    Caption = 'Audit Program Nos.';
                }
                field("Audit Report No"; "Audit Report No")
                {
                    ApplicationArea = All;
                }
                field("Audit Period Lines No"; "Audit Period Lines No")
                {
                    ApplicationArea = All;
                }
                field("Risk Exposure Line No"; "Risk Exposure Line No")
                {

                }
                field("WPO No"; "WPO No")
                {

                }
                field("WPF No"; "WPF No")
                {

                }
                field("WPR No"; "WPR No")
                {

                }
                field("AT No"; "AT No")
                {

                }
                field("A & D No"; "A & D No")
                {

                }
                field("Work Paper Nos."; "Work Paper Nos.")
                {
                }
                field("Audit Report Nos."; "Audit Report Nos.")
                {
                }
                field("Audit Program Nos."; "Audit Program Nos.")
                {
                    Caption = 'Audit Plan Nos.';
                }
                field("Project Nos."; "Project Nos.")
                {
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
                field("Risk Details Line"; "Risk Details Line")
                {

                }
                field("CE No"; "CE No")
                {
                    Caption = 'Causes & Effects No';
                }
                field("Risk Survey Threshold"; "Risk Survey Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Organization Threshold"; "Organization Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Threshold"; "Department Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Project Threshold"; "Project Threshold")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Officer Job ID"; "Risk Officer Job ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                label(RiskNumbering)
                {
                    Caption = 'Numbering';
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                }
                field("Risk Nos."; "Risk Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Reporting Nos."; "Risk Reporting Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Survey Nos."; "Risk Survey Nos.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Risk KRI Guideline Nos"; "Risk KRI Guideline Nos")
                {
                    ApplicationArea = All;
                }
            }
            group("User Incidences")
            {
                Caption = 'Incident';
                field("Incident Reporting Nos."; "Incident Reporting Nos.")
                {
                    Caption = 'Incident Nos.';
                    ApplicationArea = Basic, Suite;
                }
                field("Risk Email"; "Risk Email")
                {
                    Caption = 'Incident E-Mail';
                    ApplicationArea = Basic, Suite;
                }
                field("Attachment Path"; "Attachment Path")
                {
                    Caption = 'Attachment Path';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Compliance)
            {
                Caption = 'Compliance';
                field("Compliance Nos."; "Compliance Nos.")
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
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;


}

