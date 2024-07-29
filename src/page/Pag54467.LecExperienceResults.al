page 54467 "Lec Experience Results"
{
    Caption = 'Lec Experience Results';
    PageType = ListPart;
    SourceTable = "Lec Experience Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PF No."; Rec."PF No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PF No. field.', Comment = '%';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Question field.', Comment = '%';
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field.', Comment = '%';
                }
                field("Comment(s)"; Rec."Comment(s)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment(s) field.', Comment = '%';
                }
            }
        }
    }
}
