page 51008 "Project Resource Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Project Resource Req Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Project ReqNo"; Rec."Project ReqNo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project ReqNo field.';
                    Editable = false;
                }
                field("Resource Type"; Rec."Resource Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Type field.';
                }
                field("Resource No"; Rec."Resource No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource No field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Resource Cost"; Rec."Resource Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Cost field.';
                }
            }
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