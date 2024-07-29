page 52066 "Research Resources"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Research Resources";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Project Code"; Rec."Project Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Project Code field.';
                    Editable = false;
                }
                field("Resource Description"; Rec."Resource Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resource Description field.';
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