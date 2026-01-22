page 50137 "PROC-Vendor Prequalifications"
{
    PageType = Worksheet;
    SourceTable = "PROC-Vendor Prequalifications";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Prequalification Code"; Rec."Prequalification Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prequalification Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }
            }
        }
    }
}