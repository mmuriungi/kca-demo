page 54847 "HMS-General Patient Location"
{
    CardPageID = "HMS Patient Student Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HMS-Patient";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Patient Ref. No."; Rec."Patient Ref. No.")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Depandant Principle Member"; Rec."Depandant Principle Member")
                {
                    ApplicationArea = All;
                }
                field("Patient Current Location"; Rec."Patient Current Location")
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

