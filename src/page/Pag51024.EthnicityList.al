page 51024 "Ethnicity List"
{
    Caption = 'Ethnicity List';
    PageType = List;
    SourceTable = "ACA-Academics Central Setups";
    SourceTableView = SORTING(Category, "Title Code")
                      ORDER(Ascending)
                      WHERE(Category = FILTER(Ethnicity));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Title Code"; Rec."Title Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
