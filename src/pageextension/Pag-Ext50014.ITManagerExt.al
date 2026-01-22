pageextension 50014 "IT Manager Ext" extends "Administrator Role Center"
{
    layout
    {

    }
    actions
    {
        addafter("P&urchase Analysis")
        {
            group("Common Requisition")
            {
                Caption = 'Common Requisition';
                Image = Documents;

                action("Stores Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Internal Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }
                action("Imprest  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprests List";
                    ToolTip = 'Create Imprest requisition from Users.';
                }
                action("Claim  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Claim Requisitions';
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Create Claim requisition from Users.';
                }
                action("Leave  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Leave Requisitions';
                    RunObject = Page "HRM-Leave Requisition List";
                    ToolTip = 'Create Leave requisition from Users.';
                }
                action("File  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'File Requisitions';
                    RunObject = Page "REG-Registry Files View";
                    ToolTip = 'Create File requisition from Users.';

                }
                action("Meal Booking")
                {
                    ApplicationArea = Suite;
                    Caption = 'Meal Booking';
                    RunObject = Page "Booking Items";
                    ToolTip = 'Create File requisition from Users.';

                }


            }
        }
        addafter("&Change Setup")
        {
            group("Notification Setup")
            {
                action("Automated Notifications")
                {
                    ApplicationArea = Suite;
                    Caption = 'Automated Notifications';
                    RunObject = Page "Automated Notification Setup";
                    Image = Setup;

                }
            }
            group("SMS Management")
            {
                Caption = 'SMS Management';
                Image = Communication;
                action("SMS Campaigns")
                {
                    ApplicationArea = All;
                    Caption = 'SMS Campaigns';
                    Image = EmailTemplate;
                    RunObject = Page "SMS Campaign List";
                    ToolTip = 'Manage SMS campaigns and bulk messaging.';
                }
                action("Send Bulk SMS")
                {
                    ApplicationArea = All;
                    Caption = 'Send Bulk SMS';
                    Image = SendMail;
                    RunObject = Page "SMS Campaign Card";
                    RunPageMode = Create;
                    ToolTip = 'Create and send bulk SMS campaigns.';
                }
                action("SMS Log")
                {
                    ApplicationArea = All;
                    Caption = 'SMS Log';
                    Image = Log;
                    RunObject = Page "GEN-SMS_Master List";
                    ToolTip = 'View SMS sending history and logs.';
                }
            }
        }
    }
}
