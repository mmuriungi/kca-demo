page 50251 "Audit Period"
{
    ApplicationArea = All;
    Caption = 'Audit Period';
    PageType = List;
    SourceTable = "Audit Period";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period Start field.', Comment = '%';
                }
                field("Period End"; Rec."Period End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period End field.', Comment = '%';
                }
            }
        }
    }
}
