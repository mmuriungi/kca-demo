page 50727 "GEN-Nationality List"
{
    // CardPageID = "GEN-Nationality Card";
    DeleteAllowed = false;
    //InsertAllowed = false;
    //ModifyAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "ACA-Academics Central Setups";
    SourceTableView = WHERE(Category = FILTER(Nationality));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Title Code"; Rec."Title Code")
                {
                    Caption = 'Denomination';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
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

