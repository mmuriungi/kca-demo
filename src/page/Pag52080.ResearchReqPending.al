page 52080 "Research Req(Pending)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Project Resource Requisition";
    SourceTable = "Project Resource Requisition";
    SourceTableView = where(Status = filter("Pending Approval"));


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Project Req No"; Rec."Project Req No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Req No field.';
                }
                field("Date Requested"; Rec."Date Requested")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department Code field.';
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