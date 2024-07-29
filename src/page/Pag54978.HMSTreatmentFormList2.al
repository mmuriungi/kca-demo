page 54978 "HMS-Treatment Form List 2"
{
    CardPageID = "HMS Treatment Form History";
    Editable = false;
    PageType = List;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = WHERE(Status = CONST(Completed));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    Caption = '"Treatment No."';
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

                    trigger OnValidate()
                    begin
                        GetDoctorName(Rec."Doctor ID", DoctorName);
                    end;
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
        }
    }

    actions
    {
        area(processing)
        {
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

