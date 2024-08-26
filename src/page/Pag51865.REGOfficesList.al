page 51865 "REG-Offices List"
{
    ApplicationArea = All;
    Caption = 'REG-Offices List';
    PageType = List;
    SourceTable = "REG-Offices";
    UsageCategory = Administration;
    CardPageId = "REG-Offices Card";

    layout
    {
        area(content)
        {
            repeater(General)
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
