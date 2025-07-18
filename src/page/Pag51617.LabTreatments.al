page 51617 "Lab Treatments"
{
    PageType = ListPart;
    Editable = true;
    InsertAllowed = true;
    SourceTable = "HMS-Treatment Form Header";
    // SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Treatment No.";
                Rec."Treatment No.")
                {
                    Caption = 'Treatment No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Treatment Location"; Rec."Treatment Location")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment Type"; Rec."Treatment Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Direct; Rec.Direct)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;
                    Visible = false;

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
                                    Rec."Student No." := Appointment."Student No.";
                                    Rec."Employee No." := Appointment."Employee No.";
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
                    Editable = false;

                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                // field("Doctor Name"; DoctorName)
                // {
                //     Editable = false;
                //     ApplicationArea = All;
                // }
                field("Patient No.";
                Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Caption = 'Student No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Observation remarks"; Rec."Observation remarks")
                {
                    ApplicationArea = All;
                }
                field("Treatment Remarks"; rec."Treatment Remarks")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lab Status"; Rec."Lab Status")
                {
                    // Editable = false;
                    ApplicationArea = All;
                }



                field("Patient Name"; rec."Patient Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(AllergicTo2; rec.AllergicTo)
                {
                    Editable = false;
                    ApplicationArea = All;

                }


                field("sent to lab"; rec."sent to lab")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            // group(Processes)
            // {
            //     Caption = 'Processes';
            //     part(Part11; "HMS-Treatment Form Processes")
            //     {
            //         SubPageLink = "Treatment No." = FIELD("Treatment No.");
            //         ApplicationArea = All;
            //     }
            // }
            /*  group(Symptoms)
             {
                 Caption = 'Signs and Symptoms';
                 part(Part1; "HMS Observation Symptoms")
                 {
                     SubPageLink = "Treatment No." = FIELD("Treatment No.");
                     ApplicationArea = All;
                 }
             } */
            // group(Signs)
            // {
            //     Caption = 'Signs';
            //     part(Part2; "HMS Observation Signs")
            //     {
            //         SubPageLink = "Treatment No." = FIELD("Treatment No.");
            //         ApplicationArea = All;
            //     }
            // }
            /*  group(Premedication)
             {
                 part(PreDrugs; "Premedication Drugs")
                 {
                     ApplicationArea = All;
                     SubPageLink = "Treatment No." = field("Treatment No.");
                 }
             } */
            // group(History)
            // {
            //     Caption = 'History';
            //     part(Part3; "HMS Treatment History")
            //     {
            //         SubPageLink = "Treatment No." = FIELD("Treatment No.");
            //         ApplicationArea = All;
            //     }
            // }

            /*  group(Laboratory)
             {

                 Caption = 'Laboratory';
                 part(Part4; "HMS-Treatment Form Laboratory")
                 {
                     SubPageLink = "Treatment No." = FIELD("Treatment No."), "Patient No." = field("Patient No.");
                     ApplicationArea = All;
                 }
             } */
            /*  */


        }
    }

    actions
    {
        area(processing)
        {
            action("Send to lab")
            {
                Caption = 'Send To Lab';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    if Confirm('Send to Laboratory', False) = false then begin exit end;
                    rec.TestField("Patient No.");
                    rec."Lab Status" := rec."Lab Status"::Pending;
                    rec."sent to lab" := true;

                    Message('Patient sent to Laboratory');
                end;
            }
            action("&Mark as Completed")
            {
                Caption = '&Mark as Completed';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Visible = true;

                trigger OnAction()
                begin
                    /*Ask for confirmation*/
                    IF CONFIRM('Mark the Treatment as Completed?', true) = FALSE THEN ERROR('Cancelled');
                    Rec.TESTFIELD("Treatment Date");
                    Rec.Status := Rec.Status::Completed;
                    Rec.MODIFY;
                    MESSAGE('Treatment Marked as Completed');

                end;
            }
            action("Referral Progress")
            {
                Caption = 'Referral Letter';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    treat: Record "HMS-Treatment Form Header";
                    refer: Record "HMS-Treatment Referral";
                begin
                    treat.Reset();
                    treat.SetRange("Treatment No.", Rec."Treatment No.");
                    if treat.Find('-') then begin
                        Report.Run(Report::"Clinic Referal Report", true, false, treat);
                    end;


                end;
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
                Visible = false;
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
                RunObject = Page "Labaratory Results";
                ApplicationArea = All;

                trigger OnAction()
                begin


                end;
            }
            // action("Laboratory Results")
            // {
            //     Caption = 'Laboratory Results';
            //     Image = AdjustEntries;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "HMS-Labaratory Test Line";
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     begin

            //         Labrecords.RESET;
            //         Labrecords.SETRANGE(Labrecords."Patient No.", Rec."Patient No.");
            //         Labrecords.SETRANGE(Labrecords.Status, Labrecords.Status::Completed);
            //         IF Labrecords.FIND('-') THEN BEGIN
            //             LabResults.SETTABLEVIEW(Labrecords);
            //             LabResults.RUN;
            //         END;
            //     end;
            // }
            action("Send to Pharmacy")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = process;

                trigger OnAction()
                begin
                    IF Confirm('Send to the Pharmacist ? ', true) = False Then ERROR('Cancelled buy user');
                    Rec.CreatePharmRequest();
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
            action(History2)
            {
                Caption = 'History';
                RunObject = Page "HMS-Treatment History List";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ApplicationArea = All;
            }

        }
    }

    trigger OnOpenPage()
    begin
        UpdateUserIdOnOpenPage();
    end;

    var
    procedure UpdateUserIdOnOpenPage()
    begin
        rec."Doctor ID" := UserId;
    end;

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
        Rec."Treatment Type" := Rec."Treatment Type"::Outpatient;
        Rec."Doctor ID" := USERID;
    end;

    var
        HBLAB: RECORD "HMS-Laboratory Form Header";
        User: Record "User";

        SupervisorName: Text[100];
        LabLine: Record "HMS-Laboratory Test Line";
        blnCompleted: Boolean;
        blnsenttolab: Boolean;
        Age: Text[100];
        HRDates: Codeunit "HR Dates";

        LabHeader: Record "HMS-Laboratory Form Header";

        TreatmentHeader: Record "HMS-Treatment Form Header";
        TreatmentLine: Record "HMS-Treatment Form Laboratory";
        Tests: Record "HMS-Setup Lab Package Test";
        SpecimenList: Record "HMS-Setup Test Specimen";
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        NewNo: Code[20];
        DocLabRequestLines: Record "HMS-Treatment Form Laboratory";
        LabTestLines: Record "HMS-Laboratory Test Line";
        Labsetup: Record "HMS-Setup Lab Test";
        LabSpecimenSetup: Record "HMS-Setup Test Specimen";
        labheader2: Record "HMS-Laboratory Form Header";
        PatientName: Text[100];
        DoctorName: Text[30];
        Patient: Record "HMS-Patient";
        Doctor: Record "HMIS-Visits/Registrations";
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
        // IF Doctor.GET(DoctorID) THEN BEGIN
        //Doctor.CALCFIELDS(Doctor."Doctor's Name");
        DoctorName := Doctor."Doctor's Name";
        //END;
    end;


    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient."Full Name";// Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetDoctorName(Rec."Doctor ID", DoctorName);
    end;
}

