page 51085 "HRM-Emp. Qualifications (B)"
{
    PageType = ListPart;
    SourceTable = "HRM-Emp. Qualifications Final";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = all;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Highest Qualification"; Rec."Highest Qualification")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

