page 52049 "Programm Year of Study"
{
    Caption = 'Programm Year of Study';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Aca-Programme Years of Study";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ToolTip = 'Specifies the value of the Programme Code field.', Comment = '%';
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ToolTip = 'Specifies the value of the Year of Study field.', Comment = '%';
                }
                field("Is FInal Year of Study"; Rec."Is FInal Year of Study")
                {
                    ToolTip = 'Specifies the value of the Is FInal Year of Study field.', Comment = '%';
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}