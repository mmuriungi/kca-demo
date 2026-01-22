page 50749 "ACA-Mobi Units List"
{
    PageType = List;
    SourceTable = "ACA-Units/Subjects";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Programme Code"; Rec."Programme Code")
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Desription; Rec.Desription)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

