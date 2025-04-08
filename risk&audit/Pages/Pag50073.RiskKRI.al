page 50073 "Risk KRI"
{
    PageType = List;
    SourceTable = "Risk KRI";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                }


            }
        }
    }

}

