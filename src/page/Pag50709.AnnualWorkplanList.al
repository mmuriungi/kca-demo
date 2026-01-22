/// <summary>
/// Page Annual Workplan List (ID 50009).
/// </summary>
page 50709 "Annual Workplan List"
{
    Caption = 'Annual Workplan List';
    CardPageId = "Annual Workplan Header";
    PageType = List;
    SourceTable = "Annual Workplan Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Financial Period"; Rec."Financial Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Period field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
        }
    }
}
