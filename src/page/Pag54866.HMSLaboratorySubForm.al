page 54866 "HMS Laboratory SubForm"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS-Laboratory Form Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Time"; Rec."Scheduled Time")
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
                field(Remarks; Rec.Remarks)
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

