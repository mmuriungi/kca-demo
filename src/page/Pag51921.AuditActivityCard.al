page 51921 "Audit-Activity Card"
{
    PageType = Card;
    SourceTable = "Audit-Activity";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Depart Code"; Rec."Depart Code")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Activities; Rec.Activities)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Timeline; Rec.Timeline)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field("Review Date"; Rec."Review Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("End of Review"; Rec."End of Review")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

