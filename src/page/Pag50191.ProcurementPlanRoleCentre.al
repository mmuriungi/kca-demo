page 50191 "Procurement Plan Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Sections)
            {

                systempart(Outlook; Outlook)
                {
                }
            }
            group(Notes)
            {
                systempart(Links; Links)
                {
                }
                systempart(MyNotes; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Outbound)
            {
                Caption = 'WP Report';
                Image = "Report";

                RunObject = Report 50123;
            }
            action(Inbound_Rep)
            {
                Caption = 'Export Budget to Excel';
                Image = Report2;

                RunObject = Report 50125;
            }
            action(Reg_Files)
            {
                Caption = 'Import Budget to Excel';
                Image = "Report";

                RunObject = Report 50122;
            }
        }
        area(sections)
        {
            group("Procurement Plan")
            {
                Caption = 'Procurement Plan';
                Image = Purchasing;
                action("Workplan List")
                {
                    Caption = 'Workplan List';
                    Image = Worksheet;
                    ApplicationArea = All;
                    RunObject = Page 50156;
                }
                action("Workplan Card")
                {
                    Caption = 'Workplan Card';
                    RunObject = Page 50164;
                }
                action("Budget Workplan Names")
                {
                    Caption = 'Budget Workplan Names';
                    RunObject = Page 50163;
                }
                action("Procurement Method")
                {
                    Caption = 'Procurement Methods';
                    RunObject = Page 50169;
                }
                action("Workplan Activities")
                {
                    Caption = 'Workplan Activities';
                    RunObject = Page 50157;
                }
            }
            group(__)
            {
                Caption = 'Budget Workplan';
                Image = Reconcile;
                action("Budget)")
                {
                    Caption = 'Budget Workplan';
                    RunObject = Page 50161;
                }
                action(WorkPlan_Creation)
                {
                    Caption = 'WorkPlan Creation';
                    RunObject = Page 50165;
                }
                //     action(Released)
                //     {
                //         Caption = 'Released';
                //         RunObject = Page 68256;
                //     }
                // }
                group(Tendering)
                {
                    Caption = 'Tendering';
                    //Image =Capacities;
                    action("Tendering process")
                    {
                        Caption = 'Tendering';
                        RunObject = Page "Tender Plan List";
                    }
                    action("Tender Plan")
                    {
                        Image = Register;
                        ApplicationArea = All;
                        RunObject = Page 50170;
                    }

                    group(DisposalPlanning)
                    {
                        Caption = 'Disposal Plan';
                        action("Disposal Planning")
                        {
                            Caption = 'Disposal Method';
                            RunObject = Page 50235;
                        }
                        action("Disposal Period")
                        {
                            Caption = 'Disposal Period';
                            RunObject = Page 50234;
                        }
                        action("Disposal Plan")
                        {
                            Caption = 'Disposal List';
                            RunObject = Page 50230;
                        }
                        action("Disposal Plan List")
                        {
                            Caption = 'Disposal Plan List';
                            RunObject = Page 50237;
                        }

                    }
                    group(Approvals)
                    {
                        Caption = 'Approvals';

                        action("Pending My Approval")
                        {
                            Caption = 'Pending My Approval';
                            RunObject = Page "Approval Entries";
                        }
                        action("My Approval requests")
                        {
                            Caption = 'My Approval requests';
                            RunObject = Page "Approval Request Entries";
                        }

                    }

                }
            }
        }
    }
}