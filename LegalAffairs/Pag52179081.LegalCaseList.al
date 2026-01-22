page 52179081 "Legal Case List"
{
    PageType = List;
    SourceTable = "Legal Case";
    Caption = 'Legal Case List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Legal Case Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
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
                field("Lead Counsel"; Rec."Lead Counsel")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the lead counsel.';
                }
                field("Next Court Date"; Rec."Next Court Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the next court date.';
                    StyleExpr = CourtDateStyle;
                }
                field("Filing Date"; Rec."Filing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the filing date.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
            }
        }
        area(FactBoxes)
        {
            part("Case Statistics"; "Legal Case Statistics")
            {
                ApplicationArea = All;
                SubPageLink = "Case No." = field("Case No.");
            }
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
            action("New Case")
            {
                ApplicationArea = All;
                Caption = 'New Case';
                Image = New;
                ToolTip = 'Create a new legal case.';
                RunPageMode = Create;
                RunObject = page "Legal Case Card";
            }
        }
        area(Navigation)
        {
            group(Case)
            {
                Caption = 'Case';
                
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