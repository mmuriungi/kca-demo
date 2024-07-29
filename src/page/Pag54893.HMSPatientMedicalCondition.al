page 54893 "HMS Patient Medical Condition"
{
    PageType = ListPart;
    InsertAllowed = true;
    Editable = true;
    SourceTable = "HMS-Patient Medical Condition";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Patient No"; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Medical Condition"; Rec."Medical Condition")
                {
                    ApplicationArea = All;
                }
                field("Medical Condition Name"; Rec."Medical Condition Name")
                {
                    ApplicationArea = All;
                }
                field("Date From"; Rec."Date From")
                {
                    ApplicationArea = All;
                }
                field("Date To"; Rec."Date To")
                {
                    ApplicationArea = All;
                }
                field(Yes; Rec.Yes)
                {
                    ApplicationArea = All;
                }
                field(Details; Rec.Details)
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

