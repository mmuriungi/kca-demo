page 52165 "Compliance Risk List"
{
    Caption = 'Compliance Risk List';
    PageType = List;
    SourceTable = "Compliance Risk";
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Compliance Risk Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Compliance ID"; Rec."Compliance ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the compliance risk.';
                }
                field("Related Risk ID"; Rec."Related Risk ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the related risk ID from the Risk Register.';
                }
                field("Regulation/Standard"; Rec."Regulation/Standard")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the regulation or standard that applies to this compliance risk.';
                }
                field("Requirement Description"; Rec."Requirement Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the compliance requirement.';
                }
                field("Regulatory Body"; Rec."Regulatory Body")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the regulatory body responsible for this requirement.';
                }
                field("Compliance Status"; Rec."Compliance Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current compliance status.';
                    StyleExpr = ComplianceStatusStyle;
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level associated with non-compliance.';
                    StyleExpr = RiskLevelStyle;
                }
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the officer responsible for this compliance requirement.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department responsible for this compliance requirement.';
                }
                field("Last Assessment Date"; Rec."Last Assessment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the last compliance assessment.';
                }
                field("Next Assessment Date"; Rec."Next Assessment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the next compliance assessment.';
                    StyleExpr = NextAssessmentStyle;
                }
                field("Target Completion Date"; Rec."Target Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target date for completing compliance actions.';
                }
                field("Actual Completion Date"; Rec."Actual Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual date when compliance actions were completed.';
                }
            }
        }
        area(factboxes)
        {
            part("Risk Details"; "Risk Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Risk ID" = field("Related Risk ID");
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(NewCompliance)
            {
                Caption = 'New Compliance Risk';
                ApplicationArea = All;
                Image = New;
                ToolTip = 'Create a new compliance risk record.';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"Compliance Risk Card");
                end;
            }
            action(ViewRelatedRisk)
            {
                Caption = 'View Related Risk';
                ApplicationArea = All;
                Image = Risk;
                ToolTip = 'View the related risk record in the Risk Register.';
                Enabled = Rec."Related Risk ID" <> '';
                
                trigger OnAction()
                var
                    RiskRegister: Record "Risk Register";
                begin
                    if RiskRegister.Get(Rec."Related Risk ID") then
                        Page.Run(Page::"Risk Register Card", RiskRegister);
                end;
            }
            action(UpdateAssessment)
            {
                Caption = 'Update Assessment';
                ApplicationArea = All;
                Image = UpdateDescription;
                ToolTip = 'Update the compliance assessment information.';
                
                trigger OnAction()
                begin
                    Rec."Last Assessment Date" := Today;
                    if Format(Rec."Assessment Frequency") <> '' then
                        Rec."Next Assessment Date" := CalcDate(Rec."Assessment Frequency", Rec."Last Assessment Date");
                    Rec.Modify(true);
                    CurrPage.Update();
                end;
            }
        }
        area(reporting)
        {
            action(ComplianceReport)
            {
                Caption = 'Compliance Report';
                ApplicationArea = All;
                Image = Report;
                ToolTip = 'Generate a compliance status report.';
                
                trigger OnAction()
                begin
                    Report.Run(Report::"Risk Register Report");
                end;
            }
        }
        area(navigation)
        {
            action(ComplianceMonitoring)
            {
                Caption = 'Compliance Monitoring';
                ApplicationArea = All;
                Image = Monitor;
                ToolTip = 'Open the compliance monitoring list.';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"Compliance Monitoring List");
                end;
            }
        }
    }
    
    views
    {
        view(NonCompliant)
        {
            Caption = 'Non-Compliant';
            Filters = where("Compliance Status" = const(Non_Compliant));
        }
        view(PartiallyCompliant)
        {
            Caption = 'Partially Compliant';
            Filters = where("Compliance Status" = const(Partially_Compliant));
        }
        view(UnderReview)
        {
            Caption = 'Under Review';
            Filters = where("Compliance Status" = const(Under_Review));
        }
        view(OverdueAssessments)
        {
            Caption = 'Overdue Assessments';
            Filters = where("Next Assessment Date" = filter('<' & '%1'), "Compliance Status" = filter('<>' & Compliant));
        }
        view(HighRisk)
        {
            Caption = 'High Risk';
            Filters = where("Risk Level" = const(High));
        }
    }
    
    var
        ComplianceStatusStyle: Text;
        RiskLevelStyle: Text;
        NextAssessmentStyle: Text;
    
    trigger OnAfterGetRecord()
    begin
        // Set style expressions for visual indicators
        case Rec."Compliance Status" of
            Rec."Compliance Status"::Compliant:
                ComplianceStatusStyle := 'Favorable';
            Rec."Compliance Status"::Partially_Compliant:
                ComplianceStatusStyle := 'Ambiguous';
            Rec."Compliance Status"::Non_Compliant:
                ComplianceStatusStyle := 'Unfavorable';
            Rec."Compliance Status"::Under_Review:
                ComplianceStatusStyle := 'Subordinate';
            else
                ComplianceStatusStyle := '';
        end;
        
        case Rec."Risk Level" of
            Rec."Risk Level"::High:
                RiskLevelStyle := 'Unfavorable';
            Rec."Risk Level"::Medium:
                RiskLevelStyle := 'Ambiguous';
            Rec."Risk Level"::Low:
                RiskLevelStyle := 'Favorable';
            else
                RiskLevelStyle := '';
        end;
        
        // Highlight overdue assessments
        if (Rec."Next Assessment Date" <> 0D) and (Rec."Next Assessment Date" < Today) then
            NextAssessmentStyle := 'Unfavorable'
        else
            NextAssessmentStyle := '';
    end;
}
