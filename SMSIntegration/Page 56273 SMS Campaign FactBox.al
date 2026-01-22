page 56273 "SMS Campaign FactBox"
{
    PageType = CardPart;
    Caption = 'SMS Campaign Statistics';
    SourceTable = "SMS Campaign Header";

    layout
    {
        area(Content)
        {
            group(Statistics)
            {
                Caption = 'Statistics';
                
                field("Total Recipients"; Rec."Total Recipients")
                {
                    ApplicationArea = All;
                    Caption = 'Total Recipients';
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowRecipients();
                    end;
                }
                field("Total Sent"; Rec."Total Sent")
                {
                    ApplicationArea = All;
                    Caption = 'Total Sent';
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowSentRecipients();
                    end;
                }
                field("Total Failed"; Rec."Total Failed")
                {
                    ApplicationArea = All;
                    Caption = 'Total Failed';
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowFailedRecipients();
                    end;
                }
                field(PendingCount; GetPendingCount())
                {
                    ApplicationArea = All;
                    Caption = 'Pending';
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowPendingRecipients();
                    end;
                }
                field(MessageLength; StrLen(Rec."Message Text"))
                {
                    ApplicationArea = All;
                    Caption = 'Message Length';
                    StyleExpr = MessageLengthStyleExpr;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageStyles();
    end;

    var
        MessageLengthStyleExpr: Text;

    local procedure SetPageStyles()
    begin
        if StrLen(Rec."Message Text") > 160 then
            MessageLengthStyleExpr := 'Unfavorable'
        else
            MessageLengthStyleExpr := 'Standard';
    end;

    local procedure GetPendingCount(): Integer
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        SMSCampaignLine.SetRange(Status, SMSCampaignLine.Status::Pending);
        exit(SMSCampaignLine.Count());
    end;

    local procedure ShowRecipients()
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        Page.Run(0, SMSCampaignLine);
    end;

    local procedure ShowSentRecipients()
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        SMSCampaignLine.SetRange(Status, SMSCampaignLine.Status::Sent);
        Page.Run(0, SMSCampaignLine);
    end;

    local procedure ShowFailedRecipients()
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        SMSCampaignLine.SetRange(Status, SMSCampaignLine.Status::Failed);
        Page.Run(0, SMSCampaignLine);
    end;

    local procedure ShowPendingRecipients()
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        SMSCampaignLine.SetRange(Status, SMSCampaignLine.Status::Pending);
        Page.Run(0, SMSCampaignLine);
    end;
}