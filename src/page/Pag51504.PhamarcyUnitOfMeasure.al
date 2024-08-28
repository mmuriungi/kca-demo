page 51504 "Phamarcy Unit Of Measure"
{
    PageType = List;
    SourceTable = "Phamarcy Unit Of Measure";

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Code field.';
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Code field.';
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cost field.';
                }
            }
        }
    }
}