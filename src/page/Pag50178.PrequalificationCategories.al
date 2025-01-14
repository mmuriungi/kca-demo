page 50178 "Prequalification Categories"
{
    Caption = 'Prequalification Categories';
    PageType = List;
    SourceTable = "Prequalification Categories";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
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
