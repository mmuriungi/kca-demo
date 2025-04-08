page 50266 "Risk KRI"
{
    PageType = List;
    SourceTable = "Risk KRI";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }


            }
        }
    }

}

