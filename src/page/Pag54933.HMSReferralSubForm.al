page 54933 "HMS Referral SubForm"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS-Referral Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Treatment no."; Rec."Treatment no.")
                {
                    ApplicationArea = All;
                }
                field("Hospital No."; Rec."Hospital No.")
                {
                    ApplicationArea = All;
                }
                field("Date Referred"; Rec."Date Referred")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Referral Reason"; Rec."Referral Reason")
                {
                    ApplicationArea = All;
                }
                field("Referral Remarks"; Rec."Referral Remarks")
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

