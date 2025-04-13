page 52053 FAQs
{
    ApplicationArea = All;
    Caption = 'FAQs';
    PageType = List;
    SourceTable = FAQ;
    UsageCategory = Lists;
    CardPageId = "FAQ";

    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question field.', Comment = '%';
                }
                field(Answer; Rec.Answer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Answer field.', Comment = '%';
                }
            }
        }
    }
}
