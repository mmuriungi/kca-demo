page 52179030 "Internal Audit Role Center"
{
    PageType = RoleCenter;
    Caption = 'Internal Audit Role Center';
    
    layout
    {
        area(rolecenter)
        {
            group(Group)
            {
                part(AuditCues; "Audit Cues")
                {
                    ApplicationArea = All;
                }
                part(AuditActivities; 9092)
                {
                    ApplicationArea = All;
                }
                systempart(Notes; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(sections)
        {
            group("Annual Planning")
            {
                Caption = 'Annual Planning';
                Image = Planning;
                
                action("Audit Universe")
                {
                    Caption = 'Audit Universe';
                    RunObject = Page "Audit Universe List";
                    ApplicationArea = All;
                }
                action("Risk Assessment")
                {
                    Caption = 'Risk Assessment';
                    RunObject = Page "Risks List";
                    ApplicationArea = All;
                }
                action("Annual Audit Plans")
                {
                    Caption = 'Annual Audit Plans';
                    RunObject = Page "Audit Plan List";
                    ApplicationArea = All;
                }
                action("Draft Plans")
                {
                    Caption = 'Draft Plans';
                    RunObject = Page "Audit Plans";
                    ApplicationArea = All;
                }
                action("Approved Plans")
                {
                    Caption = 'Approved Plans';
                    RunObject = Page "Audit Plan Committee Stage";
                    ApplicationArea = All;
                }
action("Budget Planning")
                {
                    Caption = 'Budget/Time Planning';
                    RunObject = Page "Audit Resource Allocation List";
                    ApplicationArea = All;
                }
            }
            
            group("Audit Planning & Scheduling")
            {
                Caption = 'Audit Planning & Scheduling';
                Image = Calendar;
                
action("Audit Schedule")
                {
                    Caption = 'Audit Schedule';
                    RunObject = Page "Audit Schedule Calendar";
                    ApplicationArea = All;
                }
                action("Audit Projects")
                {
                    Caption = 'Audit Projects';
                    RunObject = Page "Audits";
                    ApplicationArea = All;
                }
                action("Resource Allocation")
                {
                    Caption = 'Resource Allocation';
                    RunObject = Page "Audit Resource Allocation List";
                    ApplicationArea = All;
                }
action("Task Management")
                {
                    Caption = 'Task Management';
                    RunObject = Page "Audit Task Management List";
                    ApplicationArea = All;
                }
                action("Audit Notifications")
                {
                    Caption = 'Audit Notifications';
                    RunObject = Page "Audit Notifications List";
                    ApplicationArea = All;
                }
            }
            
            group("Audit Execution")
            {
                Caption = 'Audit Execution';
                Image = Process;
                
                action("Active Audits")
                {
                    Caption = 'Active Audits';
                    RunObject = Page "Audit List";
                    ApplicationArea = All;
                }
                action("Audit Programs")
                {
                    Caption = 'Audit Programs';
                    RunObject = Page "Audit Program";
                    ApplicationArea = All;
                }
                action("Working Papers")
                {
                    Caption = 'Working Papers';
                    RunObject = Page "Audit Working Paper";
                    ApplicationArea = All;
                }
                action("Audit Procedures")
                {
                    Caption = 'Audit Procedures';
                    RunObject = Page "Audit Planning Procedures";
                    ApplicationArea = All;
                }
action("Test Results")
                {
                    Caption = 'Test Results';
                    RunObject = Page "Audit Working Paper";
                    ApplicationArea = All;
                }
action("Evidence Management")
                {
                    Caption = 'Evidence Management';
                    RunObject = Page "Audit Working Paper";
                    ApplicationArea = All;
                }
                action("Record Requisitions")
                {
                    Caption = 'Record Requisitions';
                    RunObject = Page "Audit Record Requisitions";
                    ApplicationArea = All;
                }
            }
            
            group("Findings & Recommendations")
            {
                Caption = 'Findings & Recommendations';
                Image = ErrorLog;
                
                action("Audit Findings")
                {
                    Caption = 'Audit Findings';
                    RunObject = Page "Audit Finding Lines";
                    ApplicationArea = All;
                }
                action("Risk Ratings")
                {
                    Caption = 'Risk Ratings';
                    RunObject = Page "Audit Ratings";
                    ApplicationArea = All;
                }
                action("Recommendations")
                {
                    Caption = 'Recommendations';
                    RunObject = Page "Audit Recommendations List";
                    ApplicationArea = All;
                }
action("Management Response")
                {
                    Caption = 'Management Response';
                    RunObject = Page "Audit Action Tracking List";
                    ApplicationArea = All;
                }
            }
            
            group("Audit Reports")
            {
                Caption = 'Audit Reports';
                Image = Report;
                
                action("Draft Reports")
                {
                    Caption = 'Draft Reports';
                    RunObject = Page "Audit Reports";
                    ApplicationArea = All;
                }
                action("Final Reports")
                {
                    Caption = 'Final Reports';
                    RunObject = Page "Closed Audit Reports";
                    ApplicationArea = All;
                }
action("Report Distribution")
                {
                    Caption = 'Report Distribution';
                    RunObject = Page "Audit Notifications List";
                    ApplicationArea = All;
                }
            }
            
            group("Follow-up & Monitoring")
            {
                Caption = 'Follow-up & Monitoring';
                Image = Track;
                
                action("Action Tracking")
                {
                    Caption = 'Action Tracking';
                    RunObject = Page "Audit Action Tracking List";
                    ApplicationArea = All;
                }
action("Open Findings")
                {
                    Caption = 'Open Findings';
                    RunObject = Page "Audit Finding Lines";
                    ApplicationArea = All;
                }
action("Overdue Actions")
                {
                    Caption = 'Overdue Actions';
                    RunObject = Page "Audit Action Tracking List";
                    ApplicationArea = All;
                }
action("Implementation Status")
                {
                    Caption = 'Implementation Status';
                    RunObject = Page "Audit Action Tracking List";
                    ApplicationArea = All;
                }
            }
            
            group("Compliance")
            {
                Caption = 'Compliance';
                Image = Certificate;
                
action("Compliance Requirements")
                {
                    Caption = 'Compliance Requirements';
                    RunObject = Page "Compliance Monitoring List";
                    ApplicationArea = All;
                }
action("Compliance Monitoring")
                {
                    Caption = 'Compliance Monitoring';
                    RunObject = Page "Compliance Monitoring List";
                    ApplicationArea = All;
                }
action("Compliance Checklists")
                {
                    Caption = 'Compliance Checklists';
                    RunObject = Page "Compliance Monitoring List";
                    ApplicationArea = All;
                }
            }
            
            group("Analytics & Reporting")
            {
                Caption = 'Analytics & Reporting';
                Image = Analytics;
                
action("Audit Dashboard")
                {
                    Caption = 'Audit Dashboard';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
action("KPI Monitoring")
                {
                    Caption = 'KPI Monitoring';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
action("Performance Metrics")
                {
                    Caption = 'Performance Metrics';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
action("Trend Analysis")
                {
                    Caption = 'Trend Analysis';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
            }
            
            group("Data Analysis")
            {
                Caption = 'Data Analysis';
                Image = DataEntry;
                
action("Data Analytics")
                {
                    Caption = 'Data Analytics';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
action("Continuous Monitoring")
                {
                    Caption = 'Continuous Monitoring';
                    RunObject = Page "Compliance Monitoring List";
                    ApplicationArea = All;
                }
action("Exception Reports")
                {
                    Caption = 'Exception Reports';
                    RunObject = Page "Audit Finding Lines";
                    ApplicationArea = All;
                }
            }
            
            group("Internal Assessment")
            {
                Caption = 'Internal Assessment';
                Image = Evaluate;
                
action("Self Assessment")
                {
                    Caption = 'Self Assessment';
                    RunObject = Page "Compliance Monitoring List";
                    ApplicationArea = All;
                }
action("Quality Reviews")
                {
                    Caption = 'Quality Reviews';
                    RunObject = Page "Audit Working Paper";
                    ApplicationArea = All;
                }
action("Assessment Reports")
                {
                    Caption = 'Assessment Reports';
                    RunObject = Page "Audit Reports";
                    ApplicationArea = All;
                }
            }
            
            group("Administration")
            {
                Caption = 'Administration';
                Image = Setup;
                
                action("Audit Setup")
                {
                    Caption = 'Audit Setup';
                    RunObject = Page "Audit Setup";
                    ApplicationArea = All;
                }
                action("Audit Team")
                {
                    Caption = 'Audit Team';
                    RunObject = Page "Auditors";
                    ApplicationArea = All;
                }
                action("Audit Types")
                {
                    Caption = 'Audit Types';
                    RunObject = Page "Audit Types";
                    ApplicationArea = All;
                }
                action("Audit Periods")
                {
                    Caption = 'Audit Periods';
                    RunObject = Page "Audit Period";
                    ApplicationArea = All;
                }
action("Document Templates")
                {
                    Caption = 'Document Templates';
                    RunObject = Page "Audit Working Paper";
                    ApplicationArea = All;
                }
            }
        }
        
        area(processing)
        {
            group("Process")
            {
                Caption = 'Process';
                
action("Create Annual Plan")
                {
                    Caption = 'Create Annual Plan';
                    RunObject = Page "Audit Plan List";
                    ApplicationArea = All;
                }
                action("Send Notifications")
                {
                    Caption = 'Send Notifications';
                    RunObject = Codeunit "Internal Audit Management";
                    ApplicationArea = All;
                }
                action("Generate Demo Data")
                {
                    Caption = 'Generate Demo Data';
                    RunObject = Codeunit "Audit Demo Data Generator";
                    ApplicationArea = All;
                }
            }
        }
        
        area(reporting)
        {
            group("Audit Reports Group")
            {
                Caption = 'Audit Reports';
                
action("Audit Progress Report")
                {
                    Caption = 'Audit Progress Report';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
action("Findings Report")
                {
                    Caption = 'Findings & Recommendations Report';
                    RunObject = Page "Audit Finding Lines";
                    ApplicationArea = All;
                }
action("Risk Based Audit Report")
                {
                    Caption = 'Risk-Based Audit Report';
                    RunObject = Page "Risks List";
                    ApplicationArea = All;
                }
                action("Compliance Status Report")
                {
                    Caption = 'Compliance Status Report';
                    RunObject = Report "Compliance Status Report";
                    ApplicationArea = All;
                }
action("Follow-up Status Report")
                {
                    Caption = 'Follow-up Action Status Report';
                    RunObject = Page "Audit Action Tracking List";
                    ApplicationArea = All;
                }
action("Performance Report")
                {
                    Caption = 'Audit Performance Metrics Report';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
                action("Schedule Report")
                {
                    Caption = 'Audit Schedule Report';
                    RunObject = Page "Audit Schedule Calendar";
                    ApplicationArea = All;
                }
                action("Workload Report")
                {
                    Caption = 'Internal Audit Workload Report';
                    RunObject = Page "Audit Resource Allocation List";
                    ApplicationArea = All;
                }
                action("Corrective Action Report")
                {
                    Caption = 'Corrective Action Tracking Report';
                    RunObject = Page "Audit Action Tracking List";
                    ApplicationArea = All;
                }
                action("Summary Report")
                {
                    Caption = 'Audit Summary Report';
                    RunObject = Page "Audit Performance Metrics List";
                    ApplicationArea = All;
                }
                action("Exception Report")
                {
                    Caption = 'Exception Report';
                    RunObject = Page "Audit Finding Lines";
                    ApplicationArea = All;
                }
            }
        }
        
        area(embedding)
        {
            action("My Active Audits")
            {
                Caption = 'My Active Audits';
                RunObject = Page "Audit List";
                ApplicationArea = All;
            }
            action("My Tasks")
            {
                Caption = 'My Tasks';
                RunObject = Page "Audit Task Management List";
                ApplicationArea = All;
            }
action("Pending Actions")
            {
                Caption = 'Pending Actions';
                RunObject = Page "Audit Action Tracking List";
                ApplicationArea = All;
            }
        }
    }
}