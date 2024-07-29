page 51861 "ACA-Application Form Qualif."
{
    Caption = 'Employment Details';
    PageType = ListPart;
    SourceTable = "ACA-Applic. Form Qualification";

    layout
    {
        area(content)
        {
            repeater(___)
            {
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec."Position(Role)")
                {
                    ApplicationArea = All;
                }
                // field(Award; Rec.Award)
                // {
                //     ApplicationArea = All;
                // }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
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

