page 53061 "CAT-Catering Ledger"
{
    PageType = List;
    SourceTable = "CAT-Catering Prepayment Ledger";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
                field(Reversed; Rec.Reversed)
                {
                }
                field("Reversed On"; Rec."Reversed On")
                {
                }
            }
        }
    }

    actions
    {
    }
}

