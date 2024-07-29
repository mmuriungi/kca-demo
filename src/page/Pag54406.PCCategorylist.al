page 54406 "PC Category list"
{
    ApplicationArea = All;
    Caption = 'PC Category list';
    PageType = List;
    SourceTable = "PC Category Table";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code "; Rec."Code ")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code  field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
