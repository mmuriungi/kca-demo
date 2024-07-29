page 54914 "HMS Radiology List"
{
    PageType = List;
    SourceTable = "HMS-Radiology Form Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Radiology No."; Rec."Radiology No.")
                {
                    ApplicationArea = All;
                }
                field("Radiology Date"; Rec."Radiology Date")
                {
                    ApplicationArea = All;
                }
                field("Radiology Time"; Rec."Radiology Time")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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

