page 52178578 "Consolidated Plan List"
{
    CardPageID = "Consolidated Plan Card";
    PageType = List;
    SourceTable = "Proc Consolidated Header";
    editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fy; Rec.Fy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fy field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }

            }
        }
    }

    actions
    {
    }
}