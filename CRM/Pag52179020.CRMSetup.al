page 52179020 "CRM Configuration"
{
    PageType = Card;
    Caption = 'CRM Setup';
    SourceTable = "CRM Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("Number Series")
            {
                Caption = 'Number Series';
                
                field("Customer Nos."; Rec."Customer Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for CRM customers.';
                }
                field("Lead Nos."; Rec."Lead Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for leads.';
                }
                field("Campaign Nos."; Rec."Campaign Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for campaigns.';
                }
                field("Support Ticket Nos."; Rec."Support Ticket Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for support tickets.';
                }
                field("Interaction Nos."; Rec."Interaction Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for customer interactions.';
                }
                field("Transaction Nos."; Rec."Transaction Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for CRM transactions.';
                }
                field("Event Nos."; Rec."Event Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for events.';
                }
                field("Donation Nos."; Rec."Donation Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the number series for donations.';
                }
            }
            
            group("Lead Management")
            {
                Caption = 'Lead Management';
                
                field("Default Lead Score Threshold"; Rec."Default Lead Score Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the default threshold for lead scoring (0-100).';
                }
                field("Auto-Convert Hot Leads"; Rec."Auto-Convert Hot Leads")
                {
                    ApplicationArea = All;
                    ToolTip = 'Automatically convert leads that reach hot status.';
                }
            }
            
            group("Integration")
            {
                Caption = 'Integration Settings';
                
                field("Email Integration Enabled"; Rec."Email Integration Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable email integration for campaigns and communications.';
                }
                field("SMS Integration Enabled"; Rec."SMS Integration Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable SMS integration for campaigns and notifications.';
                }
            }
            
            group("Default Settings")
            {
                Caption = 'Default Settings';
                
                field("Default Campaign Duration"; Rec."Default Campaign Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Default duration for new campaigns in days.';
                }
                field("Support SLA Hours"; Rec."Support SLA Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Default SLA response time for support tickets in hours.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec."Default Lead Score Threshold" := 70;
            Rec."Auto-Convert Hot Leads" := false;
            Rec."Email Integration Enabled" := true;
            Rec."SMS Integration Enabled" := false;
            Rec."Default Campaign Duration" := 30;
            Rec."Support SLA Hours" := 24;
            Rec.Insert();
        end;
    end;
}