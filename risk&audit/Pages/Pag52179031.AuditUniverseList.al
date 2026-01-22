page 52166 "Audit Universe List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Audit Universe";
    Caption = 'Audit Universe';
    CardPageId = "Audit Universe Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the audit universe entry.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the audit universe entry.';
                }
                field("Audit Area"; Rec."Audit Area")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit area type.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the risk rating.';
                }
                field("Risk Score"; Rec."Risk Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated risk score.';
                }
                field("Last Audit Date"; Rec."Last Audit Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the last audit.';
                }
                field("Next Audit Date"; Rec."Next Audit Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the next planned audit.';
                }
                field("Audit Frequency"; Rec."Audit Frequency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how frequently this area should be audited.';
                }
                field("Primary Contact"; Rec."Primary Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the primary contact for this audit area.';
                }
                field("Primary Contact Name"; Rec."Primary Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the primary contact.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the audit universe entry.';
                }
                field("Business Impact"; Rec."Business Impact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business impact level.';
                }
                field("Regulatory Requirements"; Rec."Regulatory Requirements")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if there are regulatory requirements.';
                }
            }
        }
        area(Factboxes)
        {
            // part(Control1; "Audit Universe Details")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Code" = FIELD("Code");
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Annual Plan")
            {
                ApplicationArea = All;
                Caption = 'Generate Annual Plan';
                Image = Planning;
                ToolTip = 'Generate annual audit plan based on risk priorities.';

                trigger OnAction()
                // var
                //     AuditPlanGenerator: Codeunit "Audit Plan Generator";
                begin
                    // if Confirm('Do you want to generate the annual audit plan based on risk priorities?', false) then
                    //     AuditPlanGenerator.GenerateAnnualPlan();
                    Message('Annual plan generation will be implemented.');
                end;
            }
            action("Risk Assessment")
            {
                ApplicationArea = All;
                Caption = 'Risk Assessment';
                Image = Risks;
                ToolTip = 'Perform risk assessment for selected audit areas.';

                trigger OnAction()
                begin
                    Page.Run(Page::"Risks List");
                end;
            }
        }
        area(Navigation)
        {
            action("Audit History")
            {
                ApplicationArea = All;
                Caption = 'Audit History';
                Image = History;
                ToolTip = 'View audit history for this area.';

                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    AuditHeader.SetRange(Type, AuditHeader.Type::Audit);
                    AuditHeader.SetFilter(Description, '*' + Rec.Description + '*');
                    Page.Run(Page::"Audit List", AuditHeader);
                end;
            }
            action("Related Audits")
            {
                ApplicationArea = All;
                Caption = 'Related Audits';
                Image = Navigate;
                ToolTip = 'View audits related to this audit universe entry.';

                trigger OnAction()
                var
                    AuditHeader: Record "Audit Header";
                begin
                    AuditHeader.SetRange(Type, AuditHeader.Type::Audit);
                    AuditHeader.SetRange("Shortcut Dimension 1 Code", Rec."Department Code");
                    Page.Run(Page::"Audit List", AuditHeader);
                end;
            }
        }
        area(Reporting)
        {
            action("Universe Report")
            {
                ApplicationArea = All;
                Caption = 'Audit Universe Report';
                Image = Report;
                ToolTip = 'Print audit universe report.';

                trigger OnAction()
                begin
                    // Report.Run(Report::"Audit Universe Report", true, false, Rec);
                    Message('Audit Universe Report will be implemented.');
                end;
            }
        }
    }
}