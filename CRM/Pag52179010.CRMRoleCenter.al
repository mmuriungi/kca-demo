page 52179010 "CRM Role Center"
{
    PageType = RoleCenter;
    Caption = 'CRM & Marketing';

    layout
    {
        area(rolecenter)
        {
            group("Welcome")
            {
                part("Headline"; "CRM Headline RC")
                {
                    ApplicationArea = All;
                }
            }

            group("Performance")
            {
                part("CRM Performance"; "CRM Performance Part")
                {
                    ApplicationArea = All;
                }
            }

            group("Activities")
            {
                part("CRM Activities"; "CRM Activities Part")
                {
                    ApplicationArea = All;
                }
            }

            group("Analytics")
            {
                part("CRM Charts"; "CRM Charts Part")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Customers")
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "CRM Customer List";
                ToolTip = 'View and manage all CRM customers including prospects, students, alumni, and donors.';
            }

            action("Leads")
            {
                ApplicationArea = All;
                Caption = 'Leads';
                Image = Opportunity;
                RunObject = Page "CRM Lead List";
                ToolTip = 'View and manage sales leads and opportunities.';
            }

            action("Campaigns")
            {
                ApplicationArea = All;
                Caption = 'Campaigns';
                Image = Campaign;
                RunObject = Page "CRM Campaign List";
                ToolTip = 'View and manage marketing campaigns across all channels.';
            }

            action("Support Tickets")
            {
                ApplicationArea = All;
                Caption = 'Support Tickets';
                Image = ServiceTasks;
                RunObject = Page "CRM Support Ticket List";
                ToolTip = 'View and manage customer support tickets and service requests.';
            }

            action("Interactions")
            {
                ApplicationArea = All;
                Caption = 'Interactions';
                Image = InteractionLog;
                RunObject = Page "CRM Interaction Log List";
                ToolTip = 'View all customer interactions and communication history.';
            }

            action("Transactions")
            {
                ApplicationArea = All;
                Caption = 'Transactions';
                Image = Transactions;
                RunObject = Page "CRM Transaction List";
                ToolTip = 'View all customer transactions including payments and donations.';
            }
        }

        area(sections)
        {
            group("Customer Management")
            {
                Caption = 'Customer Management';

                action("All Customers")
                {
                    ApplicationArea = All;
                    Caption = 'All Customers';
                    RunObject = Page "CRM Customer List";
                    ToolTip = 'View all customers in the system.';
                }

                action("Prospective Students")
                {
                    ApplicationArea = All;
                    Caption = 'Prospective Students';
                    RunObject = Page "CRM Customer List";
                    RunPageView = where("Customer Type" = const("Prospective Student"));
                    ToolTip = 'View prospective students.';
                }

                action("Current Students")
                {
                    ApplicationArea = All;
                    Caption = 'Current Students';
                    RunObject = Page "CRM Customer List";
                    RunPageView = where("Customer Type" = const("Current Student"));
                    ToolTip = 'View current students.';
                }

                action("Alumni")
                {
                    ApplicationArea = All;
                    Caption = 'Alumni';
                    RunObject = Page "CRM Customer List";
                    RunPageView = where("Customer Type" = const(Alumni));
                    ToolTip = 'View alumni customers.';
                }

                action("Donors")
                {
                    ApplicationArea = All;
                    Caption = 'Donors';
                    RunObject = Page "CRM Customer List";
                    RunPageView = where("Customer Type" = const(Donor));
                    ToolTip = 'View donor customers.';
                }

                action("VIP Customers")
                {
                    ApplicationArea = All;
                    Caption = 'VIP Customers';
                    RunObject = Page "CRM Customer List";
                    RunPageView = where(VIP = const(true));
                    ToolTip = 'View VIP customers.';
                }
            }

            group("Lead Management")
            {
                Caption = 'Lead Management';

                action("All Leads")
                {
                    ApplicationArea = All;
                    Caption = 'All Leads';
                    RunObject = Page "CRM Lead List";
                    ToolTip = 'View all leads.';
                }

                action("Hot Leads")
                {
                    ApplicationArea = All;
                    Caption = 'Hot Leads';
                    RunObject = Page "CRM Lead List";
                    RunPageView = where("Lead Status" = const("Hot Lead"));
                    ToolTip = 'View hot leads requiring immediate attention.';
                }

                action("New Leads")
                {
                    ApplicationArea = All;
                    Caption = 'New Leads';
                    RunObject = Page "CRM Lead List";
                    RunPageView = where("Lead Status" = const(New));
                    ToolTip = 'View new leads that need to be qualified.';
                }

                action("Qualified Leads")
                {
                    ApplicationArea = All;
                    Caption = 'Qualified Leads';
                    RunObject = Page "CRM Lead List";
                    RunPageView = where("Lead Status" = const(Qualified));
                    ToolTip = 'View qualified leads ready for conversion.';
                }

                action("Follow-up Required")
                {
                    ApplicationArea = All;
                    Caption = 'Follow-up Required';
                    RunObject = Page "CRM Lead List";
                    RunPageView = where("Next Follow-up Date" = filter('<=%1'), "Lead Status" = filter('<>Converted&<>Lost'));
                    ToolTip = 'View leads requiring follow-up today or overdue.';
                }
            }

            group("Campaign Management")
            {
                Caption = 'Campaign Management';

                action("All Campaigns")
                {
                    ApplicationArea = All;
                    Caption = 'All Campaigns';
                    RunObject = Page "CRM Campaign List";
                    ToolTip = 'View all marketing campaigns.';
                }

                action("Active Campaigns")
                {
                    ApplicationArea = All;
                    Caption = 'Active Campaigns';
                    RunObject = Page "CRM Campaign List";
                    RunPageView = where(Status = const("In Progress"));
                    ToolTip = 'View currently active campaigns.';
                }

                action("Campaign Responses")
                {
                    ApplicationArea = All;
                    Caption = 'Campaign Responses';
                    RunObject = Page "CRM Campaign Response List";
                    ToolTip = 'View campaign response analytics.';
                }

                action("Email Campaigns")
                {
                    ApplicationArea = All;
                    Caption = 'Email Campaigns';
                    RunObject = Page "CRM Campaign List";
                    RunPageView = where("Campaign Type" = const(Email));
                    ToolTip = 'View email marketing campaigns.';
                }

                action("Social Media Campaigns")
                {
                    ApplicationArea = All;
                    Caption = 'Social Media Campaigns';
                    RunObject = Page "CRM Campaign List";
                    RunPageView = where("Campaign Type" = const("Social Media"));
                    ToolTip = 'View social media campaigns.';
                }
            }

            group("Customer Service")
            {
                Caption = 'Customer Service';

                action("All Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'All Support Tickets';
                    RunObject = Page "CRM Support Ticket List";
                    ToolTip = 'View all support tickets.';
                }

                action("Open Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Open Tickets';
                    RunObject = Page "CRM Support Ticket List";
                    RunPageView = where(Status = const(Open));
                    ToolTip = 'View open support tickets.';
                }

                action("My Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'My Tickets';
                    RunObject = Page "CRM Support Ticket List";
                    RunPageView = where("Assigned To" = filter('%1'));
                    ToolTip = 'View tickets assigned to me.';
                }

                action("Overdue Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Overdue Tickets';
                    RunObject = Page "CRM Support Ticket List";
                    RunPageView = where("SLA Due Date" = filter('<%1'), Status = filter('<>Closed&<>Resolved'));
                    ToolTip = 'View overdue support tickets.';
                }

                action("High Priority Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'High Priority Tickets';
                    RunObject = Page "CRM Support Ticket List";
                    RunPageView = where(Priority = const(High));
                    ToolTip = 'View high priority tickets.';
                }
            }

            group("Analytics & Reports")
            {
                Caption = 'Analytics & Reports';

                action("Customer Engagement Report")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Engagement Report';
                    Image = Report;
                    RunObject = Report "CRM Customer Engagement Report";
                    ToolTip = 'Generate customer engagement analytics report.';
                }

                action("Lead Conversion Report")
                {
                    ApplicationArea = All;
                    Caption = 'Lead Conversion Report';
                    Image = Report;
                    RunObject = Report "CRM Lead Conversion Report";
                    ToolTip = 'Generate lead conversion analytics report.';
                }

                action("Campaign Performance Report")
                {
                    ApplicationArea = All;
                    Caption = 'Campaign Performance Report';
                    Image = Report;
                    RunObject = Report "CRM Campaign Performance Report";
                    ToolTip = 'Generate campaign performance analytics report.';
                }

                action("Support Metrics Report")
                {
                    ApplicationArea = All;
                    Caption = 'Support Metrics Report';
                    Image = Report;
                    RunObject = Report "CRM Support Metrics Report";
                    ToolTip = 'Generate customer support metrics report.';
                }

                action("Revenue Analytics")
                {
                    ApplicationArea = All;
                    Caption = 'Revenue Analytics';
                    Image = Report;
                    RunObject = Report "CRM Revenue Analytics Report";
                    ToolTip = 'Generate revenue and transaction analytics report.';
                }
            }

            group("Setup")
            {
                Caption = 'Setup';

                action("CRM Setup")
                {
                    ApplicationArea = All;
                    Caption = 'CRM Setup';
                    Image = Setup;
                    RunObject = Page "CRM Setup";
                    ToolTip = 'Configure CRM system settings and parameters.';
                }

                action("Segmentation")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Segmentation';
                    Image = Segment;
                    RunObject = Page "CRM Segmentation List";
                    ToolTip = 'Manage customer segmentation rules and criteria.';
                }

                action("Marketing Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Marketing Templates';
                    Image = Template;
                    RunObject = Page "CRM Marketing Templates";
                    ToolTip = 'Manage email and SMS marketing templates.';
                }

                action("Automation Rules")
                {
                    ApplicationArea = All;
                    Caption = 'Automation Rules';
                    Image = Automation;
                    RunObject = Page "CRM Automation Rules";
                    ToolTip = 'Configure marketing automation and workflow rules.';
                }
            }
        }

        area(creation)
        {
            action("New Customer")
            {
                ApplicationArea = All;
                Caption = 'New Customer';
                Image = NewCustomer;
                RunObject = Page "CRM Customer Card";
                RunPageMode = Create;
                ToolTip = 'Create a new customer record.';
            }

            action("New Lead")
            {
                ApplicationArea = All;
                Caption = 'New Lead';
                Image = NewOpportunity;
                RunObject = Page "CRM Lead Card";
                RunPageMode = Create;
                ToolTip = 'Create a new sales lead.';
            }

            action("New Campaign")
            {
                ApplicationArea = All;
                Caption = 'New Campaign';
                Image = Campaign;
                RunObject = Page "CRM Campaign Card";
                RunPageMode = Create;
                ToolTip = 'Create a new marketing campaign.';
            }

            action("New Support Ticket")
            {
                ApplicationArea = All;
                Caption = 'New Support Ticket';
                Image = ServiceTask;
                RunObject = Page "CRM Support Ticket Card";
                RunPageMode = Create;
                ToolTip = 'Create a new customer support ticket.';
            }

            action("Log Interaction")
            {
                ApplicationArea = All;
                Caption = 'Log Interaction';
                Image = InteractionLog;
                RunObject = Page "CRM Interaction Card";
                RunPageMode = Create;
                ToolTip = 'Log a new customer interaction.';
            }
        }

        area(processing)
        {
            group("Data Management")
            {
                Caption = 'Data Management';

                action("Import Customers")
                {
                    ApplicationArea = All;
                    Caption = 'Import Customers';
                    Image = Import;
                    ToolTip = 'Import customer data from external sources.';

                    trigger OnAction()
                    begin
                        Message('Customer import functionality would be implemented here.');
                    end;
                }

                action("Generate Demo Data")
                {
                    ApplicationArea = All;
                    Caption = 'Generate Demo Data';
                    Image = TestDatabase;
                    ToolTip = 'Generate demo data for testing and training purposes.';

                    trigger OnAction()
                    var
                        DemoDataGenerator: Codeunit "CRM Demo Data Generator";
                    begin
                        if Confirm('This will generate demo CRM data including customers, leads, campaigns, and transactions. Continue?') then begin
                            DemoDataGenerator.GenerateCustomers();
                            Message('Demo data has been generated successfully.');
                        end;
                    end;
                }

                action("Data Cleanup")
                {
                    ApplicationArea = All;
                    Caption = 'Data Cleanup';
                    Image = Delete;
                    ToolTip = 'Clean up old and obsolete CRM data.';

                    trigger OnAction()
                    begin
                        Message('Data cleanup functionality would be implemented here.');
                    end;
                }
            }

            group("Bulk Operations")
            {
                Caption = 'Bulk Operations';

                action("Bulk Email Campaign")
                {
                    ApplicationArea = All;
                    Caption = 'Send Bulk Email';
                    Image = Email;
                    ToolTip = 'Send bulk email to selected customer segments.';

                    trigger OnAction()
                    begin
                        Message('Bulk email functionality would be implemented here.');
                    end;
                }

                action("Bulk SMS Campaign")
                {
                    ApplicationArea = All;
                    Caption = 'Send Bulk SMS';
                    Image = PhoneServices;
                    ToolTip = 'Send bulk SMS to selected customer segments.';

                    trigger OnAction()
                    begin
                        Message('Bulk SMS functionality would be implemented here.');
                    end;
                }

                action("Update Segmentation")
                {
                    ApplicationArea = All;
                    Caption = 'Update Segmentation';
                    Image = Refresh;
                    ToolTip = 'Refresh customer segmentation based on current criteria.';

                    trigger OnAction()
                    begin
                        Message('Segmentation update functionality would be implemented here.');
                    end;
                }
            }
        }

        area(reporting)
        {
            group("Customer Reports")
            {
                Caption = 'Customer Reports';

                action("Customer List Report")
                {
                    ApplicationArea = All;
                    Caption = 'Customer List';
                    Image = Report;
                    RunObject = Report "CRM Customer List Report";
                    ToolTip = 'Print customer list report.';
                }

                action("Customer Engagement Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Engagement Analysis';
                    Image = Report;
                    RunObject = Report "CRM Customer Engagement Report";
                    ToolTip = 'Analyze customer engagement metrics.';
                }

                action("Customer Satisfaction Report")
                {
                    ApplicationArea = All;
                    Caption = 'Satisfaction Report';
                    Image = Report;
                    RunObject = Report "CRM Customer Satisfaction Report";
                    ToolTip = 'Generate customer satisfaction analysis.';
                }
            }

            group("Marketing Reports")
            {
                Caption = 'Marketing Reports';

                action("Campaign ROI Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Campaign ROI Analysis';
                    Image = Report;
                    RunObject = Report "CRM Campaign ROI Report";
                    ToolTip = 'Analyze return on investment for marketing campaigns.';
                }

                action("Lead Generation Report")
                {
                    ApplicationArea = All;
                    Caption = 'Lead Generation Report';
                    Image = Report;
                    RunObject = Report "CRM Lead Generation Report";
                    ToolTip = 'Analyze lead generation performance by source and channel.';
                }

                action("Conversion Funnel Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Conversion Funnel';
                    Image = Report;
                    RunObject = Report "CRM Conversion Funnel Report";
                    ToolTip = 'Analyze the customer conversion funnel.';
                }
            }

            group("Service Reports")
            {
                Caption = 'Service Reports';

                action("Support KPI Dashboard")
                {
                    ApplicationArea = All;
                    Caption = 'Support KPIs';
                    Image = Report;
                    RunObject = Report "CRM Support KPI Report";
                    ToolTip = 'View customer support key performance indicators.';
                }

                action("SLA Compliance Report")
                {
                    ApplicationArea = All;
                    Caption = 'SLA Compliance';
                    Image = Report;
                    RunObject = Report "CRM SLA Compliance Report";
                    ToolTip = 'Analyze service level agreement compliance.';
                }

                action("Agent Performance Report")
                {
                    ApplicationArea = All;
                    Caption = 'Agent Performance';
                    Image = Report;
                    RunObject = Report "CRM Agent Performance Report";
                    ToolTip = 'Analyze support agent performance metrics.';
                }
            }
        }
    }
}