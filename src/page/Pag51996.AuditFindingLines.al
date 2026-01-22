page 51996 "Audit Finding Lines"
{
    Caption = 'Audit Finding Lines';
    PageType = ListPart;
    SourceTable = "Audit Finding Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Audit Line No."; Rec."Audit Line No.")
                {
                    ToolTip = 'Specifies the value of the Audit Line No. field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Areas of improvement"; Rec."Areas of improvement")
                {
                    ToolTip = 'Specifies the value of the Areas of improvement field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Feed back"; Rec."Feed back")
                {
                    ToolTip = 'Specifies the value of the Feed back field.';
                    ApplicationArea = All;

                }
                field(Observations; Rec.Observations)
                {
                    ToolTip = 'Specifies the value of the Observations field.';
                    ApplicationArea = All;

                }
                field(Recommendations; Rec.Recommendations)
                {
                    ToolTip = 'Specifies the value of the Recommendations field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}
