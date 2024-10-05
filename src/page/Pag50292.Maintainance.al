page 50292 Maintainance
{
    ApplicationArea = All;
    Caption = 'Maintainance';
    PageType = RoleCenter;

    layout
    {
        area(Content)
        {
            part(Headline; "Headline RC Team Member")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group("Repair Requests")
            {
                action("Pending Assigning")
                {
                    caption = 'Open Request';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Repair Requests";
                    RunPageLink = Status = const(Open);
                }
                // action(" Pending approval")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Repair Requests";
                //     RunPageLink = Status = const(Pending);
                // }
                action("Approved")
                {
                    Caption = 'Pending Assignment ';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Repair Requests";
                    RunPageLink = Status = const(Approved);
                }
                action("Underway")
                {
                    Caption = 'Maintainance Officer Assigned';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "MO Repair Requests";
                    RunPageLink = Status = const(Approved);
                }
                action("Closed")
                {
                    Caption = 'Completed';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "maintenance request list";
                    RunPageLink = Completed = const(true);
                }
                action("Client Closed")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "maintenance request list";
                    RunPageLink = "client Closed" = const(true);
                }
                action("Closed Repair Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Repair Requests";
                    RunPageLink = Status = const(Closed);
                }
                // action("Cancelled")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Repair Requests";
                //     RunPageLink = Status = const(Cancelled);
                // }
                // // action("Completed")
                // // {
                // //     ApplicationArea = Basic, Suite;
                // //     RunObject = page "Repair Requests";
                // //     RunPageLink = Status = const(Completed);
                // // }
                // action("&All Requests")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Repair Requests";
                //     RunPageLink = Status = filter(Open | Pending | Approved | Cancelled | Completed | Closed | Rejected | Scheduled);
                // }
            }

            group("Maintenance Requests")
            {
                //Visible = false;
                action("Open Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Requests";
                    RunPageLink = Status = const(Open);
                }
                // action("Pending Requests")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Maintenance Requests";
                //     RunPageLink = Status = const(Pending);
                // }
                action("Classified  Request")
                {
                    Caption = 'unClassified  Requests';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Requests";
                    RunPageLink = Status = const(unClassified);
                }
                action("Classified Maintenance Request")
                {
                    Caption = 'Classified Maintenance Request';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Requests";
                    RunPageLink = "Type Of Request" = const(Maintenance);
                }
                action("Classified repair Request")
                {
                    Caption = 'Classified Repair Request';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Requests";
                    RunPageLink = "Type Of Request" = const(Repair);
                }
                action("All Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Requests";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled | Completed | Closed | Rejected | Scheduled);
                }
                // action("Posted Requests")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Maintenance Requests";
                //     RunPageLink = Status = const(Posted);
                // }
                // action("Cancelled Requests")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Maintenance Requests";
                //     RunPageLink = Status = const(Cancelled);
                // }
                // action("Rejected Requests")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Maintenance Requests";
                //     RunPageLink = Status = const(Rejected);
                // }

            }
            group("Maintenance Schedules")
            {

                action("Scheduled Requests")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Requests";
                    RunPageLink = Status = const(Scheduled);
                }
                // action("Completed Requests")
                // {
                //     ApplicationArea = Basic, Suite;
                //     RunObject = page "Maintenance Requests";
                //     RunPageLink = Status = const(Completed);
                // }

                action("Open Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = const(Open);
                }
                action("Pending Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = const(Pending);
                }
                action("Approved Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = const(Approved);
                }
                action("Closed Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = const(Closed);
                }
                action("Cancelled Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = const(Cancelled);
                }
                action("Completed Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = const(Completed);
                }
                action("All Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Maintenance Schedules";
                    RunPageLink = Status = filter(Open | Pending | Approved | Cancelled | Completed | Closed);
                }
                group("Utility Bills")
                {
                    group("Internal Bills")
                    {
                        action("Open Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Open), "Bill Type" = const(Internal);
                        }
                        action("Pending Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Pending), "Bill Type" = const(Internal);
                        }
                        action("Approved Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Approved), "Bill Type" = const(Internal);
                        }
                        action("Cancelled Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Cancelled), "Bill Type" = const(Internal);
                        }
                        action("All Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = filter(Open | Pending | Approved | Cancelled), "Bill Type" = const(Internal);
                        }
                    }
                    group("External Bills")
                    {
                        Visible = false;
                        action("&Open Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Open), "Bill Type" = const(External);
                        }
                        action("&Pending Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Pending), "Bill Type" = const(External);
                        }
                        action("&Approved Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Approved), "Bill Type" = const(External);
                        }
                        action("&Cancelled Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = const(Cancelled), "Bill Type" = const(External);
                        }
                        action("&All Bills")
                        {
                            ApplicationArea = Basic, Suite;
                            RunObject = page "Utility Bills";
                            RunPageLink = Status = filter(Open | Pending | Approved | Cancelled), "Bill Type" = const(External);
                        }
                    }
                }
                group("Projects Designs")
                {
                    action("&Open")
                    {
                        Caption = 'Project Design';
                        ApplicationArea = Basic, Suite;
                        RunObject = page Projects;
                        RunPageLink = Status = const(Open);
                    }
                    action("&Pending")
                    {
                        Caption = 'Pending Project Design';
                        ApplicationArea = Basic, Suite;
                        RunObject = page Projects;
                        RunPageLink = Status = const(Pending);
                    }
                    action("&Approved")
                    {
                        Caption = 'Approved Project Design';
                        ApplicationArea = Basic, Suite;
                        RunObject = page Projects;
                        RunPageLink = Status = const(Approved);
                    }
                    action("&Cancelled")
                    {
                        Caption = 'Cancelled Project Design';
                        ApplicationArea = Basic, Suite;
                        RunObject = page Projects;
                        RunPageLink = Status = const(Cancelled);
                    }
                }
                group("Active Projects")
                {
                    action("Approved projects")
                    {
                        Caption = 'Approved Project Designs';
                        ApplicationArea = Basic, Suite;
                        RunObject = page Projects;
                        RunPageLink = Status = const(Approved);
                    }
                    action("Projects In-Progress ")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page Projects;
                        RunPageLink = Status = filter(InProgress);
                    }

                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';

                action("Stores Requisitions")
                {
                    Caption = 'Stores Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
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
                action("Meal Booking")
                {
                    Caption = 'Meal Booking';
                    ApplicationArea = All;
                    RunObject = Page "CAT-Meal Booking List";
                }

                action("File Requisitions")
                {
                    Image = Register;
                    ApplicationArea = All;
                    RunObject = Page "REG-File Requisition List";
                }
                action("Purchase Requisition Header")
                {
                    Caption = 'Purchase Requisition';
                    RunObject = page "Purchase Requisition Header";
                    ApplicationArea = All;
                }

            }

        }
        area(Processing)
        {
            group(Setups)
            {
                action(General)
                {
                    ApplicationArea = Basic, Suite;
                    Image = GainLossEntries;
                    RunObject = page "Estate Setups";
                }
                action("Types of Repairs")
                {
                    ApplicationArea = Basic, Suite;
                    Image = AccountingPeriods;
                    RunObject = page "Repair Types";
                }
                action("Notify HoDs ")
                {
                    ApplicationArea = Basic, Suite;
                    Image = AccountingPeriods;
                    //RunObject = page "Repair Types";
                }
            }
        }
        area(Reporting)
        {
            group("Reports")
            {
                action(Repairs)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Report;
                    RunObject = report "Repair Requests";
                }
                action("Repairs Types")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Report2;
                    RunObject = report "Repair Requests";
                }
            }
        }
    }
}
