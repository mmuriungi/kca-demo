page 54518 "RepairRequest Lines"
{
    Caption = 'RepairRequest Lines';
    PageType = ListPart;
    SourceTable = "Repair Request Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Repair Types"; Rec."Repair Types")
                {
                    ApplicationArea = All;
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
