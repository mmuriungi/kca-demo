page 52179001 "CRM Customer List"
{
    PageType = List;
    SourceTable = "CRM Customer";
    Caption = 'CRM Customer List';
    CardPageId = "CRM Customer Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.';
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of customer.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full name.';
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number.';
                }
                field("Lead Status"; Rec."Lead Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lead status.';
                }
                field("Lead Score"; Rec."Lead Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lead score.';
                }
                field("Segmentation Code"; Rec."Segmentation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the segmentation code.';
                }
                field("Last Interaction Date"; Rec."Last Interaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last interaction date.';
                }
                field("Total Interactions"; Rec."Total Interactions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of interactions.';
                }
                field("Engagement Score"; Rec."Engagement Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the engagement score.';
                }
                field("VIP"; Rec."VIP")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the customer is VIP.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                }
            }
        }

        area(factboxes)
        {
            part("Customer Statistics"; "CRM Customer Statistics")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("New")
            {
                Caption = 'New';

                action("New Customer")
                {
                    ApplicationArea = All;
                    Caption = 'New Customer';
                    Image = NewCustomer;
                    ToolTip = 'Create a new customer record.';

                    trigger OnAction()
                    var
                        Customer: Record "CRM Customer";
                        CustomerCard: Page "CRM Customer Card";
                    begin
                        Customer.Init();
                        Customer.Insert(true);
                        CustomerCard.SetRecord(Customer);
                        CustomerCard.Run();
                    end;
                }

                action("Import Customers")
                {
                    ApplicationArea = All;
                    Caption = 'Import Customers';
                    Image = Import;
                    ToolTip = 'Import customers from external source.';

                    trigger OnAction()
                    begin
                        Message('Import functionality would be implemented here.');
                    end;
                }
            }

            group("Functions")
            {
                Caption = 'Functions';

                action("Create Campaign")
                {
                    ApplicationArea = All;
                    Caption = 'Create Campaign';
                    Image = Campaign;
                    ToolTip = 'Create a new marketing campaign.';

                    trigger OnAction()
                    var
                        Campaign: Record "CRM Campaign";
                        CampaignCard: Page "CRM Campaign Card";
                    begin
                        Campaign.Init();
                        Campaign.Insert(true);
                        CampaignCard.SetRecord(Campaign);
                        CampaignCard.Run();
                    end;
                }

                action("Bulk Update")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk Update';
                    Image = UpdateDescription;
                    ToolTip = 'Update multiple customers at once.';

                    trigger OnAction()
                    begin
                        Message('Bulk update functionality would be implemented here.');
                    end;
                }

                action("Generate Demo Data")
                {
                    ApplicationArea = All;
                    Caption = 'Generate Demo Data';
                    Image = TestDatabase;
                    ToolTip = 'Generate demo data for testing purposes.';

                    trigger OnAction()
                    var
                        DemoDataGenerator: Codeunit "CRM Demo Data Generator";
                    begin
                        DemoDataGenerator.GenerateCustomers();
                        CurrPage.Update(false);
                        Message('Demo data has been generated.');
                    end;
                }
            }

            group("Reports")
            {
                Caption = 'Reports';

                action("Customer Engagement Report")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Engagement Report';
                    Image = Report;
                    ToolTip = 'Generate customer engagement report.';

                    trigger OnAction()
                    begin
                        Report.Run(Report::"CRM Customer Engagement Report");
                    end;
                }

                action("Lead Conversion Report")
                {
                    ApplicationArea = All;
                    Caption = 'Lead Conversion Report';
                    Image = Report;
                    ToolTip = 'Generate lead conversion report.';

                    trigger OnAction()
                    begin
                        Report.Run(Report::"CRM Lead Conversion Report");
                    end;
                }
            }
        }

        area(navigation)
        {
            group("CRM")
            {
                Caption = 'CRM';

                action("Campaigns")
                {
                    ApplicationArea = All;
                    Caption = 'Campaigns';
                    Image = Campaign;
                    RunObject = Page "CRM Campaign List";
                    ToolTip = 'View and manage marketing campaigns.';
                }

                action("Leads")
                {
                    ApplicationArea = All;
                    Caption = 'Leads';
                    Image = Opportunity;
                    RunObject = Page "CRM Lead List";
                    ToolTip = 'View and manage leads.';
                }

                action("Support Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Support Tickets';
                    Image = ServiceTasks;
                    RunObject = Page "CRM Support Ticket List";
                    ToolTip = 'View and manage support tickets.';
                }

                action("Segmentation")
                {
                    ApplicationArea = All;
                    Caption = 'Segmentation';
                    Image = Segment;
                    RunObject = Page "CRM Segmentation List";
                    ToolTip = 'View and manage customer segmentation.';
                }
            }
        }
    }
}