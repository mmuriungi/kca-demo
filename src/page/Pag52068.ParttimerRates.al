page 52068 "Part timer Rates"
{
    ApplicationArea = All;
    Caption = 'Part timer Rates';
    PageType = Card;
    SourceTable = "Part-Timer Rates";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
