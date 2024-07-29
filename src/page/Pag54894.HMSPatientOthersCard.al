page 54894 "HMS Patient Others Card"
{
    PageType = Document;
    SourceTable = "HMS-Patient";
    SourceTableView = WHERE(Blocked = FILTER(false),
                            "Patient Type" = FILTER(Others));

    layout
    {
        area(content)
        {
            group("Personal details")
            {
                Caption = 'Personal details';
                Editable = true;
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
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;
                }
                field(names; Rec.Surname + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name")
                {
                    Caption = 'Full Name';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
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

                    trigger OnValidate()
                    begin
                        IF Rec."Date Of Birth" <> 0D THEN BEGIN
                            Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
                        END;
                    end;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Age; Age)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Photo; Rec.Photo)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
            }
            group("Medical details")
            {
                Caption = 'Medical details';
                Editable = true;
                field("Examining Officer"; Rec."Examining Officer")
                {
                    ApplicationArea = All;
                }
                field("Medical Exam Date"; Rec."Medical Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Medical Details Not Covered"; Rec."Medical Details Not Covered")
                {
                    ApplicationArea = All;
                }
                field(Height; Rec.Height)
                {
                    ApplicationArea = All;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Relationship"; Rec."Emergency Consent Relationship")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Full Name"; Rec."Emergency Consent Full Name")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Address 1"; Rec."Emergency Consent Address 1")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Address 2"; Rec."Emergency Consent Address 2")
                {
                    ApplicationArea = All;
                }
                field("Emergency Consent Address 3"; Rec."Emergency Consent Address 3")
                {
                    ApplicationArea = All;
                }
                field("Emergency Date of Consent"; Rec."Emergency Date of Consent")
                {
                    ApplicationArea = All;
                }
                field("Emergency National ID Card No."; Rec."Emergency National ID Card No.")
                {
                    ApplicationArea = All;
                }
                field("Physical Impairment Details"; Rec."Physical Impairment Details")
                {
                    ApplicationArea = All;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }
                field("Without Glasses R.6"; Rec."Without Glasses R.6")
                {
                    ApplicationArea = All;
                }
                field("Without Glasses L.6"; Rec."Without Glasses L.6")
                {
                    ApplicationArea = All;
                }
                field("With Glasses R.6"; Rec."With Glasses R.6")
                {
                    ApplicationArea = All;
                }
                field("With Glasses L.6"; Rec."With Glasses L.6")
                {
                    ApplicationArea = All;
                }
                field("Hearing Right Ear"; Rec."Hearing Right Ear")
                {
                    ApplicationArea = All;
                }
                field("Hearing Left Ear"; Rec."Hearing Left Ear")
                {
                    ApplicationArea = All;
                }
                field("Condition Of Teeth"; Rec."Condition Of Teeth")
                {
                    ApplicationArea = All;
                }
                field("Condition Of Throat"; Rec."Condition Of Throat")
                {
                    ApplicationArea = All;
                }
                field("Condition Of Ears"; Rec."Condition Of Ears")
                {
                    ApplicationArea = All;
                }
                field("Condition Of Lymphatic Glands"; Rec."Condition Of Lymphatic Glands")
                {
                    ApplicationArea = All;
                }
                field("Condition Of Nose"; Rec."Condition Of Nose")
                {
                    ApplicationArea = All;
                }
                field("Circulatory System Pulse"; Rec."Circulatory System Pulse")
                {
                    ApplicationArea = All;
                }
            }
            group(Appointments)
            {
                Caption = 'Appointments';
                Editable = true;
            }
            group(Observation)
            {
                Caption = 'Observation';
                Editable = true;
                part(Part1; "HMS Observation SubForm")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Treatment)
            {
                Caption = 'Treatment';
                Editable = true;
                part(Part2; "HMS Treatment SubForm")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Laboratory)
            {
                Caption = 'Laboratory';
                Editable = true;
                part(Part3; "HMS Laboratory SubForm")
                {
                    Editable = false;
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Radiology)
            {
                Caption = 'Radiology';
                Editable = true;
                part(Part4; "HMS Radiology SubForm")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';
                Editable = true;
                part(Part5; "HMS Pharmacy SubForm")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Admission)
            {
                Caption = 'Admission';
                Editable = true;
                part(Part6; "HMS Admission SubForm")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Referrals)
            {
                Caption = 'Referrals';
                Editable = true;
                part(Part7; "HMS Referral SubForm")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group("Historical Medical Conditions")
            {
                Caption = 'Historical Medical Conditions';
                Editable = true;
                part(Part8; "HMS Patient Medical Condition")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group("Historical Immunizations")
            {
                Caption = 'Historical Immunizations';
                Editable = true;
                part(Part9; "HMS Patient Immunization")
                {
                    SubPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group("Spouse details (If Married)")
            {
                Caption = 'Spouse details (If Married)';
                Editable = true;
                field("Spouse Name"; Rec."Spouse Name")
                {
                    ApplicationArea = All;
                }
                field("Spouse Address 1"; Rec."Spouse Address 1")
                {
                    ApplicationArea = All;
                }
                field("Spouse Address 2"; Rec."Spouse Address 2")
                {
                    ApplicationArea = All;
                }
                field("Spouse Address 3"; Rec."Spouse Address 3")
                {
                    ApplicationArea = All;
                }
                field("Spouse Telephone No. 1"; Rec."Spouse Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Spouse Telephone No. 2"; Rec."Spouse Telephone No. 2")
                {
                    ApplicationArea = All;
                }
                field("Spouse Email"; Rec."Spouse Email")
                {
                    ApplicationArea = All;
                }
                field("Spouse Fax"; Rec."Spouse Fax")
                {
                    ApplicationArea = All;
                }
            }
            group("Correspondence Address")
            {
                Caption = 'Correspondence Address';
                Editable = true;
                field("Place of Birth Village"; Rec."Place of Birth Village")
                {
                    ApplicationArea = All;
                }
                field("Place of Birth Location"; Rec."Place of Birth Location")
                {
                    ApplicationArea = All;
                }
                field("Place of Birth District"; Rec."Place of Birth District")
                {
                    ApplicationArea = All;
                }
                field("Name of Chief"; Rec."Name of Chief")
                {
                    ApplicationArea = All;
                }
                field("Nearest Police Station"; Rec."Nearest Police Station")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 2"; Rec."Correspondence Address 2")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 3"; Rec."Correspondence Address 3")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 2"; Rec."Telephone No. 2")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Parent Details")
            {
                Caption = 'Parent Details';
                Editable = true;
                field("Mother Alive or Dead"; Rec."Mother Alive or Dead")
                {
                    ApplicationArea = All;
                }
                field("Mother Full Name"; Rec."Mother Full Name")
                {
                    ApplicationArea = All;
                }
                field("Mother Occupation"; Rec."Mother Occupation")
                {
                    ApplicationArea = All;
                }
                field("Father Alive or Dead"; Rec."Father Alive or Dead")
                {
                    ApplicationArea = All;
                }
                field("Father Full Name"; Rec."Father Full Name")
                {
                    ApplicationArea = All;
                }
                field("Father Occupation"; Rec."Father Occupation")
                {
                    ApplicationArea = All;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                }
                field("Guardian Occupation"; Rec."Guardian Occupation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Statistics)
            {
                Caption = 'Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS-Patient Card";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := TRUE;
        "Employee No.Enable" := TRUE;
        "Student No.Enable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."Patient Type"::Others;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        HasValue: Boolean;
        HRDates: Codeunit "HR Dates";
        Age: Text[100];
        [InDataSet]
        "Student No.Enable": Boolean;
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;

    procedure CheckPatientType()
    begin
        IF Rec."Patient Type" = Rec."Patient Type"::Others THEN BEGIN
            "Student No.Enable" := TRUE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
        END
        ELSE BEGIN
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := TRUE;
            "Relative No.Enable" := TRUE;
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        IF Rec."Date Of Birth" <> 0D THEN BEGIN
            Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
        END;
    end;
}

