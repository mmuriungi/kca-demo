page 52096 "MOU/MOA"
{
    Caption = 'MOU/MOA';
    CardPageId = "MOU CARD";
    PageType = List;
    SourceTable = "MOU lists";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Mou Description"; Rec."Mou Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mou Description field.';
                }
                field(validity; Rec.validity)
                {
                    ApplicationArea = All;
                }
                field("MOU expiry Date"; Rec."MOU expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the MOU expiry Date field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
