page 55107 "REG-Offices Card"
{
    Caption = 'REG-Offices Card';
    PageType = Card;
    SourceTable = "REG-Offices";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Region; Rec.Region)
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    ApplicationArea = All;
                }
                field(Division; Rec.Division)
                {
                    ToolTip = 'Specifies the value of the Division field.';
                    ApplicationArea = All;
                }
                field(Office; Rec.Office)
                {
                    ToolTip = 'Specifies the value of the Office field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
