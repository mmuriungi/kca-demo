page 51005 "Program Intake Fee"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ACA-ProgramIntakeFee";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(ProgCode; Rec.ProgCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProgCode field.';
                }
                field(progName; Rec.progName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the progName field.';
                }
                field(settlementType; Rec.settlementType)
                {
                    ApplicationArea = All;
                }
                field(sem1Fee; Rec.sem1Fee)
                {
                    ApplicationArea = All;
                }
                field(sem2Fee; Rec.sem2Fee)
                {
                    ApplicationArea = All;
                }
                field(totalCost; Rec.totalCost)
                {
                    ApplicationArea = All;
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