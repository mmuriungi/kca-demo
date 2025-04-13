page 52090 "Monitoring Role Center"
{
    PageType = RoleCenter;
    Caption = 'Monitoring';

    layout
    {
        area(RoleCenter)
        {
            // part(Headline; "Headline RC Monitoring")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            // part(Activities; "Monitoring Activities")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part("Help And Chart Wrapper"; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            // action("MonitoringDocumentCard")
            // {
            //     RunPageMode = Create;
            //     Caption = 'MonitoringDocumentCard';
            //     ToolTip = 'Add some tooltip here';
            //     Image = New;
            //     RunObject = page "MonitoringDocumentCard";
            //     ApplicationArea = Basic, Suite;
            // }
        }
        area(Processing)
        {
            group(New)
            {
                // action("MonitoringMasterData")
                // {
                //     RunPageMode = Create;
                //     Caption = 'MonitoringMasterData';
                //     ToolTip = 'Register new MonitoringMasterData';
                //     RunObject = page "MonitoringMasterData Card";
                //     Image = DataEntry;
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("MonitoringSomeProcess Group")
            {
                // action("MonitoringSomeProcess")
                // {
                //     Caption = 'MonitoringSomeProcess';
                //     ToolTip = 'MonitoringSomeProcess description';
                //     Image = Process;
                //     RunObject = Codeunit "MonitoringSomeProcess";
                //     ApplicationArea = Basic, Suite;
                // }
            }
            group("Monitoring Reports")
            {
                // action("MonitoringSomeReport")
                // {
                //     Caption = 'MonitoringSomeReport';
                //     ToolTip = 'MonitoringSomeReport description';
                //     Image = Report;
                //     RunObject = report "MonitoringSomeReport";
                //     ApplicationArea = Basic, Suite;
                // }
            }
        }
        area(Reporting)
        {
            // action("MonitoringSomeReport")
            // {
            //     Caption = 'MonitoringSomeReport';
            //     ToolTip = 'MonitoringSomeReport description';
            //     Image = Report;
            //     RunObject = report "MonitoringSomeReport";
            //     Promoted = true;
            //     PromotedCategory = Report;
            //     PromotedIsBig = true;
            //     ApplicationArea = Basic, Suite;
            // }

        }
        area(Embedding)
        {
            // action("MonitoringMasterData List")
            // {
            //     RunObject = page "MonitoringMasterData List";
            //     ApplicationArea = Basic, Suite;
            // }

        }
        area(Sections)
        {
            group(Projects)
            {
                action("Project List")
                {
                    Caption = 'Project List';
                    ToolTip = 'View and manage projects';
                    Image = Job;
                    RunObject = Page "Job List";
                    ApplicationArea = Basic, Suite;
                }
                action("Survey List")
                {
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                    RunObject = Page "Survey List";
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;
                action("Monitoring Questions")
                {
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                    RunObject = Page "Project Monitor Quiz";
                    ApplicationArea = Basic, Suite;
                }
                action("FAQs")
                {
                    ToolTip = 'View and manage FAQs';
                    RunObject = Page "FAQs";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Monitoring Answers")
            {
                action("Monitoring Questions Answers")
                {
                    Caption = 'Monitoring Answers';
                    Image = Form;
                    RunObject = Page "Project Quiz Answers";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

}
profile Monitoring
{
    Caption = 'Monitoring Role Center';
    RoleCenter = "Monitoring Role Center";
}
