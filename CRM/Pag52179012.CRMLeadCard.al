page 52179012 "CRM Lead Card"
{
    PageType = Card;
    SourceTable = "CRM Lead";
    Caption = 'CRM Lead Card';

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
                    ToolTip = 'Specifies the lead number.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last name.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the company name.';
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
            }

            group("Lead Information")
            {
                Caption = 'Lead Information';

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
                    Editable = false;
                }
                field("Interest Level"; Rec."Interest Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the interest level.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the lead is assigned to.';
                }
            }

            group("Academic Interest")
            {
                Caption = 'Academic Interest';

                field("Academic Programme"; Rec."Academic Programme")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic programme of interest.';
                }
                field("Study Mode"; Rec."Study Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the preferred study mode.';
                }
                field("Preferred Start Date"; Rec."Preferred Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the preferred start date.';
                }
                field("Budget Range"; Rec."Budget Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budget range.';
                }
                field("Decision Timeline"; Rec."Decision Timeline")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the decision timeline.';
                }
            }

            group("Contact Details")
            {
                Caption = 'Contact Details';

                field("City"; Rec."City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city.';
                }
                field("Country/Region"; Rec."Country/Region")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region.';
                }
                field("Age Group"; Rec."Age Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the age group.';
                }
                field("Gender"; Rec."Gender")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the gender.';
                }
                field("Education Level"; Rec."Education Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current education level.';
                }
            }

            group("Professional Information")
            {
                Caption = 'Professional Information';

                field("Current Employer"; Rec."Current Employer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current employer.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the job title.';
                }
                field("Work Experience"; Rec."Work Experience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies years of work experience.';
                }
                field("Annual Income"; Rec."Annual Income")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the annual income.';
                }
            }

            group("Sales Information")
            {
                Caption = 'Sales Information';

                field("Estimated Value"; Rec."Estimated Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated value.';
                }
                field("Probability (%)"; Rec."Probability (%)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the probability percentage.';
                }
                field("Expected Close Date"; Rec."Expected Close Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expected close date.';
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related campaign.';
                }
            }

            group("Follow-up")
            {
                Caption = 'Follow-up';

                field("Last Contact Date"; Rec."Last Contact Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last contact date.';
                }
                field("Next Follow-up Date"; Rec."Next Follow-up Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next follow-up date.';
                }
                field("Qualification Date"; Rec."Qualification Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the qualification date.';
                }
                field("Converted Date"; Rec."Converted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the conversion date.';
                    Editable = false;
                }
            }

            group("Additional Information")
            {
                Caption = 'Additional Information';

                field("Pain Points"; Rec."Pain Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the pain points.';
                    MultiLine = true;
                }
                field("Goals"; Rec."Goals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the goals.';
                    MultiLine = true;
                }
                field("Objections"; Rec."Objections")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objections.';
                    MultiLine = true;
                }
                field("Tags"; Rec."Tags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tags.';
                }
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional notes.';
                    MultiLine = true;
                }
            }

            group("Engagement Tracking")
            {
                Caption = 'Engagement Tracking';

                field("Website Visits"; Rec."Website Visits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of website visits.';
                }
                field("Email Opens"; Rec."Email Opens")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of email opens.';
                }
                field("Email Clicks"; Rec."Email Clicks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of email clicks.';
                }
                field("Content Downloads"; Rec."Content Downloads")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of content downloads.';
                }
                field("Event Attendance"; Rec."Event Attendance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of events attended.';
                }
            }

            group("Privacy & Consent")
            {
                Caption = 'Privacy & Consent';

                field("GDPR Consent"; Rec."GDPR Consent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if GDPR consent is given.';
                }
                field("Email Opt-In"; Rec."Email Opt-In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if email opt-in is given.';
                }
                field("SMS Opt-In"; Rec."SMS Opt-In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if SMS opt-in is given.';
                }
                field("Do Not Contact"; Rec."Do Not Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if contact is prohibited.';
                }
            }
        }

        area(factboxes)
        {
            part("Lead Statistics"; "CRM Lead Statistics")
            {
                SubPageLink = "No." = field("No.");
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

                action("Convert to Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Convert to Customer';
                    Image = CustomerContact;
                    ToolTip = 'Convert this lead to a customer record.';

                    trigger OnAction()
                    var
                        Customer: Record "CRM Customer";
                        CustomerCard: Page "CRM Customer Card";
                    begin
                        Customer.Init();
                        Customer."No." := '';
                        Customer."Customer Type" := Customer."Customer Type"::"Prospective Student";
                        Customer."First Name" := Rec."First Name";
                        Customer."Last Name" := Rec."Last Name";
                        Customer."Email" := Rec."Email";
                        Customer."Phone No." := Rec."Phone No.";
                        Customer."Company Name" := Rec."Company Name";
                        Customer."Job Title" := Rec."Job Title";
                        Customer."Lead Source" := Rec."Lead Source";
                        Customer."Lead Status" := Customer."Lead Status"::Converted;
                        Customer."Lead Score" := Rec."Lead Score";
                        Customer."Academic Program" := Rec."Academic Programme";
                        Customer."City" := Rec."City";
                        Customer."Country/Region Code" := Rec."Country/Region";
                        Customer."Age Group" := Rec."Age Group";
                        Customer."Gender" := Rec."Gender";
                        Customer."Annual Income" := Rec."Annual Income";
                        Customer."Notes" := 'Converted from Lead: ' + Rec."No.";
                        Customer.Insert(true);

                        Rec."Customer No." := Customer."No.";
                        Rec."Lead Status" := Rec."Lead Status"::Converted;
                        Rec."Converted Date" := WorkDate();
                        Rec.Modify(true);

                        CustomerCard.SetRecord(Customer);
                        CustomerCard.Run();

                        Message('Lead %1 has been converted to Customer %2.', Rec."No.", Customer."No.");
                    end;
                }

                action("Schedule Follow-up")
                {
                    ApplicationArea = All;
                    Caption = 'Schedule Follow-up';
                    Image = Calendar;
                    ToolTip = 'Schedule a follow-up activity for this lead.';

                    trigger OnAction()
                    var
                        FollowUpDate: Date;
                    begin
                        FollowUpDate := WorkDate() + 7; // Default to 1 week from now
                        if FollowUpDate <> 0D then begin
                            Rec."Next Follow-up Date" := FollowUpDate;
                            Rec.Modify(true);
                            Message('Follow-up scheduled for %1.', FollowUpDate);
                        end;
                    end;
                }

                action("Send Email")
                {
                    ApplicationArea = All;
                    Caption = 'Send Email';
                    Image = Email;
                    ToolTip = 'Send email to this lead.';

                    trigger OnAction()
                    var
                        EmailHandler: Codeunit "Simple Email Handler";
                        Subject: Text;
                        Body: Text;
                    begin
                        if Rec."Email" <> '' then begin
                            Subject := 'Follow-up: ' + Rec."First Name" + ' ' + Rec."Last Name";
                            Body := StrSubstNo('Dear %1,<br><br>Thank you for your interest in Appkings Solutions.<br><br>We would like to follow up with you regarding your inquiry.<br><br>Best regards,<br>Appkings Solutions CRM Team', Rec."First Name" + ' ' + Rec."Last Name");
                            if EmailHandler.SendHTMLEmail(Rec."Email", Subject, Body) then
                                Message('Email sent successfully to %1', Rec."Email")
                            else
                                Error('Failed to send email to %1', Rec."Email");
                        end else
                            Error('No email address specified for this lead.');
                    end;
                }

                action("Log Interaction")
                {
                    ApplicationArea = All;
                    Caption = 'Log Interaction';
                    Image = InteractionLog;
                    ToolTip = 'Log an interaction with this lead.';

                    trigger OnAction()
                    var
                        InteractionLog: Record "CRM Interaction Log";
                        InteractionCard: Page "CRM Interaction Card";
                    begin
                        if Rec."Customer No." <> '' then begin
                            InteractionLog.Init();
                            InteractionLog."Customer No." := Rec."Customer No.";
                            InteractionLog.Insert(true);
                            InteractionCard.SetRecord(InteractionLog);
                            InteractionCard.Run();
                        end else
                            Message('Please convert this lead to a customer first.');
                    end;
                }
            }
        }

        area(navigation)
        {
            group("Lead")
            {
                Caption = 'Lead';

                action("Customer Record")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Record';
                    Image = Customer;
                    RunObject = Page "CRM Customer Card";
                    RunPageLink = "No." = field("Customer No.");
                    ToolTip = 'View the customer record if this lead has been converted.';
                    Enabled = CustomerRecordExists;
                }

                action("Campaign")
                {
                    ApplicationArea = All;
                    Caption = 'Campaign';
                    Image = Campaign;
                    RunObject = Page "CRM Campaign Card";
                    RunPageLink = "No." = field("Campaign Code");
                    ToolTip = 'View the related campaign.';
                    Enabled = CampaignExists;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CustomerRecordExists := Rec."Customer No." <> '';
        CampaignExists := Rec."Campaign Code" <> '';
    end;

    var
        CustomerRecordExists: Boolean;
        CampaignExists: Boolean;
}