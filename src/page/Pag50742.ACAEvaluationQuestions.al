page 50742 "ACA-Evaluation Questions"
{
    PageType = List;
    SourceTable = "ACA-Evaluation Questions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }


                field(Class; Rec.Class)
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

