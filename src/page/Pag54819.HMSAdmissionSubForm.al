page 54819 "HMS Admission SubForm"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS-Admission Form Header";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    ApplicationArea = All;
                }
                field(Ward; Rec.Ward)
                {
                    ApplicationArea = All;
                }
                field(Bed; Rec.Bed)
                {
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Admission Reason"; Rec."Admission Reason")
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

