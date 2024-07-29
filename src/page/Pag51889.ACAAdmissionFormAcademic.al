page 51889 "ACA-Admission Form Academic"
{
    PageType = ListPart;
    SourceTable = "ACA-Adm. Form Academic";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
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

