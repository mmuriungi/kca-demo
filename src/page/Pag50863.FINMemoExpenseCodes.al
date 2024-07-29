page 50863 "FIN-Memo Expense Codes"
{
    Editable = true;
    PageType = List;
    SourceTable = "FIN-Memo Expense Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense Code"; Rec."Expense Code")
                {
                    Editable = true;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(creation)
        {
            action(MemoDet)
            {
                Caption = 'Accomodation Details';
                Image = Allocations;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                RunObject = Page "FIN-Memo Details";
                RunPageLink = "Memo No." = FIELD("Memo No."),
                              "Expense Code" = FIELD("Expense Code"),
                              "Type" = filter('ACCOMODATION');

            }
            action(Logistics)
            {
                Caption = 'Fuel Details';
                Image = Allocations;
                Promoted = true;
                ApplicationArea = All;
                PromotedCategory = Process;
                RunObject = Page "Logistics Memo Details";
                RunPageLink = "Memo No." = FIELD("Memo No."),
                              "Expense Code" = FIELD("Expense Code"), Type = filter('Fuel');

            }
        }
    }

    var
        FINMemoDetails: Record "FIN-Memo Details";
}

