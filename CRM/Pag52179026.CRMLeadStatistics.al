page 52150 "CRM Lead Statistics"
{
    PageType = CardPart;
    SourceTable = "CRM Lead";
    Caption = 'Lead Statistics';
    
    layout
    {
        area(content)
        {
            group("Lead Overview")
            {
                Caption = 'Lead Overview';
                
                field("Lead Score"; Rec."Lead Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lead score (0-100).';
                    StyleExpr = LeadScoreStyle;
                }
                field("Interest Level"; Rec."Interest Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the interest level of the lead.';
                }
                field("Lead Status"; Rec."Lead Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the lead.';
                    StyleExpr = LeadStatusStyle;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level of the lead.';
                    StyleExpr = PriorityStyle;
                }
            }
            
            group("Timeline")
            {
                Caption = 'Timeline';
                
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the lead was created.';
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
                field("Days Since Created"; DaysSinceCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days since the lead was created.';
                    Caption = 'Days Since Created';
                }
                field("Days Since Last Contact"; DaysSinceLastContact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of days since last contact.';
                    Caption = 'Days Since Last Contact';
                    StyleExpr = LastContactStyle;
                }
            }
            
            group("Lead Details")
            {
                Caption = 'Lead Details';
                
                field("Lead Source"; Rec."Lead Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source of the lead.';
                }
                field("Campaign Code"; Rec."Campaign Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the campaign code associated with the lead.';
                }
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
                field("Budget Range"; Rec."Budget Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budget range of the lead.';
                }
            }
            
            group("Conversion")
            {
                Caption = 'Conversion';
                
                field("Qualification Date"; Rec."Qualification Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the lead was qualified.';
                }
                field("Converted Date"; Rec."Converted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the lead was converted.';
                }
                field("Conversion Rate"; ConversionRate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the conversion rate for similar leads.';
                    Caption = 'Similar Leads Conversion Rate';
                    DecimalPlaces = 1:1;
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action("View Lead Details")
            {
                ApplicationArea = All;
                Caption = 'View Lead Details';
                ToolTip = 'View detailed information about this lead.';
                Image = View;
                
                trigger OnAction()
                begin
                    Page.Run(Page::"CRM Lead Card", Rec);
                end;
            }
            action("Create Follow-up")
            {
                ApplicationArea = All;
                Caption = 'Create Follow-up';
                ToolTip = 'Create a follow-up activity for this lead.';
                Image = NewToDo;
                
                trigger OnAction()
                var
                    CRMInteraction: Record "CRM Interaction Log";
                begin
                    CRMInteraction.Init();
                    // Note: CRM Interaction Log is designed for customers, not leads directly
                    // We'll create a general follow-up interaction
                    CRMInteraction."Interaction Date" := Today;
                    CRMInteraction."Interaction Time" := Time;
                    CRMInteraction."Interaction Type" := CRMInteraction."Interaction Type"::"Follow Up";
                    CRMInteraction."Subject" := 'Follow-up for Lead ' + Rec."No.";
                    CRMInteraction."Description" := 'Follow-up interaction for lead: ' + Rec."First Name" + ' ' + Rec."Last Name";
                    Page.Run(Page::"CRM Interaction Card", CRMInteraction);
                end;
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        CalculateStatistics();
        SetStyles();
    end;
    
    local procedure CalculateStatistics()
    var
        CRMLeadRec: Record "CRM Lead";
        TotalLeads: Integer;
        ConvertedLeads: Integer;
    begin
        // Calculate days since created
        if Rec."Created Date" <> 0DT then
            DaysSinceCreated := Today - DT2Date(Rec."Created Date")
        else
            DaysSinceCreated := 0;
            
        // Calculate days since last contact
        if Rec."Last Contact Date" <> 0D then
            DaysSinceLastContact := Today - Rec."Last Contact Date"
        else
            DaysSinceLastContact := 0;
            
        // Calculate conversion rate for similar leads (same source and programme)
        CRMLeadRec.SetRange("Lead Source", Rec."Lead Source");
        CRMLeadRec.SetRange("Academic Programme", Rec."Academic Programme");
        TotalLeads := CRMLeadRec.Count;
        
        if TotalLeads > 0 then begin
            CRMLeadRec.SetFilter("Lead Status", '%1', CRMLeadRec."Lead Status"::Converted);
            ConvertedLeads := CRMLeadRec.Count;
            ConversionRate := (ConvertedLeads / TotalLeads) * 100;
        end else
            ConversionRate := 0;
    end;
    
    local procedure SetStyles()
    begin
        // Lead Score Style
        case Rec."Lead Score" of
            0..30:
                LeadScoreStyle := 'Unfavorable';
            31..60:
                LeadScoreStyle := 'Ambiguous';
            61..100:
                LeadScoreStyle := 'Favorable';
        end;
        
        // Lead Status Style
        case Rec."Lead Status" of
            Rec."Lead Status"::New:
                LeadStatusStyle := 'Standard';
            Rec."Lead Status"::Qualified:
                LeadStatusStyle := 'Favorable';
            Rec."Lead Status"::Converted:
                LeadStatusStyle := 'StrongAccent';
            Rec."Lead Status"::"Lost":
                LeadStatusStyle := 'Unfavorable';
            else
                LeadStatusStyle := 'Standard';
        end;
        
        // Priority Style
        case Rec."Priority" of
            Rec."Priority"::Low:
                PriorityStyle := 'Standard';
            Rec."Priority"::Medium:
                PriorityStyle := 'Ambiguous';
            Rec."Priority"::High:
                PriorityStyle := 'Attention';
            Rec."Priority"::Critical:
                PriorityStyle := 'Unfavorable';
        end;
        
        // Follow-up Style
        if Rec."Next Follow-up Date" <> 0D then begin
            if Rec."Next Follow-up Date" < Today then
                FollowUpStyle := 'Unfavorable'
            else if Rec."Next Follow-up Date" = Today then
                FollowUpStyle := 'Attention'
            else
                FollowUpStyle := 'Standard';
        end else
            FollowUpStyle := 'Standard';
            
        // Last Contact Style
        if DaysSinceLastContact > 30 then
            LastContactStyle := 'Unfavorable'
        else if DaysSinceLastContact > 14 then
            LastContactStyle := 'Ambiguous'
        else
            LastContactStyle := 'Standard';
    end;
    
    var
        DaysSinceCreated: Integer;
        DaysSinceLastContact: Integer;
        ConversionRate: Decimal;
        LeadScoreStyle: Text;
        LeadStatusStyle: Text;
        PriorityStyle: Text;
        FollowUpStyle: Text;
        LastContactStyle: Text;
}
