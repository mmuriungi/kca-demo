page 50343 "Fin Memo Regions List"
{
    PageType = List;
    SourceTable = "Fin Memo Regions";

    layout
    {
        area(Content)
        {
            repeater(general)
            {

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Regions; Rec.Regions)
                {
                    ToolTip = 'Specifies the value of the Regions field.';
                    ApplicationArea = All;
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.';
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                    ApplicationArea = All;
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}