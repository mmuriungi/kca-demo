#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 77343 "PosteBatch Hostel Alloc. Dets."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "ACA-Batch Room Alloc. Details";
    SourceTableView = where("posted to Hostels?" = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = Basic;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = Basic;
                }
                field("Room Space"; Rec."Room Space")
                {
                    ApplicationArea = Basic;
                }
                field("Room Cost"; Rec."Room Cost")
                {
                    ApplicationArea = Basic;
                }
                field("Notification Send"; Rec."Notification Send")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("posted to Hostels?"; Rec."posted to Hostels?")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Imported By"; Rec."Imported By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Date Imported"; Rec."Date Imported")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Time Imported"; Rec."Time Imported")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

