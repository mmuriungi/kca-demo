page 51244 "CAT-Menu Sales List"
{
    CardPageID = "CAT-Menu Sales Header";
    PageType = List;
    SourceTable = "CAT-Menu Sale Header";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt No"; Rec."Receipt No")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Cashier No"; Rec."Cashier No")
                {
                }
                field("Customer Type"; Rec."Customer Type")
                {
                }
                field("Customer No"; Rec."Customer No")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Receiving Bank"; Rec."Receiving Bank")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Department; Rec.Department)
                {
                }
                field("Contact Staff"; Rec."Contact Staff")
                {
                }
                field("Sales Point"; Rec."Sales Point")
                {
                }
                field("Paid Amount"; Rec."Paid Amount")
                {
                }
                field(Balance; Rec.Balance)
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Cashier Name"; Rec."Cashier Name")
                {
                }
                field("Sales Type"; Rec."Sales Type")
                {
                }
                field("Prepayment Balance"; Rec."Prepayment Balance")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SETFILTER("Cashier Name", USERID);
    end;
}

