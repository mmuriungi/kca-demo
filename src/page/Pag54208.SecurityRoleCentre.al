page 54208 "Security Role Centre"
{

    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(REGistry)
            {
                part(Reg_Cue; "FLT-Cue")
                {
                    Caption = 'SECURITY';
                    ApplicationArea = All;
                }
                systempart(Outlook; Outlook)
                {
                    ApplicationArea = All;
                }
            }
            part(HOD; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }

        }
    }

    actions
    {
        area(processing)
        {
            action(Vehicles)
            {
                Caption = 'Vehicle List';
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report "FLT Vehicle List";
            }
            action(Drivers)
            {
                Caption = 'Driver List';
                Image = "Report";
                ApplicationArea = All;
                RunObject = Report "FLT Driver List";
            }
            action(WT)
            {
                Caption = 'Work Ticket';

                ApplicationArea = All;
                RunObject = Page "FLT-Closed Daily Work Ticket";
            }
        }
        area(sections)
        {
            group(Transport)
            {
                action("Approved Transport Requisition")
                {
                    Caption = 'Approved Transport Requisition';
                    RunObject = Page "FLT-Approved transport Req";
                    ApplicationArea = All;
                }
                action("Approved Travel Notices")
                {
                    Caption = 'Approved Travel Notices';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Posted Safari Notices List";
                }
                action(Closed_Work_Tick)
                {
                    Caption = 'Closed Daily Work Tickets';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Closed Work Ticket List";
                }
            }
            group("Visitors")
            {
                Caption = 'Visitor Management';

                action("Visits Ledger")
                {
                    Caption = 'Visitors List';
                    Image = ValueLedger;
                    ApplicationArea = All;
                    RunObject = Page "Visitors List";
                }

                action("Visits History")
                {
                    Caption = 'Visits History';
                    RunObject = Page "Visitors Ledger History";
                    ApplicationArea = All;
                }




            }
            group("Employee Mgt")
            {
                Caption = 'Staffs';
                action("Staff Register")
                {
                    Caption = 'Staffs';
                    RunObject = Page "HRM-Employee List";
                    ApplicationArea = All;
                }

            }
            group(Disciplinary)
            {
                action("HRM-Disciplinary Cases List")
                {
                    RunObject = page "HRM-Disciplinary Cases List";
                    ApplicationArea = All;
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Stores Requisitions';

                    RunObject = Page "PROC-Store Requisition";
                }

                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    Visible = false;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
                action("Claim  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Claim Requisitions';
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Create Claim requisition from Users.';
                }
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }


                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    RunObject = Page "CAT-Meal Booking List";
                    ApplicationArea = All;
                }
                action("Transport Requisition")
                {
                    ApplicationArea = All;
                    Image = MapAccounts;
                    RunObject = Page "FLT-Transport Req. List";
                }
            }
        }
    }
}

