page 52179090 "Legal Affairs Role Center"
{
    PageType = RoleCenter;
    Caption = 'Legal Affairs';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Legal Affairs Headline")
            {
                ApplicationArea = All;
            }
            part(Activities; "Legal Affairs Activities")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group("Case Management")
            {
                Caption = 'Case Management';
                Image = LegalAgreement;
                
                action("Legal Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Cases';
                    RunObject = page "Legal Case List";
                    ToolTip = 'Manage legal cases and matters.';
                }
                action("Open Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Open Cases';
                    RunObject = page "Legal Case List";
                    RunPageView = where("Case Status" = const(Open));
                    ToolTip = 'View open legal cases.';
                }
                action("Cases In Progress")
                {
                    ApplicationArea = All;
                    Caption = 'Cases In Progress';
                    RunObject = page "Legal Case List";
                    RunPageView = where("Case Status" = const("In Progress"));
                    ToolTip = 'View cases currently in progress.';
                }
                action("High Priority Cases")
                {
                    ApplicationArea = All;
                    Caption = 'High Priority Cases';
                    RunObject = page "Legal Case List";
                    RunPageView = where(Priority = filter(High | Urgent));
                    ToolTip = 'View high priority and urgent cases.';
                }
                action("Court Hearings")
                {
                    ApplicationArea = All;
                    Caption = 'Court Hearings';
                    RunObject = page "Legal Court Hearing List";
                    ToolTip = 'Manage court hearings and appearances.';
                }
                action("Case Parties")
                {
                    ApplicationArea = All;
                    Caption = 'Case Parties';
                    RunObject = page "Legal Case Party List";
                    ToolTip = 'Manage parties involved in legal cases.';
                }
            }
            
            group("Document Management")
            {
                Caption = 'Document Management';
                Image = Documents;
                
                action("Legal Documents")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Documents';
                    RunObject = page "Legal Document List";
                    ToolTip = 'Manage legal documents and files.';
                }
                action("Policies & Procedures")
                {
                    ApplicationArea = All;
                    Caption = 'Policies & Procedures';
                    RunObject = page "Legal Document List";
                    RunPageView = where("Document Type" = filter(Policy | Procedure));
                    ToolTip = 'View policies and procedures.';
                }
                action("Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Contracts';
                    RunObject = page "Legal Document List";
                    RunPageView = where("Document Type" = const(Contract));
                    ToolTip = 'View contract documents.';
                }
                action("Court Filings")
                {
                    ApplicationArea = All;
                    Caption = 'Court Filings';
                    RunObject = page "Legal Document List";
                    RunPageView = where("Document Type" = const("Court Filing"));
                    ToolTip = 'View court filing documents.';
                }
            }
            
            group("Contract Management")
            {
                Caption = 'Contract Management';
                Image = Agreement;
                
                action("All Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'All Contracts';
                    RunObject = page "Projects List";
                    ToolTip = 'View all contracts.';
                }
                action("Active Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Active Contracts';
                    RunObject = page "Projects Approved";
                    ToolTip = 'View active contracts.';
                }
                action("Expiring Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Expiring Contracts';
                    RunObject = page "Projects List";
                    RunPageView = where("Estimated End Date" = filter('..+3M'));
                    ToolTip = 'View contracts expiring in next 3 months.';
                }
            }
            
            group("Compliance & Risk")
            {
                Caption = 'Compliance & Risk';
                Image = RiskLevel;
                
                action("Compliance Tasks")
                {
                    ApplicationArea = All;
                    Caption = 'Compliance Tasks';
                    RunObject = page "Legal Compliance Task List";
                    ToolTip = 'Manage compliance requirements and tasks.';
                }
                action("Risk Assessments")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Assessments';
                    RunObject = page "Legal Risk Assessment List";
                    ToolTip = 'Manage legal risk assessments.';
                }
                action("High Risk Items")
                {
                    ApplicationArea = All;
                    Caption = 'High Risk Items';
                    RunObject = page "Legal Risk Assessment List";
                    RunPageView = where("Risk Level" = filter(High | Critical));
                    ToolTip = 'View high and critical risk items.';
                }
                action("Overdue Compliance")
                {
                    ApplicationArea = All;
                    Caption = 'Overdue Compliance';
                    RunObject = page "Legal Compliance Task List";
                    RunPageView = where(Status = const(Overdue));
                    ToolTip = 'View overdue compliance tasks.';
                }
            }
            
            group("Calendar & Deadlines")
            {
                Caption = 'Calendar & Deadlines';
                Image = Calendar;
                
                action("Legal Calendar")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Calendar';
                    RunObject = page "Legal Calendar Entry List";
                    ToolTip = 'View legal calendar and deadlines.';
                }
                action("Today's Events")
                {
                    ApplicationArea = All;
                    Caption = 'Today''s Events';
                    RunObject = page "Legal Calendar Entry List";
                    RunPageView = where("Event Date" = filter('Today'));
                    ToolTip = 'View today''s legal events.';
                }
                action("This Week")
                {
                    ApplicationArea = All;
                    Caption = 'This Week';
                    RunObject = page "Legal Calendar Entry List";
                    RunPageView = where("Event Date" = filter('..CW'));
                    ToolTip = 'View this week''s legal events.';
                }
            }
            
            group("Financial")
            {
                Caption = 'Financial';
                Image = Invoicing;
                
                action("Legal Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Invoices';
                    RunObject = page "Legal Invoice List";
                    ToolTip = 'Manage legal fees and invoices.';
                }
                action("Pending Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Invoices';
                    RunObject = page "Legal Invoice List";
                    RunPageView = where("Payment Status" = const(Pending));
                    ToolTip = 'View pending legal invoices.';
                }
                action("External Counsel Fees")
                {
                    ApplicationArea = All;
                    Caption = 'External Counsel Fees';
                    RunObject = page "Legal Invoice List";
                    RunPageView = where("Service Type" = filter("Legal Consultation" | "Court Representation"));
                    ToolTip = 'View external counsel fees.';
                }
            }
        }
        
        area(Creation)
        {
            action("New Legal Case")
            {
                ApplicationArea = All;
                Caption = 'New Legal Case';
                Image = New;
                RunObject = page "Legal Case Card";
                RunPageMode = Create;
                ToolTip = 'Create a new legal case.';
            }
            action("New Document")
            {
                ApplicationArea = All;
                Caption = 'New Document';
                Image = NewDocument;
                RunObject = page "Legal Document Card";
                RunPageMode = Create;
                ToolTip = 'Create a new legal document.';
            }
            action("New Compliance Task")
            {
                ApplicationArea = All;
                Caption = 'New Compliance Task';
                Image = Task;
                RunObject = page "Legal Compliance Task Card";
                RunPageMode = Create;
                ToolTip = 'Create a new compliance task.';
            }
            action("New Calendar Entry")
            {
                ApplicationArea = All;
                Caption = 'New Calendar Entry';
                Image = Calendar;
                RunObject = page "Legal Calendar Entry Card";
                RunPageMode = Create;
                ToolTip = 'Create a new calendar entry.';
            }
        }
        
        area(Processing)
        {
            group(Reports)
            {
                Caption = 'Reports';
                Image = Report;
                
                action("Case Status Report")
                {
                    ApplicationArea = All;
                    Caption = 'Case Status Report';
                    RunObject = report "Case Status Report";
                    ToolTip = 'Print case status report.';
                }
                action("Legal Expense Report")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Expense Report';
                    RunObject = report "Legal Expense Report";
                    ToolTip = 'Print legal expense report.';
                }
                action("Contract Expiration Report")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Expiration Report';
                    RunObject = report "Contract Expiration Report";
                    ToolTip = 'Print contract expiration report.';
                }
                action("Litigation Overview Report")
                {
                    ApplicationArea = All;
                    Caption = 'Litigation Overview Report';
                    RunObject = report "Litigation Overview Report";
                    ToolTip = 'Print litigation overview report.';
                }
                action("Compliance Status Report")
                {
                    ApplicationArea = All;
                    Caption = 'Compliance Status Report';
                    RunObject = report "Compliance Status Report";
                    ToolTip = 'Print compliance status report.';
                }
                action("Legal Workload Report")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Workload Report';
                    RunObject = report "Legal Workload Report";
                    ToolTip = 'Print legal workload report.';
                }
                action("Risk Assessment Report")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Assessment Report';
                    RunObject = report "Risk Assessment Report";
                    ToolTip = 'Print risk assessment report.';
                }
                // action("External Counsel Performance")
                // {
                //     ApplicationArea = All;
                //     Caption = 'External Counsel Performance';
                //     RunObject = report "External Counsel Performance";
                //     ToolTip = 'Print external counsel performance report.';
                // }
            }
            
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                
                action("Legal Affairs Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Legal Affairs Setup';
                    RunObject = page "Legal Affairs Setup";
                    ToolTip = 'Configure legal affairs settings.';
                }
                action("No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'No. Series';
                    RunObject = page "No. Series";
                    ToolTip = 'Set up number series.';
                }
            }
        }
    }
}