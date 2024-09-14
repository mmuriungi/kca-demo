page 52041 "Contract Mgmt Role Center"
{
    PageType = RoleCenter;
    ApplicationArea = All;
    UsageCategory = Administration;
    caption = 'Contract Management Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(HeadlineRC; "Headline RC Contract Mgmt")
            {
                ApplicationArea = All;
            }
            part(ContractActivities; "Contract Cues")
            {
                ApplicationArea = All;
            }
            part(ContractChart; "Contract Chart")
            {
                ApplicationArea = All;
            }
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(ContractManagement)
            {
                Caption = 'Contract Management';
                Image = ProductDesign;
                action(Contracts)
                {
                    Caption = 'Contracts';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Projects List";
                }

                action("Running Contracts")
                {
                    Caption = 'Running Contracts';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Projects Approved";
                }
                action("Finished Contracts")
                {
                    Caption = 'Finished Contracts';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Projects Finished";
                }
                action("Suspended Contracts")
                {
                    Caption = 'Suspended Contracts';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Projects Suspended";
                }
                action("Contracts Pending Verification")
                {
                    Caption = 'Contracts Pending Verification';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Projects Pending Verification";
                }
                action("Verified Contracts")
                {
                    Caption = 'Verified Contracts';
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Projects Verified";
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                action(ContractListReport)
                {
                    ApplicationArea = All;
                    Caption = 'Contract List Report';
                    RunObject = report "Contract List Report";
                    ToolTip = 'Generate a report of all contracts';
                }
                action(ContractAnalysisReport)
                {
                    ApplicationArea = All;
                    Caption = 'Contract Analysis Report';
                    RunObject = report "Contract Analysis Report";
                    ToolTip = 'Generate an analysis report of contracts';
                }
            }
        }
        area(Embedding)
        {
            action(ActiveContracts)
            {
                ApplicationArea = All;
                Caption = 'Active Contracts';
                RunObject = page "Projects List";
                RunPageView = where(Status = const(Verified));
                ToolTip = 'View active contracts';
            }
            action(ExpiringContracts)
            {
                ApplicationArea = All;
                Caption = 'Expiring Contracts';
                RunObject = page "Projects List";
                // RunPageView = where(Status = const(Verified), "Expiry Date" = field("Date Filter"));
                ToolTip = 'View contracts expiring soon';
            }
        }
    }
}