page 54962 "HMS-Setups Management"
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
            group("Setups Management")
            {
                Caption = 'Setups Management';
                Image = Setup;
                action("Setup Card")
                {
                    Caption = 'Setup Card';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Card";
                    ApplicationArea = All;
                }
                action("Systems Setup")
                {
                    Caption = 'Systems Setup';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Systems Card";
                    ApplicationArea = All;
                }
                action(Doctors)
                {
                    Caption = 'Doctors';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Doctors List";
                    ApplicationArea = All;
                }
                action("Blood Group")
                {
                    Caption = 'Blood Group';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Blood Group Card";
                    ApplicationArea = All;
                }
                action("Blood Group Donation")
                {
                    Caption = 'Blood Group Donation';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Blood Group Donation Card";
                    ApplicationArea = All;
                }
                action("Drug Interaction")
                {
                    Caption = 'Drug Interaction';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Drug Interaction Header";
                    ApplicationArea = All;
                }
                action("Observation Signs")
                {
                    Caption = 'Observation Signs';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Observation Signs";
                    ApplicationArea = All;
                }
                action("Appointment Type")
                {
                    Caption = 'Appointment Type';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Appointment Typ Card";
                    ApplicationArea = All;
                }
                action("Triage Tests Setup")
                {
                    Caption = 'Triage Tests Setup';
                    Image = SetupList;
                    Promoted = true;
                    //RunObject = Page 68097;
                    ApplicationArea = All;
                }
                action("Vital Process")
                {
                    Caption = 'Vital Process';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Process Card";
                    ApplicationArea = All;
                }
                action(Injection)
                {
                    Caption = 'Injection';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Injection Card";
                    ApplicationArea = All;
                }
                action(Diagnosis)
                {
                    Caption = 'Diagnosis';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Diagnosis Card";
                    ApplicationArea = All;
                }
                action(Immunization)
                {
                    Caption = 'Immunization';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "ACA-Immunization Card";
                    ApplicationArea = All;
                }
                action(Allergy)
                {
                    Caption = 'Allergy';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Allergy Card";
                    ApplicationArea = All;
                }
                action(Signs)
                {
                    Caption = 'Signs';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Signs";
                    ApplicationArea = All;
                }
                action(Syptoms)
                {
                    Caption = 'Syptoms';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Syptoms";
                    ApplicationArea = All;
                }
                action("Patient History")
                {
                    Caption = 'Patient History';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Patient History";
                    ApplicationArea = All;
                }
                action("Measuring Unit(s)")
                {
                    Caption = 'Measuring Unit(s)';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Measuring Unit Card";
                    ApplicationArea = All;
                }
                action(Specimen)
                {
                    Caption = 'Specimen';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Specimen Card";
                    ApplicationArea = All;
                }
                action("Laboratory Tests")
                {
                    Caption = 'Laboratory Tests';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Lab Test Card";
                    ApplicationArea = All;
                }
                action("Radiology Type")
                {
                    Caption = 'Radiology Type';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS-Setup Radiology Type Card";
                    ApplicationArea = All;
                }
                action("Admission Discharge Process")
                {
                    Caption = 'Admission Discharge Process';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Setup Disctarge Process";
                    ApplicationArea = All;
                }
                action("Ward Setup")
                {
                    Caption = 'Ward Setup';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS ward Setup";
                    ApplicationArea = All;
                }
                action(Beds)
                {
                    Caption = 'Beds';
                    Image = SetupList;
                    Promoted = true;
                    RunObject = Page "HMS Beds";
                    ApplicationArea = All;
                }
                action(Charges)
                {
                    Caption = 'Charges';
                    Image = SetupPayment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS-Hospital Charges Setup";
                    ApplicationArea = All;
                }
            }
        }
    }
}

