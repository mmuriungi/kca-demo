pageextension 50108 "IT Manager Ext" extends "Administrator Role Center"
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
    }
}
