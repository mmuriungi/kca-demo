page 54839 "HMS-Doctor List List"
{
    Caption = 'Doctor''s List';
    CardPageID = "HMS-Doctors List";
    Editable = false;
    PageType = List;
    SourceTable = "HMS-Patient";
    SourceTableView = WHERE(Blocked = FILTER(false),
                           "Patient Current Location" = FILTER(= "Doctor List" | = Laboratory | = Phamacy | = "Radiology Room"),
                            "Doctor Visit Status" = FILTER(Doctor));

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
        area(creation)
        {
            action("Treatment List")
            {
                Caption = 'Treatment List';
                Image = List;
                Promoted = true;
                RunObject = Page "HMS-Treatment List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ApplicationArea = All;
            }
            group("&Functions")
            {
                Caption = '&Functions';
            }
        }
    }
}

