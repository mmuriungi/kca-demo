page 51056 "HRM-Induction Part. List"
{
    PageType = ListPart;
    SourceTable = "HRM-Staff  Induction";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Induction Code"; Rec."Induction Code")
                {
                }
                field("Employee Code"; Rec."Employee Code")
                {
                }
                field("Employee name"; Rec."Employee name")
                {
                }
                field("Officer Incharge"; Rec."Officer Incharge")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(From; Rec.From)
                {
                }
                field(Todate; Rec.Todate)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Days Attended"; Rec."Days Attended")
                {
                }
                field(Depatment; Rec.Depatment)
                {
                    Caption = 'Department';
                }
                field("Induction Status"; Rec."Induction Status")
                {
                }
            }
        }
    }

    actions
    {
    }
}

