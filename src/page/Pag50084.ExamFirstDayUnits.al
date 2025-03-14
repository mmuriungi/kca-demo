page 50084 "Exam First Day Units"
{
    ApplicationArea = All;
    Caption = 'Exam First Day Units';
    PageType = List;
    SourceTable = "Exam First Day Units";
    UsageCategory = Lists;    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Unit; Rec.Unit)
                {
                    ToolTip = 'Specifies the value of the Unit field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
