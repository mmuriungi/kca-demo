page 50765 "ACA-Stud. Online Results"
{
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Student Units";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Final Score"; Rec."Final Score")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Result Status"; Rec."Result Status")
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

