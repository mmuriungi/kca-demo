page 52179021 "CRM Campaign Response List"
{
    PageType = List;
    Caption = 'Campaign Response List';
    SourceTable = "CRM Campaign Response";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number of the campaign response.';
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the campaign number this response relates to.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer who responded to the campaign.';
                }
                field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the customer responded to the campaign.';
                }
                field("Responded"; Rec."Responded")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the customer responded to the campaign.';
                }
                field("Response Type"; Rec."Response Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of response from the customer.';
                }
                field("Response Rating"; Rec."Response Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rating given by the customer (1-5).';
                }
                field("Email Delivered"; Rec."Email Delivered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the email was successfully delivered.';
                }
                field("Email Opens"; Rec."Email Opens")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of times the email was opened.';
                }
                field("Email Clicks"; Rec."Email Clicks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of email link clicks.';
                }
                field("Channel Used"; Rec."Channel Used")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marketing channel used for this response.';
                }
                field("Lead Generated"; Rec."Lead Generated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this response generated a lead.';
                }
                field("Sale Made"; Rec."Sale Made")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this response resulted in a sale.';
                }
                field("Sale Amount"; Rec."Sale Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount of the sale if one was made.';
                }
                field("Engagement Score"; Rec."Engagement Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the engagement score for this response.';
                }
                field("Satisfaction Score"; Rec."Satisfaction Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer satisfaction score (1-10).';
                }
            }
        }
        // area(factboxes)
        // {
        //     part("Campaign Details"; "CRM Campaign FactBox")
        //     {
        //         ApplicationArea = All;
        //         SubPageLink = "No." = field("Campaign No.");
        //     }
        // }
    }

    actions
    {
        area(processing)
        {
            action("View Customer")
            {
                ApplicationArea = All;
                Caption = 'View Customer';
                Image = Customer;
                ToolTip = 'View the customer record for this response.';
                
                trigger OnAction()
                var
                    CRMCustomer: Record "CRM Customer";
                begin
                    if CRMCustomer.Get(Rec."Customer No.") then
                        Page.Run(Page::"CRM Customer Card", CRMCustomer);
                end;
            }
            
            action("View Campaign")
            {
                ApplicationArea = All;
                Caption = 'View Campaign';
                Image = Campaign;
                ToolTip = 'View the campaign record for this response.';
                
                trigger OnAction()
                var
                    CRMCampaign: Record "CRM Campaign";
                begin
                    if CRMCampaign.Get(Rec."Campaign No.") then
                        Page.Run(Page::"CRM Campaign Card", CRMCampaign);
                end;
            }
        }
        
        area(reporting)
        {
            action("Response Analytics")
            {
                ApplicationArea = All;
                Caption = 'Response Analytics';
                Image = Report;
                ToolTip = 'Generate analytics report for campaign responses.';
                
                trigger OnAction()
                begin
                    Message('Response analytics report would be generated here.');
                end;
            }
        }
    }
}