page 52045 TBLMyLecturerUnits
{
    ApplicationArea = All;
    Caption = 'TBLMyLecturerUnits';
    PageType = List;
    SourceTable = TBLMyLecturerUnits;
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(UnitCode; Rec.UnitCode)
                {
                    ToolTip = 'Specifies the value of the UnitCode field.';
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ToolTip = 'Specifies the value of the Unit Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
