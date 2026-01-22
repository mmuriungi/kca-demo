page 50284 "Activities & Deliverables"
{
    Caption = 'Activities & Deliverables';
    PageType = ListPart;
    SourceTable = "Activities & Deliverables";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Activities And Deliverables"; Rec."Activities And Deliverables")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activities And Deliverables field.';
                }
                field("Prelimary Dates"; Rec."Prelimary Dates")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prelimary Dates field.';
                }
            }
        }
    }
}
