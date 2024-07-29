page 55102 "REG-Sections List"
{
    ApplicationArea = All;
    Caption = 'File Cabinet';
    PageType = List;
    Editable = false;
    SourceTable = Sections;
    UsageCategory = Administration;
    CardPageId = "REG-Sections Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Number; Rec.Number)
                {
                    ToolTip = 'Specifies the value of the Number field.';
                    ApplicationArea = All;
                }
                field("Section Name"; Rec."Section Name")
                {
                    ToolTip = 'Specifies the value of the Section Name field.';
                    ApplicationArea = All;
                }
                field(Abbreviation; Rec.Abbreviation)
                {
                    ToolTip = 'Specifies the value of the Abbreviation field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
