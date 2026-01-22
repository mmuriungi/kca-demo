page 56269 "SMS Campaign Card"
{
    PageType = Document;
    Caption = 'SMS Campaign Card';
    SourceTable = "SMS Campaign Header";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    
                    trigger OnAssistEdit()
                    begin
                        if AssistEdit() then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyleExpr;
                }
            }
            
            group(Message)
            {
                Caption = 'Message';
                
                field("Message Text"; Rec."Message Text")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                    
                    trigger OnValidate()
                    begin
                        MessageLength := StrLen(Rec."Message Text");
                        CurrPage.Update();
                    end;
                }
                field(MessageLength; MessageLength)
                {
                    ApplicationArea = All;
                    Caption = 'Message Length';
                    Editable = false;
                    StyleExpr = MessageLengthStyleExpr;
                }
            }
            
            group(Schedule)
            {
                Caption = 'Schedule';
                
                field("Schedule Date"; Rec."Schedule Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Schedule Time"; Rec."Schedule Time")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            
            group(Statistics)
            {
                Caption = 'Statistics';
                
                field("Total Recipients"; Rec."Total Recipients")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowRecipients();
                    end;
                }
                field("Total Sent"; Rec."Total Sent")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowSentRecipients();
                    end;
                }
                field("Total Failed"; Rec."Total Failed")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    
                    trigger OnDrillDown()
                    begin
                        ShowFailedRecipients();
                    end;
                }
                field("Sent Date"; Rec."Sent Date")
                {
                    ApplicationArea = All;
                }
            }
            
            part(Lines; "SMS Campaign Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Campaign No." = field("Campaign No.");
                UpdatePropagation = Both;
            }
        }
        
        area(FactBoxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                
                action(ImportRecipients)
                {
                    ApplicationArea = All;
                    Caption = 'Import Recipients';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    
                    trigger OnAction()
                    begin
                        ImportRecipientsFromSource();
                    end;
                }
                
                action(SelectAllRecipients)
                {
                    ApplicationArea = All;
                    Caption = 'Select All';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        SelectAllRecipients(true);
                    end;
                }
                
                action(DeselectAllRecipients)
                {
                    ApplicationArea = All;
                    Caption = 'Deselect All';
                    Image = UnselectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        SelectAllRecipients(false);
                    end;
                }
                
                action(RemoveBlankPhones)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Blank Phone Numbers';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    
                    trigger OnAction()
                    begin
                        RemoveBlankPhoneNumbers();
                    end;
                }
            }
            
            group(Release)
            {
                Caption = 'Release';
                
                action(ReleaseAction)
                {
                    ApplicationArea = All;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = Rec.Status = Rec.Status::Draft;
                    
                    trigger OnAction()
                    begin
                        ReleaseCampaign();
                    end;
                }
                
                action(ReopenAction)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    Enabled = Rec.Status = Rec.Status::Released;
                    
                    trigger OnAction()
                    begin
                        ReopenCampaign();
                    end;
                }
            }
            
            action(SendSMS)
            {
                ApplicationArea = All;
                Caption = 'Send SMS';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Released;
                
                trigger OnAction()
                begin
                    SendSMSCampaign();
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
        SetPageControls();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetPageControls();
    end;

    var
        MessageLength: Integer;
        StatusStyleExpr: Text;
        MessageLengthStyleExpr: Text;

    local procedure SetPageControls()
    begin
        MessageLength := StrLen(Rec."Message Text");
        
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
        
        if MessageLength > 160 then
            MessageLengthStyleExpr := 'Unfavorable'
        else
            MessageLengthStyleExpr := 'Standard';
    end;

    local procedure AssistEdit(): Boolean
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("SMS Campaign Nos.");
        if NoSeriesMgt.SelectSeries(SalesSetup."SMS Campaign Nos.", Rec."No. Series", Rec."No. Series") then begin
            NoSeriesMgt.SetSeries(Rec."Campaign No.");
            exit(true);
        end;
    end;

    local procedure ImportRecipientsFromSource()
    var
        ImportSMSRecipients: Page "Import SMS Recipients";
    begin
        ImportSMSRecipients.SetCampaignNo(Rec."Campaign No.");
        ImportSMSRecipients.RunModal();
        CurrPage.Update(false);
    end;

    local procedure SelectAllRecipients(SelectValue: Boolean)
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        SMSCampaignLine.ModifyAll(Selected, SelectValue);
        CurrPage.Update(false);
    end;

    local procedure RemoveBlankPhoneNumbers()
    var
        SMSCampaignLine: Record "SMS Campaign Line";
    begin
        SMSCampaignLine.SetRange("Campaign No.", Rec."Campaign No.");
        SMSCampaignLine.SetFilter("Phone Number", '=%1', '');
        if SMSCampaignLine.FindSet() then
            SMSCampaignLine.DeleteAll(true);
        CurrPage.Update(false);
    end;

    local procedure ReleaseCampaign()
    begin
        Rec.TestField(Description);
        Rec.TestField("Message Text");
        Rec.TestField("Schedule Date");
        Rec.TestField("Schedule Time");
        
        Rec.CalcFields("Total Recipients");
        if Rec."Total Recipients" = 0 then
            Error('There are no recipients for this campaign.');
            
        Rec.Status := Rec.Status::Released;
        Rec.Modify(true);
        CurrPage.Update(false);
    end;

    local procedure ReopenCampaign()
    begin
        Rec.Status := Rec.Status::Draft;
        Rec.Modify(true);
        CurrPage.Update(false);
    end;

    local procedure SendSMSCampaign()
    var
        SMSCampaignMgt: Codeunit "SMS Campaign Management";
    begin
        if Confirm('Do you want to send SMS to all selected recipients?', false) then begin
            SMSCampaignMgt.SendCampaign(Rec);
            CurrPage.Update(false);
        end;
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
}