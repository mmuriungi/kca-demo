page 51020 "MOU JIC"
{
    Caption = 'MOU/MOA JIC';
    PageType = ListPart;
    SourceTable = "MOU JIC";

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
                field("Full Names"; Rec."Full Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Full Names field.';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
