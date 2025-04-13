page 52054 FAQ
{
    Caption = 'FAQ';
    PageType = Card;
    SourceTable = FAQ;
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question field.', Comment = '%';
                    MultiLine = true;
                }
                field(Answer; Rec.Answer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Answer field.', Comment = '%';
                    MultiLine = true;
                }
            }
        }
    }
}
