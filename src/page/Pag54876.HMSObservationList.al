page 54876 "HMS-Observation List"
{
    PageType = List;
    SourceTable = "HMS-Observation Form Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Observation No."; Rec."Observation No.")
                {
                    ApplicationArea = All;
                }
                field("Observation Type"; Rec."Observation Type")
                {
                    ApplicationArea = All;
                }
                field("Observation Date"; Rec."Observation Date")
                {
                    ApplicationArea = All;
                }
                field("Observation Time"; Rec."Observation Time")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Observation User ID"; Rec."Observation User ID")
                {
                    ApplicationArea = All;
                }
                field("Observation Remarks"; Rec."Observation Remarks")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

