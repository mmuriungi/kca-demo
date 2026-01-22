page 51745 "HMS Observation Symptoms"
{
    PageType = ListPart;
    SourceTable = "HMS-Observation Symptoms";
    Caption = 'Signs and Sympotms';

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("sign & Symptom Code"; Rec."Symptom Code")
                {
                    ApplicationArea = All;
                }
                field("sign & Symptom Code Description"; Rec."Symptom Description")
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Characteristics; Rec.Characteristics)
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

