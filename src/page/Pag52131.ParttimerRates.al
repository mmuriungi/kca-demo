page 52131 "Parttimer Rates"
{
    ApplicationArea = All;
    Caption = 'Parttimer Rates';
    PageType = List;
    SourceTable = "Part-Timer Rates";
    UsageCategory = Administration;
    CardPageId = "Part timer Rates";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Programme Category"; Rec."Programme Category")
                {
                    ToolTip = 'Specifies the value of the Programme Category field.', Comment = '%';
                }
                field("Rate per Hour"; Rec."Rate per Hour")
                {
                    ToolTip = 'Specifies the value of the Rate per Hour field.', Comment = '%';
                }
            }
        }
    }
}
