page 54909 "HMS Pharmacy SubForm"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS-Pharmacy Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Pharmacy No."; Rec."Pharmacy No.")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Date"; Rec."Pharmacy Date")
                {
                    ApplicationArea = All;
                }
                field("Pharmacy Time"; Rec."Pharmacy Time")
                {
                    ApplicationArea = All;
                }
                field("Issued By"; Rec."Issued By")
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
}

