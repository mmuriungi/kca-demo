page 52179000 "CRM Customer Card"
{
    PageType = Card;
    SourceTable = "CRM Customer";
    Caption = 'CRM Customer Card';

    layout
    {
        area(content)
        {
            group("General")
            {
                Caption = 'General';

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
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last name.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the full name.';
                    Editable = false;
                }
            }

            group("Contact Information")
            {
                Caption = 'Contact Information';

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
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mobile phone number.';
                }
                field("Address"; Rec."Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the second address line.';
                }
                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city.';
                }
                field("County"; Rec."County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the county.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code.';
                }
            }

            group("Personal Information")
            {
                Caption = 'Personal Information';

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of birth.';
                }
                field("Gender"; Rec."Gender")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the gender.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marital status.';
                }
                field("Nationality"; Rec."Nationality")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the nationality.';
                }
                field("ID/Passport No."; Rec."ID/Passport No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID or passport number.';
                }
            }

            group("Academic Information")
            {
                Caption = 'Academic Information';

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the student number.';
                }
                field("Academic Program"; Rec."Academic Program")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic program.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year.';
                }
                field("Enrollment Date"; Rec."Enrollment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the enrollment date.';
                }
                field("Graduation Date"; Rec."Graduation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the graduation date.';
                }
            }

            group("CRM Information")
            {
                Caption = 'CRM Information';

                field("Lead Source"; Rec."Lead Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lead source.';
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
            }

            group("Statistics")
            {
                Caption = 'Statistics';

                field("Total Interactions"; Rec."Total Interactions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total number of interactions.';
                    Editable = false;
                }
                field("Last Interaction Date"; Rec."Last Interaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last interaction date.';
                    Editable = false;
                }
                field("Lifetime Value"; Rec."Lifetime Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lifetime value.';
                    Editable = false;
                }
                field("Total Donations"; Rec."Total Donations")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total donations.';
                    Editable = false;
                }
                field("Campaign Responses"; Rec."Campaign Responses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of campaign responses.';
                    Editable = false;
                }
                field("Support Tickets"; Rec."Support Tickets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of support tickets.';
                    Editable = false;
                }
            }
        }

        area(factboxes)
        {
            part("Interaction History"; "CRM Interaction FactBox")
            {
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Functions")
            {
                Caption = 'Functions';

                action("Interaction Log")
                {
                    ApplicationArea = All;
                    Caption = 'Interaction Log';
                    Image = Log;
                    ToolTip = 'View interaction history for this customer.';

                    trigger OnAction()
                    var
                        InteractionLog: Record "CRM Interaction Log";
                    begin
                        InteractionLog.SetRange("Customer No.", Rec."No.");
                        Page.Run(Page::"CRM Interaction Log List", InteractionLog);
                    end;
                }

                action("Support Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Support Tickets';
                    Image = ServiceTasks;
                    ToolTip = 'View support tickets for this customer.';

                    trigger OnAction()
                    var
                        SupportTicket: Record "CRM Support Ticket";
                    begin
                        SupportTicket.SetRange("Customer No.", Rec."No.");
                        Page.Run(Page::"CRM Support Ticket List", SupportTicket);
                    end;
                }

                action("Campaign Responses")
                {
                    ApplicationArea = All;
                    Caption = 'Campaign Responses';
                    Image = Campaign;
                    ToolTip = 'View campaign responses for this customer.';

                    trigger OnAction()
                    var
                        CampaignResponse: Record "CRM Campaign Response";
                    begin
                        CampaignResponse.SetRange("Customer No.", Rec."No.");
                        Page.Run(Page::"CRM Campaign Response List", CampaignResponse);
                    end;
                }

                action("Create Lead")
                {
                    ApplicationArea = All;
                    Caption = 'Create Lead';
                    Image = NewCustomer;
                    ToolTip = 'Create a new lead from this customer.';

                    trigger OnAction()
                    var
                        Lead: Record "CRM Lead";
                        LeadCard: Page "CRM Lead Card";
                    begin
                        Lead.Init();
                        Lead."Customer No." := Rec."No.";
                        Lead."First Name" := Rec."First Name";
                        Lead."Last Name" := Rec."Last Name";
                        Lead."Email" := Rec."Email";
                        Lead."Phone No." := Rec."Phone No.";
                        Lead.Insert(true);

                        LeadCard.SetRecord(Lead);
                        LeadCard.Run();
                    end;
                }
            }
        }

        area(navigation)
        {
            group("Customer")
            {
                Caption = 'Customer';

                action("Interaction History")
                {
                    ApplicationArea = All;
                    Caption = 'Interaction History';
                    Image = InteractionLog;
                    RunObject = Page "CRM Interaction Log List";
                    RunPageLink = "Customer No." = field("No.");
                    ToolTip = 'View the interaction history for this customer.';
                }

                action("Transaction History")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction History';
                    Image = Transactions;
                    RunObject = Page "CRM Transaction List";
                    RunPageLink = "Customer No." = field("No.");
                    ToolTip = 'View the transaction history for this customer.';
                }
            }
        }
    }
}