page 51890 "ACA-Admission Form Medical"
{
    PageType = ListPart;
    SourceTable = "ACA-Adm. Form Medical Form";

    layout
    {
        area(content)
        {
            repeater(__)
            {
                field("Medical Condition Code"; Rec."Medical Condition Code")
                {
                    ApplicationArea = All;
                }
                field("Medical Condition Name"; Rec."Medical Condition Name")
                {
                    ApplicationArea = All;
                }
                field(Yes; Rec.Yes)
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

