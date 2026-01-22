page 51752 "HMS Patient Employee Card"
{
    PageType = Card;
    SourceTable = "HMS-Patient";
    SourceTableView = WHERE(Blocked = FILTER(false),
                            "Patient Type" = FILTER(Employee));

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
                field("Employee No."; Rec."Employee No.")
                {
                    Enabled = "Employee No.Enable";
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Enabled = "Relative No.Enable";
                    ApplicationArea = All;
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
                            Rec.Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
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
                field(Age; Rec.Age)
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
            group("Employee Dependants")
            {
                Caption = 'Employee Dependants';
                part(DependantsList; "HRM-Employees Dependants")
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee Code" = field("Employee No.");
                    UpdatePropagation = Both;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Employee Information")
            {
                Caption = 'Employee Information';
                action("Employee Card")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Card';
                    Image = Employee;
                    ToolTip = 'View the employee record';
                    RunObject = Page "HRM-Employee (B)";
                    RunPageLink = "No." = field("Employee No.");
                }
                action("Employee Dependants")
                {
                    ApplicationArea = All;
                    Caption = 'All Employee Dependants';
                    Image = Relatives;
                    ToolTip = 'View all dependants of this employee';
                    RunObject = Page "HRM-Employees Dependants";
                    RunPageLink = "Employee Code" = field("Employee No.");
                }
            }
            group("Medical Information")
            {
                Caption = 'Medical Information';
                action("Dependant Patients")
                {
                    ApplicationArea = All;
                    Caption = 'Dependant Patients';
                    Image = CustomerList;
                    ToolTip = 'View dependants who are registered as patients';
                    RunObject = Page "HRM-Employees Dependants";
                    RunPageLink = "Employee Code" = FIELD("Employee No."), Type = FILTER(Dependant);
                    RunPageView = WHERE(Type = FILTER(Dependant));
                }
                action("Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Claims';
                    Image = Insurance;
                    ToolTip = 'View medical claims for this employee and dependants';
                    RunObject = Page "Medical Claims List";
                    RunPageLink = "Member No" = field("Employee No.");
                }
            }
        }
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
            action("Register Dependants as Patients")
            {
                ApplicationArea = All;
                Caption = 'Register Dependants as Patients';
                Image = NewCustomer;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Register employee dependants as patients in the medical system';

                trigger OnAction()
                begin
                    RegisterDependantsAsPatients();
                end;
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
        //"Student No.Enable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Patient Type" := Rec."Patient Type"::Employee;
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
            Rec.Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
        END;
    end;

    local procedure RegisterDependantsAsPatients()
    var
        HRMEmployeeKin: Record "HRM-Employee Kin";
        HMSPatient: Record "HMS-Patient";
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        RegisteredCount: Integer;
        SkippedCount: Integer;
        DependantName: Text;
    begin
        if not Confirm('Do you want to register all unregistered dependants of this employee as patients?') then
            exit;

        HMSSetup.Get();
        HMSSetup.TestField("Patient Nos");

        HRMEmployeeKin.SetRange("Employee Code", Rec."Employee No.");
        HRMEmployeeKin.SetRange(Type, HRMEmployeeKin.Type::Dependant);

        if HRMEmployeeKin.FindSet() then begin
            repeat
                DependantName := HRMEmployeeKin."Other Names" + ' ' + HRMEmployeeKin.SurName;

                // Check if dependant is already registered as a patient
                HMSPatient.SetRange("Employee No.", Rec."Employee No.");
                HMSPatient.SetRange("Patient Type", HMSPatient."Patient Type"::Dependant);
                HMSPatient.SetRange("ID Number", HRMEmployeeKin."ID No/Passport No");

                if not HMSPatient.FindFirst() then begin
                    // Create new patient record for dependant
                    HMSPatient.Init();
                    HMSPatient."Patient No." := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", Today, true);
                    HMSPatient."No. Series" := HMSSetup."Patient Nos";
                    HMSPatient."Date Registered" := Today;
                    HMSPatient."Patient Type" := HMSPatient."Patient Type"::Dependant;
                    HMSPatient."Patient Type2" := HMSPatient."Patient Type2"::Employee;
                    HMSPatient."Employee No." := Rec."Employee No.";
                    HMSPatient."Full Name" := DependantName;
                    HMSPatient."Date Of Birth" := HRMEmployeeKin."Date Of Birth";
                    HMSPatient."ID Number" := HRMEmployeeKin."ID No/Passport No";
                    HMSPatient."Telephone No. 1" := HRMEmployeeKin."Home Tel No";
                    HMSPatient."Emergency Consent Full Name" := Rec."Full Name";
                    HMSPatient."Emergency Consent Relationship" := HRMEmployeeKin.Relationship;
                    HMSPatient."Emergency Consent Address 2" := Rec."Telephone No. 1";
                    HMSPatient."Correspondence Address 1" := HRMEmployeeKin.Address;

                    if HMSPatient.Insert(true) then
                        RegisteredCount += 1;
                end else
                    SkippedCount += 1;

            until HRMEmployeeKin.Next() = 0;

            Message('Registration completed:\Registered: %1 dependant(s)\Skipped (already registered): %2 dependant(s)',
                RegisteredCount, SkippedCount);
        end else
            Message('No dependants found for this employee.');

        CurrPage.Update();
    end;
}

