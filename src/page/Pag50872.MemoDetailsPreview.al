page 50872 "Memo Details Preview"
{
    Editable = false;
    PageType = List;
    SourceTable = "FIN-Memo Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Memo No."; Rec."Memo No.")
                {
                }
                field("Staff no."; Rec."Staff no.")
                {
                }
                field("Expense Code"; Rec."Expense Code")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                }
                field(Rate; Rec.Rate)
                {
                }
                field(Days; Rec.Days)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("P.A.Y.E. Rate"; Rec."P.A.Y.E. Rate")
                {
                }
                field("PAYE Amount"; Rec."PAYE Amount")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Is Taxable"; Rec."Is Taxable")
                {
                }
                field("Payee Type"; Rec."Payee Type")
                {
                }
                field("Memo Status"; Rec."Memo Status")
                {
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                }
                field("Period Month"; Rec."Period Month")
                {
                }
                field("Period Year"; Rec."Period Year")
                {
                }
            }
        }
    }

    actions
    {
    }
}

