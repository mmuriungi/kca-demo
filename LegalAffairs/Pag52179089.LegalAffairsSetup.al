page 52179089 "Legal Affairs Setup"
{
    PageType = Card;
    SourceTable = "Legal Affairs Setup";
    Caption = 'Legal Affairs Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Case Nos."; Rec."Case Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for legal cases.';
                }
                field("Document Nos."; Rec."Document Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for legal documents.';
                }
                field("Legal Invoice Nos."; Rec."Legal Invoice Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for legal invoices.';
                }
                field("Compliance Task Nos."; Rec."Compliance Task Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for compliance tasks.';
                }
            }
            
            group(Notifications)
            {
                Caption = 'Notifications';
                
                field("Contract Expiry Alert Days"; Rec."Contract Expiry Alert Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies days before contract expiry to send alerts.';
                }
                field("Deadline Alert Days"; Rec."Deadline Alert Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies days before deadline to send alerts.';
                }
                field("Court Date Reminder Days"; Rec."Court Date Reminder Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies days before court date to send reminders.';
                }
                field("Enable Email Notifications"; Rec."Enable Email Notifications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if email notifications are enabled.';
                }
                field("Legal Department Email"; Rec."Legal Department Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the legal department email address.';
                }
            }
            
            group(Defaults)
            {
                Caption = 'Defaults';
                
                field("Default Document Storage Path"; Rec."Default Document Storage Path")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default document storage path.';
                }
                field("Risk Assessment Period"; Rec."Risk Assessment Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default risk assessment period.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Test Email")
            {
                ApplicationArea = All;
                Caption = 'Test Email';
                Image = Email;
                ToolTip = 'Send a test email to verify configuration.';
                
                trigger OnAction()
                begin
                    SendTestEmail();
                end;
            }
        }
    }
    
    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
    
    local procedure SendTestEmail()
    begin
        if Rec."Legal Department Email" = '' then
            Error('Please specify Legal Department Email');
            
        Message('Test email functionality would be implemented here.');
    end;
}