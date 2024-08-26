page 50977 "ACA-Academic Referees"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ACA-Academic Referees";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution field.';
                }
                field(Designition; Rec.Designition)
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile No field.';
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}