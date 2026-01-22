page 52179080 "Legal Case Card"
{
    PageType = Card;
    SourceTable = "Legal Case";
    Caption = 'Legal Case Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case number.';
                }
                field("Case Title"; Rec."Case Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case title.';
                }
                field("Case Type"; Rec."Case Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of case.';
                }
                field("Case Category"; Rec."Case Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case category.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case description.';
                    MultiLine = true;
                }
                field("Notice Type"; Rec."Notice Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of notice.';
                }
                field("Case Status"; Rec."Case Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case status.';
                    StyleExpr = StatusStyle;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority level.';
                    StyleExpr = PriorityStyle;
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level.';
                    StyleExpr = RiskStyle;
                }
            }
            
            group(Parties)
            {
                Caption = 'Parties';
                
                field("Plaintiff/Claimant"; Rec."Plaintiff/Claimant")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the plaintiff or claimant.';
                }
                field("Defendant/Respondent"; Rec."Defendant/Respondent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the defendant or respondent.';
                }
                field("Opposing Counsel"; Rec."Opposing Counsel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the opposing counsel.';
                }
                field("Opposing Counsel Contact"; Rec."Opposing Counsel Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the opposing counsel contact information.';
                }
            }
            
            group("Legal Representation")
            {
                Caption = 'Legal Representation';
                
                field("Lead Counsel"; Rec."Lead Counsel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lead counsel.';
                }
                field("External Counsel"; Rec."External Counsel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the external counsel.';
                }
                field("External Counsel Firm"; Rec."External Counsel Firm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the external counsel firm.';
                }
            }
            
            group("Court Information")
            {
                Caption = 'Court Information';
                
                field("Court Name"; Rec."Court Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the court name.';
                }
                field("Court File Number"; Rec."Court File Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the court file number.';
                }
                field("Judge/Magistrate"; Rec."Judge/Magistrate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the judge or magistrate.';
                }
                field("Filing Date"; Rec."Filing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filing date.';
                }
                field("Next Court Date"; Rec."Next Court Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next court date.';
                    StyleExpr = CourtDateStyle;
                }
                field("Court Date Reminder"; Rec."Court Date Reminder")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the court date reminder.';
                }
            }
            
            group(Financial)
            {
                Caption = 'Financial';
                
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the claim amount.';
                }
                field("Settlement Amount"; Rec."Settlement Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the settlement amount.';
                }
                field("Estimated Costs"; Rec."Estimated Costs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the estimated costs.';
                }
                field("Actual Costs"; Rec."Actual Costs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual costs.';
                }
            }
            
            group(Outcome)
            {
                Caption = 'Outcome';
                Visible = (Rec."Case Status" = Rec."Case Status"::Closed) or (Rec."Case Status" = Rec."Case Status"::Settled);
                
                field("Case Outcome"; Rec."Case Outcome")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case outcome.';
                    MultiLine = true;
                }
                field("Judgment Date"; Rec."Judgment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the judgment date.';
                }
                field("Case Closed Date"; Rec."Case Closed Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the case closed date.';
                }
                field("Appeal Filed"; Rec."Appeal Filed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if an appeal has been filed.';
                }
                field("Appeal Date"; Rec."Appeal Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appeal date.';
                }
            }
            
            group(Administration)
            {
                Caption = 'Administration';
                
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Contract Reference No."; Rec."Contract Reference No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related contract reference number.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Case Parties")
            {
                ApplicationArea = All;
                Caption = 'Case Parties';
                Image = ContactPerson;
                ToolTip = 'View or edit case parties.';
                RunObject = page "Legal Case Parties";
                RunPageLink = "Case No." = field("Case No.");
            }
            action("Court Hearings")
            {
                ApplicationArea = All;
                Caption = 'Court Hearings';
                Image = Calendar;
                ToolTip = 'View or edit court hearings.';
                RunObject = page "Legal Court Hearings";
                RunPageLink = "Case No." = field("Case No.");
            }
            action("Legal Documents")
            {
                ApplicationArea = All;
                Caption = 'Legal Documents';
                Image = Documents;
                ToolTip = 'View or edit legal documents.';
                RunObject = page "Legal Document List";
                RunPageLink = "Case No." = field("Case No.");
            }
            action("Legal Invoices")
            {
                ApplicationArea = All;
                Caption = 'Legal Invoices';
                Image = Invoice;
                ToolTip = 'View or edit legal invoices.';
                RunObject = page "Legal Invoice List";
                RunPageLink = "Case No." = field("Case No.");
            }
            action("Calendar Entries")
            {
                ApplicationArea = All;
                Caption = 'Calendar Entries';
                Image = Calendar;
                ToolTip = 'View calendar entries for this case.';
                RunObject = page "Legal Calendar Entries";
                RunPageLink = "Case No." = field("Case No.");
            }
            action("Risk Assessment")
            {
                ApplicationArea = All;
                Caption = 'Risk Assessment';
                Image = Warning;
                ToolTip = 'View or create risk assessments.';
                RunObject = page "Legal Risk Assessment List";
                RunPageLink = "Case No." = field("Case No.");
            }
        }
        area(Reporting)
        {
            action("Case Status Report")
            {
                ApplicationArea = All;
                Caption = 'Case Status Report';
                Image = Report;
                ToolTip = 'Print case status report.';
                RunObject = report "Case Status Report";
            }
        }
    }
    
    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;
    
    local procedure SetStyles()
    begin
        StatusStyle := 'Standard';
        PriorityStyle := 'Standard';
        RiskStyle := 'Standard';
        CourtDateStyle := 'Standard';
        
        case Rec."Case Status" of
            Rec."Case Status"::Closed, Rec."Case Status"::Settled:
                StatusStyle := 'Favorable';
            Rec."Case Status"::"Under Appeal":
                StatusStyle := 'Attention';
        end;
        
        case Rec.Priority of
            Rec.Priority::High, Rec.Priority::Urgent:
                PriorityStyle := 'Unfavorable';
            Rec.Priority::Medium:
                PriorityStyle := 'Attention';
        end;
        
        case Rec."Risk Level" of
            Rec."Risk Level"::High, Rec."Risk Level"::Critical:
                RiskStyle := 'Unfavorable';
            Rec."Risk Level"::Medium:
                RiskStyle := 'Attention';
        end;
        
        if (Rec."Next Court Date" <> 0D) and (Rec."Next Court Date" <= Today + 7) then
            CourtDateStyle := 'Unfavorable';
    end;
    
    var
        StatusStyle: Text;
        PriorityStyle: Text;
        RiskStyle: Text;
        CourtDateStyle: Text;
}