//page 52178752 "FIN-Memo Details"
page 50330 "FIN-Memo Details"
{
    PageType = List;
    SourceTable = "FIN-Memo Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Payee Type"; Rec."Payee Type")
                {
                }
                field("Staff no."; Rec."Staff no.")
                {
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = false;
                    Enabled = false;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    Editable = false;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                }
                field(Days; Rec.Days)
                {

                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    Enabled = false;
                }
                field("PAYE Amount"; Rec."PAYE Amount")
                {
                    Editable = false;
                    Enabled = false;
                    visible = false;
                }
                field("Compute P.A.Y.E."; Rec."Compute P.A.Y.E.")
                {
                    visible = false;
                }
                field("P.A.Y.E. Rate"; Rec."P.A.Y.E. Rate")
                {
                    Editable = false;
                    Enabled = false;
                    visible = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    Editable = false;
                    Enabled = false;
                    visible = false;
                }
                field("Period Month"; Rec."Period Month")
                {
                    Editable = false;
                    Enabled = false;
                    visible = false;
                }
                field("Period Year"; Rec."Period Year")
                {
                    Editable = false;
                    Enabled = false;
                    visible = false;
                }
                field("Current Gross"; Rec."Current Gross")
                {
                    visible = false;
                }
                field("Is Taxable"; Rec."Is Taxable")
                {
                    visible = false;
                    Editable = false;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }
}