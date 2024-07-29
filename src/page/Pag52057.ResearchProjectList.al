page 52057 "Research Project List"
{
    PageType = List;
    CardPageId = "Research Project Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Research Projects";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(ProjectCode; Rec.ProjectCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProjectCode field.';
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
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = All;
                }
            }
            }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
}