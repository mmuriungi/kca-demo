page 52164 "Compliance Risk Card"
{
    Caption = 'Compliance Risk Card';
    PageType = Card;
    SourceTable = "Compliance Risk";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
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
                    MultiLine = true;
                    ToolTip = 'Specifies the description of the compliance requirement.';
                }
                field("Regulatory Body"; Rec."Regulatory Body")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the regulatory body responsible for this requirement.';
                }
            }
            
            group(ComplianceStatus)
            {
                Caption = 'Compliance Status';
                
                field("Compliance Status"; Rec."Compliance Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current compliance status.';
                }
                field("Risk Level"; Rec."Risk Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk level associated with non-compliance.';
                }
                field("Penalties/Consequences"; Rec."Penalties/Consequences")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the penalties or consequences of non-compliance.';
                }
                field("Evidence/Documentation"; Rec."Evidence/Documentation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the evidence or documentation supporting compliance.';
                }
            }
            
            group(Assessment)
            {
                Caption = 'Assessment';
                
                field("Last Assessment Date"; Rec."Last Assessment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the last compliance assessment.';
                }
                field("Next Assessment Date"; Rec."Next Assessment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the next compliance assessment.';
                }
                field("Assessment Frequency"; Rec."Assessment Frequency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how frequently compliance assessments should be conducted.';
                }
            }
            
            group(Responsibility)
            {
                Caption = 'Responsibility';
                
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
            }
            
            group(ActionPlan)
            {
                Caption = 'Action Plan';
                
                field("Action Plan"; Rec."Action Plan")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the action plan for achieving or maintaining compliance.';
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
            
            group(AuditTrail)
            {
                Caption = 'Audit Trail';
                
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created this compliance risk record.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this compliance risk record was created.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who last modified this compliance risk record.';
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when this compliance risk record was last modified.';
                }
            }
        }
        area(factboxes)
        {
            part("Risk Details"; "Risk Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Risk ID" = field("Related Risk ID");
                Visible = Rec."Related Risk ID" <> '';
            }
        }
    }
    
    actions
    {
        area(processing)
        {
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
                    Message('Assessment dates updated successfully.');
                end;
            }
            action(MarkCompliant)
            {
                Caption = 'Mark as Compliant';
                ApplicationArea = All;
                Image = Approve;
                ToolTip = 'Mark this compliance requirement as compliant.';
                Enabled = Rec."Compliance Status" <> Rec."Compliance Status"::Compliant;
                
                trigger OnAction()
                begin
                    Rec."Compliance Status" := Rec."Compliance Status"::Compliant;
                    Rec."Actual Completion Date" := Today;
                    Rec.Modify(true);
                    CurrPage.Update();
                    Message('Compliance status updated to Compliant.');
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
            action(ComplianceList)
            {
                Caption = 'Compliance Risk List';
                ApplicationArea = All;
                Image = List;
                ToolTip = 'Open the compliance risk list.';
                
                trigger OnAction()
                begin
                    Page.Run(Page::"Compliance Risk List");
                end;
            }
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
}
