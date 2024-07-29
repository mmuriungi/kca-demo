page 54974 "HMS Treatment Form History"
{
    //Editable = false;
    PageType = Card;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = WHERE(Status = CONST(Completed));
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Group)
            {
                editable = false;
                field("Treatment No."; Rec."Treatment No.")
                {
                    Caption = 'Treatment No.';
                    ApplicationArea = All;
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Observation: Record "HMS-Observation Form Header";
                        Admission: Record "HMS-Admission Form Header";
                    begin
                        IF Rec."Treatment Type" = Rec."Treatment Type"::Inpatient THEN BEGIN
                            Observation.RESET;
                            IF Observation.GET(Rec."Link No.") THEN BEGIN
                                Rec."Patient No." := Observation."Patient No.";
                                GetPatientNo(Observation."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                Rec."Link Type" := 'Observation';
                            END;
                        END
                        ELSE BEGIN
                            Admission.RESET;
                            IF Admission.GET(Rec."Link No.") THEN BEGIN
                                Rec."Patient No." := Admission."Patient No.";
                                GetPatientNo(Admission."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                Rec."Link Type" := 'Admission';
                            END;
                        END;
                        GetPatientName(Rec."Patient No.", PatientName);
                    end;
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ApplicationArea = All;
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ApplicationArea = All;
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = All;

                    // trigger OnValidate()
                    // begin
                    //     GetDoctorName(Rec."Doctor ID", DoctorName);
                    // end;
                }
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Student/Emp/Rel No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Remarks"; Rec."Treatment Remarks")
                {
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Processes1)
            {
                editable = false;
                Caption = 'Processes';
                part(Page; "HMS-Treatment Form Processes")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }////HMS Observation Symptoms

            group(symp)
            {
                editable = false;
                Caption = 'Symptoms';
                part(Part9; "HMS Observation Symptoms")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }

            group(Laboratory)
            {
                editable = false;
                Caption = 'Laboratory';
                part(Part2; "HMS-Treatment Form Laboratory")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No."), "Patient No." = field("Patient No.");
                    ApplicationArea = All;
                }
            }
            group(Radiology)
            {
                editable = false;
                Caption = 'Radiology';
                part(Part3; "HMS-Treatment Form Radiology")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
            group(Diagnosis)
            {
                Caption = 'Diagnosis';
                part(Part4; "HMS-Treatment Form Diagnosis")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
            group(Injections2)
            {
                Caption = 'Injections';
                part(Part5; "HMS-Treatment Form Injection")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
            group(Prescription)
            {
                editable = false;
                Caption = 'Prescription';
                part(Part6; "HMS-Treatment Form Drug")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
            group(Admission)
            {
                editable = false;
                Caption = 'Admission';
                part(Part7; "HMS-Treatment Form Admission")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
            group(Referrals2)
            {
                editable = false;
                Caption = 'Referrals';
                part(Part8; "HMS-Treatment Form Referral")
                {
                    SubPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("&Treatment Details")
            {
                Caption = '&Treatment Details';
                Image = Ledger;
                action(Processes)
                {
                    Caption = 'Processes';
                    Image = Production;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Processes";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Signs)
                {
                    Caption = 'Signs';
                    Image = RegisteredDocs;
                    Promoted = true;
                    RunObject = Page "HMS Observation Signs";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Symptoms)
                {
                    Caption = 'Symptoms';
                    Image = RegisterPick;
                    Promoted = true;
                    RunObject = Page "HMS Observation Symptoms";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(History)
                {
                    Caption = 'History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Laboratory Needs")
                {
                    Caption = 'Laboratory Needs';
                    Image = TestFile;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Laboratory";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Radiology Needs")
                {
                    Caption = 'Radiology Needs';
                    Image = ReleaseShipment;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Radiology";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Diagmnosis)
                {
                    Caption = 'Diagmnosis';
                    Image = AnalysisView;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Diagnosis";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Injections)
                {
                    Caption = 'Injections';
                    Image = Reconcile;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Injection";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Prescriptions)
                {
                    Caption = 'Prescriptions';
                    Image = ItemAvailability;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Drug";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Referrals)
                {
                    Caption = 'Referrals';
                    Image = Reconcile;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Referral";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action(Admissions)
                {
                    Caption = 'Admissions';
                    Image = Account;
                    Promoted = true;
                    RunObject = Page "HMS-Treatment Form Admission";
                    RunPageLink = "Treatment No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
            }
            group(res)
            {
                Caption = 'Results';
                Image = ReferenceData;
                action("Referral Progress")
                {
                    Caption = 'Referral Progress';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Active";
                    RunPageLink = "Treatment no." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Admission Details")
                {
                    Caption = 'Admission Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Admission Progress";
                    RunPageLink = "Link Type" = CONST('DOCTOR'),
                                  "Link No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Radiology Results")
                {
                    Caption = 'Radiology Results';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS-Radiology View Test Header";
                    RunPageLink = "Link Type" = CONST('DOCTOR'),
                                  "Link No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Laboratory Results")
                {
                    Caption = 'Laboratory Results';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS-Laboratory View Test";
                    RunPageLink = "Request Area" = CONST(Doctor),
                                  "Link No." = FIELD("Treatment No.");
                    ApplicationArea = All;
                }
                action("Observation Room")
                {
                    Caption = 'Observation Room';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS-Observation Form Header";
                    RunPageLink = "Observation No." = FIELD("Link No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        PatientName: Text[100];
        DoctorName: Text[30];
        Patient: Record "HMS-Patient";
        Doctor: Record "HMS-Setup Doctor";
        Observation: Record "HMS-Observation Form Header";
        Admission: Record "HMS-Admission Form Header";


    procedure GetPatientNo(var PatientNo: Code[20]; var "Student No.": Code[20]; var "Employee No.": Code[20]; var "Relative No.": Integer)
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            "Student No." := Patient."Student No.";
            "Employee No." := Patient."Employee No.";
            "Relative No." := Patient."Relative No.";
        END;
    end;


    procedure GetDoctorName(var DoctorID: Code[20]; var DoctorName: Text[30])
    begin
        Doctor.RESET;
        DoctorName := '';
        IF Doctor.GET(DoctorID) THEN BEGIN
            //Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctor's Name";
        END;
    end;


    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetDoctorName(Rec."Doctor ID", DoctorName);
    end;
}

