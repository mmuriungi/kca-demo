#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 68935 "ACA-Hostel Invtry Items List"
{
    PageType = List;
    SourceTable = "ACA-Hostel Inventory";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Quantity Per Room"; Rec."Quantity Per Room")
                {
                    ApplicationArea = Basic;
                }
                field("Applies To"; Rec."Applies To")
                {
                    ApplicationArea = Basic;
                }
                field("Hostel Gender"; Rec."Hostel Gender")
                {
                    ApplicationArea = Basic;
                }
                field("Fine Amount"; Rec."Fine Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Bill Total"; Rec."Bill Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("All Rooms"; Rec."All Rooms")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

