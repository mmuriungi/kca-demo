pageextension 50010 Location extends "Location Card"
{
    layout
    {
        addafter("Address 2")
        {
            field("Cafeteria Location"; Rec."Cafeteria Location")
            {

            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}