page 51246 "CAT-Daily menu List Staff"
{
    Editable = false;
    PageType = List;
    SourceTable = "CAT-Daily Menu";
    SourceTableView = WHERE(Posted = CONST(true),
                            Type = CONST(Staff));

    layout
    {
        area(content)
        {
            repeater(tgerw)
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

