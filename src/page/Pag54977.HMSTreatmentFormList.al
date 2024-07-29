page 54977 "HMS-Treatment Form List"
{
    CardPageID = "HMS-Treatment Form Header";
    PageType = List;
    SourceTable = "HMS-Treatment Form Header";
    SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    Caption = 'Treatment No.';
                    ApplicationArea = All;
                }
                field("Treatment Location"; Rec."Treatment Location")
                {
                    ApplicationArea = All;
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    ApplicationArea = All;
                }
                field(Direct; Rec.Direct)
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF (Rec."Treatment Type" = Rec."Treatment Type"::Outpatient) AND (Rec.Direct = FALSE) THEN BEGIN
                            Observation.RESET;
                            IF Observation.GET(Rec."Link No.") THEN BEGIN
                                Rec."Patient No." := Observation."Patient No.";
                                GetPatientNo(Observation."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                Rec."Link Type" := 'Observation';
                            END;
                        END
                        ELSE
                            IF (Rec."Treatment Type" = Rec."Treatment Type"::Outpatient) AND (Rec.Direct = TRUE) THEN BEGIN
                                Appointment.RESET;
                                IF Appointment.GET(Rec."Link No.") THEN BEGIN
                                    Rec."Patient No." := Appointment."Patient No.";
                                    GetPatientNo(Appointment."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                                    Rec."Link Type" := 'Appointment';
                                END;
                            END
                            ELSE
                                IF Rec."Treatment Type" = Rec."Treatment Type"::Inpatient THEN BEGIN
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
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Student/Emp/Rel No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Remarks"; Rec."Treatment Remarks")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'PF No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No.2"; Rec."Employee No.")
                {
                    Editable = false;
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
            action("&Mark as Completed")
            {
                Caption = '&Mark as Completed';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Ask for confirmation*/
                    IF CONFIRM('Mark the Treatment as Completed?', FALSE) = FALSE THEN BEGIN EXIT END;
                    Rec.TESTFIELD("Treatment Date");
                    Rec.Status := Rec.Status::Completed;
                    Rec.MODIFY;
                    MESSAGE('Treatment Marked as Completed');

                end;
            }
            action("Referral Progress")
            {
                Caption = 'Referral Progress';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Referral Header Active";
                RunPageLink = "Treatment no." = FIELD("Treatment No.");
                ApplicationArea = All;
            }
            action("Admission Details")
            {
                Caption = 'Admission Details';
                Image = RegisteredDocs;
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
                Image = ResourceJournal;
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
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS-Labaratory Test Line";
                ApplicationArea = All;

                trigger OnAction()
                begin

                    Labrecords.RESET;
                    Labrecords.SETRANGE(Labrecords."Patient No.", Rec."Patient No.");
                    Labrecords.SETRANGE(Labrecords.Status, Labrecords.Status::Completed);
                    IF Labrecords.FIND('-') THEN BEGIN
                        LabResults.SETTABLEVIEW(Labrecords);
                        LabResults.RUN;
                    END;
                end;
            }
            action("Observation Room")
            {
                Caption = 'Observation Room';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ObservationRec.RESET;
                    ObservationRec.SETRANGE(ObservationRec."Patient No.", Rec."Patient No.");
                    ObservationRec.SETRANGE(ObservationRec."Observation No.", Rec."Link No.");
                    IF ObservationRec.FIND('-') THEN BEGIN
                        ObservationForm.SETTABLEVIEW(ObservationRec);
                        ObservationForm.RUN;
                    END
                    ELSE
                        MESSAGE('No Observation details available for this patient!');
                end;
            }
        }
    }

    trigger OnInit()
    begin
        /*
        "Off Duty CommentsEnable" := TRUE;
        "Light Duty DaysEnable" := TRUE;
        "Off Duty DaysEnable" := TRUE;
        */

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Direct := TRUE;
        // "Doctor ID":=USERID;
    end;

    var
        PatientName: Text[100];
        DoctorName: Text[30];
        Patient: Record "HMS-Patient";
        Doctor: Record "HMS-Setup Doctor";
        Observation: Record "HMS-Observation Form Header";
        Admission: Record "HMS-Admission Form Header";
        Appointment: Record "HMS-Appointment Form Header";
        Labrecords: Record "HMS-Laboratory Form Header";
        ObservationRec: Record "HMS-Observation Form Header";
        [InDataSet]
        "Off Duty DaysEnable": Boolean;
        [InDataSet]
        "Light Duty DaysEnable": Boolean;
        [InDataSet]
        "Off Duty CommentsEnable": Boolean;
        LabResults: Page "HMS Laboratory Form History";
        ObservationForm: Page "HMS Observation Form Header Cl";


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

