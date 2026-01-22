page 50167 "Procurement Methods Sub Page"
{
    PageType = ListPart;
    SourceTable = "Procurement Method Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stage; Rec.Stage)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Minimum Duration"; Rec."Minimum Duration")
                {
                }
                field("Maximum Duration"; Rec."Maximum Duration")
                {
                }
            }
        }
    }

    actions
    {
    }
}

