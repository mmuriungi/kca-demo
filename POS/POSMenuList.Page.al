#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99406 "POS Menu List"
{
    PageType = List;
    SourceTable = "POS Items";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Of measure"; Rec."Unit Of measure")
                {
                    ApplicationArea = Basic;
                }
                field(Inventory; Rec.Inventory)
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

