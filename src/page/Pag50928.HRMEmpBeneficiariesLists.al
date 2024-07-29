page 50928 "HRM-Emp. Beneficiaries Lists"
{
    PageType = List;
    SourceTable = "HRM-Employee Beneficiaries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                }
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field(Relationship; Rec.Relationship)
                {
                }
                field(SurName; Rec.SurName)
                {
                }
                field("Other Names"; Rec."Other Names")
                {
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                }
                field("Office Tel No"; Rec."Office Tel No")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

