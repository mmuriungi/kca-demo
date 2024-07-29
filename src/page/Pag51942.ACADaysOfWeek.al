page 51942 "ACA-Days Of Week"
{
    PageType = CardPart;
    SourceTable = "ACA-Day Of Week";
    SourceTableView = WHERE(Exams = CONST(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

