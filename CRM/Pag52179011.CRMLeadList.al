page 52179011 "CRM Lead List"
{
    PageType = List;
    SourceTable = "CRM Lead";
    Caption = 'CRM Lead List';
    CardPageId = "CRM Lead Card";
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
                    StyleExpr = LeadScoreStyle;
                }
                field("Interest Level"; Rec."Interest Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the interest level.';
                }
                field("Academic Programme"; Rec."Academic Programme")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic programme of interest.';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who the lead is assigned to.';
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                }
                field("Last Contact Date"; Rec."Last Contact Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last contact date.';
                }
                field("Next Follow-up Date"; Rec."Next Follow-up Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next follow-up date.';
                    StyleExpr = FollowUpStyle;
                }
                field("Expected Close Date"; Rec."Expected Close Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expected close date.';
                }
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
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the lead was created.';
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

                action("Mark as Lost")
                {
                    ApplicationArea = All;
                    Caption = 'Mark as Lost';
                    Image = Delete;
                    ToolTip = 'Mark this lead as lost.';

                    trigger OnAction()
                    var
                        LostReason: Text[100];
                    begin
                        LostReason := 'Competition'; // This could be from a dialog
                        if LostReason <> '' then begin
                            Rec."Lead Status" := Rec."Lead Status"::Lost;
                            Rec."Lost Reason" := LostReason;
                            Rec.Modify(true);
                            Message('Lead marked as lost. Reason: %1', LostReason);
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
            }

            group("Reports")
            {
                Caption = 'Reports';

                action("Lead Details")
                {
                    ApplicationArea = All;
                    Caption = 'Lead Details';
                    Image = Report;
                    ToolTip = 'Print lead details report.';

                    trigger OnAction()
                    begin
                        Message('Lead details report would be generated here.');
                    end;
                }
            }
        }

        area(navigation)
        {
            group("Lead")
            {
                Caption = 'Lead';

                action("Interaction History")
                {
                    ApplicationArea = All;
                    Caption = 'Interaction History';
                    Image = InteractionLog;
                    RunObject = Page "CRM Interaction Log List";
                    RunPageLink = "Customer No." = field("Customer No.");
                    ToolTip = 'View interaction history for this lead.';
                }

                action("Activities")
                {
                    ApplicationArea = All;
                    Caption = 'Activities';
                    Image = TaskList;
                    ToolTip = 'View activities related to this lead.';

                    trigger OnAction()
                    begin
                        Message('Activities view would be shown here.');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    local procedure SetStyles()
    begin
        // Lead Score styling
        if Rec."Lead Score" >= 80 then
            LeadScoreStyle := 'Favorable'
        else if Rec."Lead Score" >= 60 then
            LeadScoreStyle := 'Ambiguous'
        else if Rec."Lead Score" >= 40 then
            LeadScoreStyle := 'Unfavorable'
        else
            LeadScoreStyle := 'Subordinate';

        // Follow-up date styling
        if Rec."Next Follow-up Date" <> 0D then begin
            if Rec."Next Follow-up Date" < WorkDate() then
                FollowUpStyle := 'Unfavorable' // Overdue
            else if Rec."Next Follow-up Date" = WorkDate() then
                FollowUpStyle := 'Ambiguous' // Due today
            else
                FollowUpStyle := 'Standard'; // Future
        end else
            FollowUpStyle := 'Subordinate'; // No follow-up scheduled
    end;

    var
        LeadScoreStyle: Text;
        FollowUpStyle: Text;
}