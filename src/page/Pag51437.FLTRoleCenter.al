page 51437 "FLT-Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part(Control8; "FLT-Cue")
            {
                Caption = 'Fleet Management';
                ApplicationArea = All;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }

            part("Head of Department/Faculty/Section"; "Approvals Activities One")
            {
                ApplicationArea = Suite;
            }
            part("Registra (Vice-chancellor's Office)"; "Approvals Activities Three")
            {
                ApplicationArea = Suite;
            }
            part(TOFF; "Approvals Activities Two")
            {
                ApplicationArea = Suite;
            }


        }
    }

    actions
    {
        area(Embedding)
        {
            action("Workflow Setup")
            {
                Image = CreateWorkflow;
                ApplicationArea = All;
                RunObject = page "Transport Approval Setup";
            }
        }
        area(processing)
        {
            group(Reports)
            {
                Caption = 'FLT Reports';
                Image = SNInfo;
            }
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
                Image = "Report";

                RunObject = Report "FLT Daily Work Ticket";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
            group(Vehicle_Man)
            {
                Caption = 'Vehicle Management';
                Image = AnalysisView;
                action("Vehicle Card")
                {
                    Caption = 'Vehicle Card';
                    Image = Register;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Vehicle Card List";
                }
                action("Active Drivers")
                {
                    Caption = 'Active Drivers';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Driver List";
                    RunPageView = where(Active = const(true));
                }
                action("Inactive Drivers")
                {
                    Caption = 'Inactive Drivers';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Driver List";
                    RunPageView = where(Active = const(false));
                }
            }
            group(Transport_re)
            {
                Caption = 'Transport Requisitions';
                Image = Travel;
                action("Transport Requisition")
                {
                    Caption = 'Transport Requisitions';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action("Submitted Transport Requisition")
                {
                    Caption = 'Submitted Transport Requisition';
                    RunObject = Page "FLT-Submitted Transport List";
                    ApplicationArea = All;
                }
                action("Approved Transport Requisition")
                {
                    Caption = 'Approved Transport Requisition';
                    RunObject = Page "FLT-Approved transport Req";
                    ApplicationArea = All;
                }
                action("Closed Transport Requisition")
                {
                    Caption = 'Closed Transport Requisition';
                    RunObject = Page "FLT-Transport - Closed List";
                    ApplicationArea = All;
                }
                action(Places)
                {
                    Visible = false;
                    Caption = 'Transport Places';
                    RunObject = page "FLT-Transport Places";
                    ApplicationArea = All;
                }
            }
            group(Safari_Notices)
            {
                Caption = 'Travel Notices';
                Image = ResourcePlanning;
                Visible = false;
                action(Travel_Notices)
                {
                    Caption = 'Travel Notice';
                    Image = Register;

                    RunObject = Page "FLT-Safari Notices List";
                    ApplicationArea = All;
                }
                action("Approved Travel Notices")
                {
                    Caption = 'Approved Travel Notices';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Posted Safari Notices List";
                }
            }
            group("Transport Schedules")
            {
                Caption = 'Transport Schedule';
                action("Trip Schedule")
                {
                    Caption = 'Drivers Trip Schedule';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "Trip Schedule List";
                }
                action("Repair and Maintance Schedule")
                {
                    Caption = 'Repair and Maintance Schedule';
                    Image = History;
                    ApplicationArea = All;
                    Visible = false;
                    RunObject = Page "Repair Maint Schedule list";
                }


            }
            group("Fuel Consumption")
            {
                Caption = 'Fuel Consumption';
                Image = Intrastat;
                action(Fuel_Req)
                {
                    Caption = 'Fuel Consumption(Open)';
                    Image = Register;

                    RunObject = Page "FLT-Fuel Req. List";
                    ApplicationArea = All;
                }
                action(sub_Fuel_Req)
                {
                    Caption = 'Submitted Fuel Requisitions';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Fuel Req. Submitted List";
                }
                action(Unpaid_Fuel_Req)
                {
                    Caption = 'Unpaid Fuel Requisitions';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Fuel Req. Unpaid";
                }
                action(Closed_Fuel_Req)
                {
                    Caption = 'Closed/Paid Fuel Requisitions';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Fuel Req. Closed List";
                }
                action(Batch_fuel_Pay)
                {
                    Caption = 'Batch Fuel Payments';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Fuel Pymnt Batch List";
                }
            }
            group("Work Tickets")
            {
                Caption = 'Work Tickets';
                Image = Marketing;
                action(workTick)
                {
                    Caption = 'Daily Work Tickets';
                    Image = Register;

                    RunObject = Page "FLT-Daily Work Ticket List";
                    ApplicationArea = All;
                }
                action(Closed_Work_Tick)
                {
                    Caption = 'Closed Daily Work Tickets';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Closed Work Ticket List";
                }
            }
            group(Maint_Req)
            {
                Caption = 'Maintenance Request';
                Image = Receivables;
                action(main_Req)
                {
                    Caption = 'Maintenance Request';
                    Image = Register;

                    RunObject = Page "FLT-Maint. Req. List";
                    ApplicationArea = All;
                }
                action(subMmain_Req)
                {
                    Caption = 'Submitted Maintenance Request';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Maint. Req. Sub. List";
                }
                action(Appr_main_Req)
                {
                    Caption = 'Approved Maintenance Request';
                    Image = Register;

                    RunObject = Page "FLT-Approved  Maintenance Req";

                    ApplicationArea = All;
                }
                action(Closed_main_Req)
                {
                    Caption = 'Closed Maintenance Request';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Closed Maint. Req. List";
                }
            }
            group(Setup)
            {
                Caption = 'Setups';
                Image = Setup;
                action(FleetMan_setup)
                {
                    Caption = 'Fleet Mgt Setup';
                    Image = Register;

                    RunObject = Page "FLT-Setup";
                    ApplicationArea = All;
                }
                action(flet_man_app_setup)
                {
                    Caption = 'Fleet Mgt Approval Setup';
                    Image = History;
                    ApplicationArea = All;
                    RunObject = Page "FLT-Approval Setup";
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval Entries';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    Caption = ' Store Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                    ApplicationArea = All;
                }
                action("Purchase Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Internal purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "FIN-Imprests List";
                    ApplicationArea = All;
                }
                action("Leave Applications")
                {
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                    ApplicationArea = All;
                }
                action("My Approved Leaves")
                {
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "HRM-My Approved Leaves List";
                    ApplicationArea = All;
                }
                action("Page FLT Transport Requisition2")
                {
                    Caption = 'Transport Requisition';
                    RunObject = Page "FLT-Transport Req. List";
                    ApplicationArea = All;
                }
                action(Travel_Notices2)
                {
                    Caption = 'Travel Notice';
                    Image = Register;

                    RunObject = Page "FLT-Safari Notices List";
                    ApplicationArea = All;
                }

            }
        }
    }
}

