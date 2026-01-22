page 50690 "HRM Work Experience"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HRM-Work eXP";

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Organisation; Rec.Organisation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Organisation field.';
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Position field.';
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

    var
        myInt: Integer;
}