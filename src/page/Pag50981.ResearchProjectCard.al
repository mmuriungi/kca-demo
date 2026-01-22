page 50981 "Research Project Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Research Projects";

    layout
    {
        area(Content)
        {
            group(Project)
            {
                field(ProjectCode; Rec.ProjectCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProjectCode field.';
                }
                field("Research Requisition No"; Rec."Research Requisition No")
                {
                    ApplicationArea = All;
                }
                field(Researcher; Rec.Researcher)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Researcher field.';
                }
                field("Researcher Name"; Rec."Researcher Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Researcher Name field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
                }
                field("School Code"; Rec."School Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School Code field.';
                }
                field(Specialization; Rec.Specialization)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specialization field.';
                }
                field("Main Project Objective"; Rec."Main Project Objective")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Main Project Objective field.';
                }
                field("Project Scope"; Rec."Project Scope")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }


            }
            group("Project Timelines")
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = ALL;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
            part(projectActivities; "Project Activities")
            {
                SubPageLink = "Project Code" = field(ProjectCode);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Project Resources")
            {
                ApplicationArea = All;
                Image = QualificationOverview;
                Promoted = true;
                RunObject = Page "Research Resources";
                RunPageLink = "Project Code" = FIELD(ProjectCode);
            }



        }
    }


    var
        myInt: Integer;
}