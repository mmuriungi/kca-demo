page 54812 "HMS Admission Form Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS-Admission Form Header";

    layout
    {
        area(content)
        {
            repeater(Rep)
            {
                Editable = false;
                field("Admission No."; Rec."Admission No.")
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
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    ApplicationArea = All;
                }
                field("Admission Area"; Rec."Admission Area")
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

