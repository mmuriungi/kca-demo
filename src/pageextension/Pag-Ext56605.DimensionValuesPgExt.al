pageextension 56605 "Dimension Values Pg Ext" extends "Dimension Values"
{
    layout
    {
        addafter(Blocked)
        {
            field(Category; Rec.Category)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
