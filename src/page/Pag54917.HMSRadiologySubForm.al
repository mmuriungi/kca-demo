page 54917 "HMS Radiology SubForm"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
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
}

