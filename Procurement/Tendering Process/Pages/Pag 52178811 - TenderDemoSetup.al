page 52178811 "Tender Demo Setup"
{
    SourceTable = "Tender Demo Setup";
    PageType = List;
    layout
    {
        area(Content)
        {
            repeater(General)
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
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ToolTip = 'Specifies the value of the Maximum Score field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}