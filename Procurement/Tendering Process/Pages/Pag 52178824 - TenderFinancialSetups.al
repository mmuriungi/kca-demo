page 52178824 "Tender Financial Setups"
{
    PageType = List;
    SourceTable = "Tender Financial Setups";
    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    ApplicationArea = All;
                }
                field("Maximum Quote"; Rec."Budgeted Value")
                {
                    ToolTip = 'Specifies the value of the Maximum Quote field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}