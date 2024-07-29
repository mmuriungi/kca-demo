page 54967 "HMS Syptoms"
{
    PageType = List;
    SourceTable = "HMS-Symptoms Setup";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Treatment no"; Rec."Treatment no")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Syptom Code"; Rec."Syptom Code")
                {
                    ApplicationArea = All;
                }
                field("Symptom Name"; Rec."Symptom Name")
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

