/// <summary>
/// Page Vendor Categories (ID 52178586).
/// </summary>
page 52178602 "Vendor Categories"
{
    Caption = 'Vendor Categories';
    PageType = List;
    SourceTable = "Vendor Categories";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
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
