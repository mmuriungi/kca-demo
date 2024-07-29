page 54887 "HMS-Patient Documents"
{
    Caption = 'Patient Documents View';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
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
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Patient Ref. No."; Rec."Patient Ref. No.")
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
            group("Documents View")
            {
                Caption = 'Documents View';
                Image = LotInfo;
                action(Appointments)
                {
                    Caption = 'Appointments';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Appointments Listing";
                    ApplicationArea = All;
                }
                action("Observation List")
                {
                    Caption = 'Observation List';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Observation Listing Report";
                    ApplicationArea = All;
                }
                action("Treatment List")
                {
                    Caption = 'Treatment List';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Treatment Listing Report";
                    ApplicationArea = All;
                }
                action("Laboratory Test(s) Summary")
                {
                    Caption = 'Laboratory Test(s) Summary';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Laboratory Test Summary";
                    ApplicationArea = All;
                }
                action("Laboratory Test(s) Detailed")
                {
                    Caption = 'Laboratory Test(s) Detailed';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Laboratory Test Detailed";
                    ApplicationArea = All;
                }
                action("Laboratory Test(s) Finding")
                {
                    Caption = 'Laboratory Test(s) Finding';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Laboratory Test Finding";
                    ApplicationArea = All;
                }
                action("Phamacy Drag Issue(s) Summary")
                {
                    Caption = 'Phamacy Drag Issue(s) Summary';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Pharmacy Issues Report";
                    ApplicationArea = All;
                }
                action("Phamacy Drag Ussue")
                {
                    Caption = 'Phamacy Drag Ussue';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Pharmacy Issues Report";
                    ApplicationArea = All;
                }
                action("Patient Listing")
                {
                    Caption = 'Patient Listing';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Patient Listing Report";
                    ApplicationArea = All;
                }
                action("Admission listing")
                {
                    Caption = 'Admission listing';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Admission Listing Summary";
                    ApplicationArea = All;
                }
                action("Referrals listing")
                {
                    Caption = 'Referrals listing';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Referral Listing Report";
                    ApplicationArea = All;
                }
                action("Daily Attendance (Outpatient)")
                {
                    Caption = 'Daily Attendance (Outpatient)';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Daily Attendance Report";
                    ApplicationArea = All;
                }
                action("Injection Register")
                {
                    Caption = 'Injection Register';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Injection Register Report";
                    ApplicationArea = All;
                }
            }
            group("&Periodic Activities")
            {
                Caption = '&Periodic Activities';
                Image = RegisteredDocs;
                action("Process Employee & Detpt")
                {
                    Caption = 'Process Employee & Detpt';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report "HMS Process Employee & Deps";
                    ApplicationArea = All;
                }
                /* action("Process Student Patients")
                {
                    Caption = 'Process Student Patients';
                    Image = "Report";
                    Promoted = true;
                    RunObject = Report 51403;
                } */
            }
        }
    }
}

