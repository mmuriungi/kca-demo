page 56272 "SMS Campaign List"
{
    PageType = List;
    Caption = 'SMS Campaigns';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SMS Campaign Header";
    CardPageId = "SMS Campaign Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Campaigns)
            {
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Message Text"; Rec."Message Text")
                {
                    ApplicationArea = All;
                    Width = 50;
                }
                field("Schedule Date"; Rec."Schedule Date")
                {
                    ApplicationArea = All;
                }
                field("Schedule Time"; Rec."Schedule Time")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyleExpr;
                }
                field("Total Recipients"; Rec."Total Recipients")
                {
                    ApplicationArea = All;
                }
                field("Total Sent"; Rec."Total Sent")
                {
                    ApplicationArea = All;
                }
                field("Total Failed"; Rec."Total Failed")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Sent Date"; Rec."Sent Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        
        area(FactBoxes)
        {
            part(CampaignFactBox; "SMS Campaign FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Campaign No." = field("Campaign No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewCampaign)
            {
                ApplicationArea = All;
                Caption = 'New Campaign';
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = page "SMS Campaign Card";
                RunPageMode = Create;
            }
            
            action(SendCampaign)
            {
                ApplicationArea = All;
                Caption = 'Send Campaign';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Released;
                
                trigger OnAction()
                var
                    SMSCampaignMgt: Codeunit "SMS Campaign Management";
                begin
                    SMSCampaignMgt.SendCampaign(Rec);
                    CurrPage.Update(false);
                end;
            }
            
            action(ViewRecipients)
            {
                ApplicationArea = All;
                Caption = 'View Recipients';
                Image = CustomerList;
                Promoted = true;
                PromotedCategory = Process;
                
                trigger OnAction()
                var
                    SMSCampaignLine: Record "SMS Campaign Line";
                begin
                    SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
                    Page.Run(0, SMSCampaignLine);
                end;
            }
        }
        
        area(Navigation)
        {
            action(SMSLog)
            {
                ApplicationArea = All;
                Caption = 'SMS Log';
                Image = Log;
                RunObject = page "GEN-SMS_Master List";
                RunPageLink = Code = field("Campaign No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageStyles();
    end;

    var
        StatusStyleExpr: Text;

    local procedure SetPageStyles()
    begin
        case Rec.Status of
            Rec.Status::Draft:
                StatusStyleExpr := 'Standard';
            Rec.Status::Released:
                StatusStyleExpr := 'Favorable';
            Rec.Status::"In Progress":
                StatusStyleExpr := 'Ambiguous';
            Rec.Status::Completed:
                StatusStyleExpr := 'Favorable';
            Rec.Status::Failed:
                StatusStyleExpr := 'Unfavorable';
        end;
    end;
}