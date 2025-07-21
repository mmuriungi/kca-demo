page 52029 "Project Team"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Project Team";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Designation"; Rec."Designation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

