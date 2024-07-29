page 54464 "DMS Rolecenter"
{
    Caption = 'Document Management System';
    Description = 'Document Management System';
    Editable = false;
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {


            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {

        area(sections)
        {

            group("Self Service")
            {
                ToolTip = 'Self Service';
                Caption = 'Self Service';
                action("Imprest Req")
                {

                    image = ItemRegisters;
                    ApplicationArea = All;
                    Ellipsis = true;
                    Caption = 'Imprest Requisition';
                    RunObject = Page "FIN-Imprests List";
                    ToolTip = 'Make New Imprest Requision';
                }

                action("Claim")
                {
                    Image = CopyGLtoCostBudget;
                    ApplicationArea = All;
                    Caption = 'Staff Claims';
                    RunObject = Page "FIN-Staff Claim List";
                    RunPageMode = Create;
                    ToolTip = 'Raise staff claim';
                }
                action("Leave Req")
                {
                    Image = CopyGLtoCostBudget;
                    ApplicationArea = All;
                    Caption = 'Leave Requisition';
                    RunObject = Page "HRM-Leave Requisition List";
                    RunPageMode = Create;
                    ToolTip = 'Leave Requisition';
                }

            }
            group(Performance)
            {
                Caption = 'Performance Management';
                Image = Capacities;
                action("Appraisal Years")
                {
                    ApplicationArea = all;
                    Caption = 'Appraisal Years';
                    RunObject = Page "HRM-Appraisal Years List";
                    ToolTip = 'Executes  Appraisal Years.';
                }



            }
            group(train)
            {
                Caption = 'Training Management';
                action("Training Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Training Applications';
                    RunObject = Page "HRM-Training Application List";
                    ToolTip = 'Executes the Training Applications action.';
                }
                action("Training Courses")
                {
                    ApplicationArea = All;
                    Caption = 'Training Courses';
                    RunObject = Page "HRM-Course List";
                    ToolTip = 'Executes the Training Courses action.';
                }

                action("Training Needs")
                {
                    ApplicationArea = All;
                    Caption = 'Training Needs';
                    RunObject = Page "HRM-Train Need Analysis List";
                    ToolTip = 'Executes the Training Needs action.';
                }
                action("Back To Office")
                {
                    ApplicationArea = All;
                    Caption = 'Back To Office';
                    RunObject = Page "HRM-Back To Office List";
                    ToolTip = 'Executes the Back To Office action.';
                }
            }


            group("Corrrespondance")
            {
                action("My Correspondence")
                {
                    ApplicationArea = All;
                    RunObject = Page "Incoming Mails";
                    //RunPageLink = UserId = filter(User)
                }
                action("Incomming Correspondence")
                {
                    ApplicationArea = All;
                    RunObject = Page "Incoming Mails";
                }
                action("Pending Correspondence")
                {
                    ApplicationArea = All;
                    RunObject = Page "Pending Mails";
                }
                action("Approved Correspondace")
                {
                    ApplicationArea = All;
                    RunObject = Page "Approved Mails";

                }
            }
            group(SharePoint)
            {
                action("Sharepoint Control")
                {
                    ApplicationArea = All;
                    Caption = 'Sharepoint Control';
                    // RunObject = Page SharePoint;
                }
            }
        }
    }
}

