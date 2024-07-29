page 52098 "MoU Objectives"
{
    Caption = 'MoU Objectives';
    PageType = ListPart;
    SourceTable = MouObjectives;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Objective field.';
                }
            }
        }
    }
}
