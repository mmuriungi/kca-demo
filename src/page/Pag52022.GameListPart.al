// Page: Game List Part
page 52022 "Game List Part"
{
    PageType = ListPart;
    SourceTable = Game;
    Caption = 'Games';

    layout
    {
        area(content)
        {
            repeater(Games)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
