page 53072 "CAT-Daily menu List"
{
    Editable = false;
    PageType = List;
    SourceTable = "CAT-Daily Menu";

    layout
    {
        area(content)
        {
            repeater(ewr)
            {
                field(Menu; Rec.Menu)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Units; Rec.Units)
                {
                }
                field("Total Qty"; Rec."Total Qty")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Menu Date", TODAY);
    end;
}

