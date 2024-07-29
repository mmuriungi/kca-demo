page 50012 "FIN-Imprest Surr. Details UP"
{
    PageType = ListPart;
    SourceTable = "FIN-Imprest Surrender Details";

    layout
    {
        area(content)
        {
            repeater(___________)
            {
                field("Account No:"; Rec."Account No:")
                {
                    ApplicationArea = All;
                }
                field("Surrender Doc No."; Rec."Surrender Doc No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Acc interest Amount"; Rec."Acc interest Amount")
                {
                    ApplicationArea = all;

                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = All;
                }
                field("Over Expenditure"; "Over Expenditure")
                {
                    ApplicationArea = all;
                }
                field("Claim Type"; "Claim Type")
                {
                    ApplicationArea = ALL;
                }
                field("Claim Account"; "Claim Account")
                {
                    ApplicationArea = ALL;
                }
                field("Cash Receipt No"; Rec."Cash Receipt No")
                {
                    ApplicationArea = All;
                }
                field("Cash Receipt Amount"; Rec."Cash Receipt Amount")
                {
                    ApplicationArea = All;
                }
                field("Bank/Petty Cash"; Rec."Bank/Petty Cash")
                {
                    ApplicationArea = All;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    ApplicationArea = all;
                }
                field("Date Cash Collected"; "Date Cash Collected")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Amt: Decimal;
}
