page 51132 "HRM-Appraisal Registration Lis"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "HRM-Appraisal Registration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PF No."; Rec."PF No.")
                {
                    Editable = false;
                }
                field("Appraisal Period Code"; Rec."Appraisal Period Code")
                {
                    Editable = false;
                }
                field("Appraisal Job Code"; Rec."Appraisal Job Code")
                {
                    Editable = false;
                }
                field("Appraisal Year Code"; Rec."Appraisal Year Code")
                {
                    Editable = false;
                }
                field("Employee Category"; Rec."Employee Category")
                {
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    Editable = false;
                }
                field(Award; Rec.Award)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

