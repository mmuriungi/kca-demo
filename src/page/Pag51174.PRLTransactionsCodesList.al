page 51174 "PRL-Transactions Codes List"
{
    CardPageID = "PRL-Transaction Code";
    PageType = List;
    SourceTable = "PRL-Transaction Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code"; Rec."Transaction Code")
                {
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                }
                field("Balance Type"; Rec."Balance Type")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Is Cash"; Rec."Is Cash")
                {
                }
                field(Taxable; Rec.Taxable)
                {
                }
                field("Is Formula"; Rec."Is Formula")
                {
                }
                field(Formula; Rec.Formula)
                {
                }
                field("Amount Preference"; Rec."Amount Preference")
                {
                }
                field("Special Transactions"; Rec."Special Transactions")
                {
                }
                field("Deduct Premium"; Rec."Deduct Premium")
                {
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                }
                field("Fringe Benefit"; Rec."Fringe Benefit")
                {
                }
                field("Employer Deduction"; Rec."Employer Deduction")
                {
                }
                field(isHouseAllowance; Rec.isHouseAllowance)
                {
                }
                field("Include Employer Deduction"; Rec."Include Employer Deduction")
                {
                }
                field("Is Formula for employer"; Rec."Is Formula for employer")
                {
                }
                field("Transaction Code old"; Rec."Transaction Code old")
                {
                }
                field("GL Account"; Rec."GL Account")
                {
                }
                field("GL Employee Account"; Rec."GL Employee Account")
                {
                }
                field("coop parameters"; Rec."coop parameters")
                {
                }
                field("IsCoop/LnRep"; Rec."IsCoop/LnRep")
                {
                }
                field("Deduct Mortgage"; Rec."Deduct Mortgage")
                {
                }
                field(Subledger; Rec.Subledger)
                {
                }
                field(Welfare; Rec.Welfare)
                {
                }
                field(CustomerPostingGroup; Rec.CustomerPostingGroup)
                {
                }
            }
        }
    }

    actions
    {
    }
}

