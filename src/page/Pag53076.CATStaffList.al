page 53076 "CAT-Staff List"
{
    Editable = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = WHERE("Customer Posting Group" = CONST('IMPREST'));

    layout
    {
        area(content)
        {
            repeater(tre)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field(Address; Rec.Address)
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Telex No."; Rec."Telex No.")
                {
                }
                field(Age; Rec.Age)
                {
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                }
                field(Gender; Rec.Gender)
                {
                }
                field("Marital Status"; Rec."Marital Status")
                {
                }
                field("Blood Group"; Rec."Blood Group")
                {
                }
                field(Weight; Rec.Weight)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field(Religion; Rec.Religion)
                {
                }
                field(Citizenship; Rec.Citizenship)
                {
                }
                field("Payments By"; Rec."Payments By")
                {
                }
                field("ID No"; Rec."ID No")
                {
                }
                field("Customer Type"; Rec."Customer Type")
                {
                }
                field("Birth Cert"; Rec."Birth Cert")
                {
                }
                field("Staff No."; Rec."Staff No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

