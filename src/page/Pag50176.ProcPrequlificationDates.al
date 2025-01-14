page 50176 "Proc-Prequlification Dates"
{
    Caption = 'Proc-Prequlification Dates';
    PageType = List;
    SourceTable = "Prequalifications Date";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Preq Year"; Rec."Preq Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preq Year field.';
                }
                field("Reference Date"; Rec."Reference Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference Date field.';
                }
            }
        }
    }
}
