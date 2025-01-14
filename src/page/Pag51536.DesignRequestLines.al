page 51536 "Design Request Lines"
{
    Caption = 'Design Request Lines';
    PageType = ListPart;
    SourceTable = "Design Request Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Desing Req Code"; Rec."Desing Req Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desing Req Code field.';
                    Editable = false;
                }
                field("Desing Request"; Rec."Desing Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desing Request field.';
                }
            }
        }
    }
}
