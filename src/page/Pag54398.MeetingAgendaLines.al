page 54398 "Meeting Agenda Lines"
{
    Caption = 'Meeting Agenda Lines';
    PageType = ListPart;
    SourceTable = MeeingAgenda;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Meeting Code"; Rec."Meeting Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the "Meeting Code" field.';
                }
                field("Agenda Item"; Rec."Agenda Item")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agenda Item field.';
                }
            }
        }
    }
}
