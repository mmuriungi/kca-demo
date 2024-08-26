page 51686 "HMS-Appointment Form Header"
{
    PageType = Card;
    SourceTable = "HMS-Appointment Form Header";
    //SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            group(group)
            {
                field("Appointment No."; Rec."Appointment No.")
                {
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ApplicationArea = All;
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    ApplicationArea = All;
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
                    end;
                }
                field(AppointmentTypeName; AppointmentTypeName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                // field("Patient Type"; Rec."Patient Type")
                // {
                //     ApplicationArea = All;

                //     // trigger OnValidate()
                //     // begin
                //     //     CheckPatientType();
                //     // end;
                // }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;

                    //TableRelation = "HMS-Patient";
                    // trigger OnValidate()
                    // begin
                    //     GetPatientName(Rec."Patient No.", PatientName);
                    //     GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                    //     GetAppointmentStats(Rec."Patient No.");
                    // end;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Employee/Student No.';
                    Enabled = "Employee No.Enable";
                    Visible = "Employee No.Visible";
                    ApplicationArea = All;
                }
                // field("Relative No."; Rec."Relative No.")
                // {
                //     Enabled = "Relative No.Enable";
                //     Visible = "Relative No.Visible";
                //     ApplicationArea = All;
                // }
                // field("Student No."; Rec."Student No.")
                // {
                //     Enabled = "Student No.Enable";
                //     ApplicationArea = All;
                // }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Patient email"; rec."Patient email")
                {
                    Caption = 'Patient email';
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                // field(PatientName; PatientName)
                // {
                //     Caption = 'Patient';
                //     Editable = false;
                //     ApplicationArea = All;
                // }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetDoctorName(Rec.Doctor, DoctorName);
                    end;
                }
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Purpose For Appointment ';
                    ApplicationArea = All;
                }
                field("Preparation Instruction"; rec."Preparation Instruction")
                {
                    Caption = 'Preparation Instruction ';
                    ApplicationArea = All;
                }
                field("Cancelation Request"; rec."Cancelation Request")
                {
                    Caption = 'Cancelation Request ';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                group("Appointment Statistics")
                {
                    Caption = 'Appointment Statistics';
                    field(IntScheduled; IntScheduled)
                    {
                        Caption = 'No. of appointments scheduled';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(IntCompleted; IntCompleted)
                    {
                        Caption = 'No. of appointments completed';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(IntRescheduled; IntRescheduled)
                    {
                        Caption = 'No. of appointments rescheduled';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(IntCancelled; IntCancelled)
                    {
                        Caption = 'No. of appointments cancelled';
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
            }
            part(Part; "HMS-Appointment Form Line")
            {
                SubPageLink = "Patient No." = FIELD("Patient No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Dispatch To Observation Room")
                {
                    Caption = 'Dispatch To Observation Room';
                    Image = ReleaseDoc;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin



                        IF CONFIRM('Dispatch selected Appoiintment to Observation?', FALSE) = FALSE THEN BEGIN EXIT END;
                        BEGIN
                            //TESTFIELD("Settlement Type");
                            HMSSetup.RESET;
                            HMSSetup.GET();
                            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, TRUE);
                            TreatmentHeader.RESET;
                            TreatmentHeader.GET(Rec."Appointment No.");
                            LabHeader.RESET;
                            LabHeader.INIT;
                            ObservHeader."Observation No." := NewNo;
                            ObservHeader."Observation Date" := TODAY;
                            ObservHeader."Observation Time" := TIME;
                            ObservHeader."Patient No." := TreatmentHeader."Patient No.";
                            ObservHeader."Student No." := TreatmentHeader."Student No.";
                            ObservHeader."Employee No." := TreatmentHeader."Employee No.";
                            ObservHeader."Relative No." := TreatmentHeader."Relative No.";
                            //:=LabHeader."Request Area"::Doctor;
                            ObservHeader."Link Type" := 'Observation';
                            ObservHeader."Link No." := TreatmentHeader."Appointment No.";
                            ObservHeader.INSERT;



                            Rec."Dispatch To" := Rec."Dispatch To"::Observation;
                            Rec."Dispatch Date" := TODAY;
                            Rec."Dispatch Time" := TIME;
                            Rec.Status := Rec.Status::Dispatched;
                            Rec.MODIFY;
                            MESSAGE('Selected Appointment has been dispatched to the Observation Room.')
                        END;
                    end;
                }
                action("Dispatch To Doctor")
                {
                    Caption = 'Dispatch To Doctor';
                    Image = ReleaseDoc;
                    ApplicationArea = All;
                    Visible = (Rec.Status = Rec.Status::New);

                    trigger OnAction()
                    begin
                        IF CONFIRM('Dispatch selected Appointment to Doctor?', FALSE) = FALSE THEN BEGIN
                            EXIT
                        END;
                        Rec.TESTFIELD("Appointment Date");
                        Rec.TESTFIELD("Appointment Time");
                        Rec.TESTFIELD("Patient Type");
                        Rec.TESTFIELD(Doctor);
                        Rec.TESTFIELD("Patient No.");


                        IF CONFIRM('Dispatch selected Appointment to Doctor?') THEN BEGIN
                            HMSSetup.RESET;
                            HMSSetup.GET();
                            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, TRUE);
                            docHeader.INIT;
                            docHeader."Treatment No." := NewNo;
                            docHeader."Treatment Date" := TODAY;
                            docHeader."Treatment Time" := TIME;
                            docHeader."Doctor ID" := Rec.Doctor;
                            docHeader."Patient No." := Rec."Patient No.";
                            docHeader."Student No." := Rec."Student No.";
                            docHeader."Employee No." := Rec."Employee No.";
                            docHeader."Relative No." := Rec."Relative No.";
                            docHeader.Direct := TRUE;
                            //:=LabHeader."Request Area"::Doctor;
                            docHeader."Link Type" := 'Outpatient';
                            //      docHeader."Link No.":=TreatmentHeader."Appointment No.";
                            docHeader.INSERT;

                            Rec."Dispatch To" := Rec."Dispatch To"::Doctor;
                            Rec."Dispatch Date" := TODAY;
                            Rec."Dispatch Time" := TIME;
                            Rec."User ID" := USERID;
                            Rec.Status := Rec.Status::Dispatched;
                            Rec.MODIFY;
                            MESSAGE('Selected Appointment has been dispatched to the Doctor.')
                        END;
                    end;
                }

                action("Notify the HOD")
                {
                    ApplicationArea = Suite;
                    Caption = ' Book And Notify ';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Notify the Applicant';
                    Visible = (Rec.Status = Rec.Status::New);
                    trigger OnAction()
                    var
                        EmailMessage: Codeunit "Email Message";
                        Email: Codeunit Email;
                        Recipients: List of [Text];
                        Subject: Text;
                        Body: Text;
                    begin
                        Recipients.Add(rec."Patient email");
                        Subject := StrSubstNo('Embu university Hospital Appointment  %1..%2');
                        Body := StrSubstNo('Your appointment has been scheduled for %1 at %2 . Kindly avail yourself on time.',

                        Format(rec."Appointment Date"),
                        Format(rec."Appointment Time"));
                        EmailMessage.Create(Recipients, Subject, Body, true);
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        rec.Status := rec.Status::Booked;
                        Message('booked successfully');
                    end;
                }
                action("Close the Appointment ")
                {
                    ApplicationArea = Suite;
                    Caption = ' Close the Appointment ';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    Visible = (Rec.Status = Rec.Status::Booked);
                    trigger OnAction()
                    var
                    begin
                        rec.Status := rec.Status::Completed
                    end;

                }

                separator(sep)
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var

    begin
        DispatchToDoctorVisible := (Rec.Status = Rec.Status::New);
    end;

    trigger OnInit()
    begin
        "Relative No.Enable" := TRUE;
        "Employee No.Enable" := TRUE;
        "Student No.Enable" := TRUE;
        "Relative No.Visible" := TRUE;
        "Employee No.Visible" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // OnAfterGetCurrRecord;
    end;
    // Your existing triggers and procedures...
    // (omitted for brevity)

    var
        EmailSent: Boolean;
        SenderEmail: Text[250];

    procedure SendEmailNotification(SenderEmail: Text[250]; PatientEmail: Text[250]; AppointmentDate: Date; AppointmentTime: Time; Remarks: Text[250]): Boolean;
    begin
        // Replace with your actual email sending logic
        // This is a placeholder for demonstration purposes
        MESSAGE('Sending email from %1 to %2 about the appointment on %3 at %4 with remarks: %5', SenderEmail, PatientEmail, AppointmentDate, AppointmentTime, Remarks);
        EXIT(TRUE);
    end;

    var
        AppointmentTypeName: Text[100];
        PatientName: Text[100];
        DoctorName: Text[100];
        IntScheduled: Integer;
        IntCompleted: Integer;
        IntRescheduled: Integer;
        IntCancelled: Integer;
        LastDate: Date;
        LastTime: Time;
        DispatchToDoctorVisible: Boolean;
        LastAppointmentType: Code[20];
        LastAppointmentDoctor: Code[20];
        Age: Text[250];
        [InDataSet]
        "Employee No.Visible": Boolean;
        [InDataSet]
        "Relative No.Visible": Boolean;
        [InDataSet]
        "Student No.Enable": Boolean;
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        HMSSetup: Record "HMS-Setup";
        ObservHeader: Record "HMS-Observation Form Header";
        LabHeader: Record "HMS-Laboratory Form Header";
        NewNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        TreatmentHeader: Record "HMS-Appointment Form Header";
        docHeader: Record "HMS-Treatment Form Header";


    procedure CheckPatientType()
    begin
        IF Rec."Patient Type" = Rec."Patient Type"::Student THEN BEGIN
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
            "Employee No.Visible" := FALSE;
            "Relative No.Visible" := FALSE;
        END
        ELSE BEGIN
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
            "Employee No.Visible" := TRUE;
            "Relative No.Visible" := TRUE;

        END;
    end;


    procedure GetAppointmentTypeName(var AppointmentTypeName: Text[100]; var AppointmentTypeCode: Code[20])
    var
        AppType: Record "HMS-Setup Appointment Type";
    begin
        AppType.RESET;
        IF AppType.GET(AppointmentTypeCode) THEN BEGIN AppointmentTypeName := AppType.Description END;
    end;


    procedure GetPatientNo(var PatientNo: Code[20]; var StudentNo: Code[20]; var EmployeeNo: Code[20]; var RelativeNo: Integer)
    var
        Patient: Record "HMS-Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            StudentNo := Patient."Student No.";
            EmployeeNo := Patient."Employee No.";
            RelativeNo := Patient."Relative No.";
        END;
    end;


    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    var
        Patient: Record "HMS-Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + Patient."Last Name";
        END;
    end;


    procedure GetPatientAge(var PatientNo: Code[20]; var Age: Text[100])
    var
        HRDates: Codeunit "HR Dates";
        Patient: Record "HMS-Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            //  IF Patient."Date Of Birth"=0D THEN
            //    BEGIN
            //      Age:='';
            //    END
            //  ELSE
            //BEGIN
            Age := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
            //MESSAGE('%1',Age);
            // END;
        END;
    end;


    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS-Setup Doctor";
    begin
        Doctor.RESET;
        IF Doctor.GET(DoctorCode) THEN BEGIN
            // Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctor's Name";
        END;
    end;


    procedure GetAppointmentStats(var PatientNo: Code[20])
    var
        Patient: Record "HMS-Patient";
    begin
        Patient.RESET;
        IF Patient.GET(PatientNo) THEN BEGIN
            Patient.CALCFIELDS(Patient."Appointments Scheduled", Patient."Appointments Completed", Patient."Appointments Rescheduled");
            IntScheduled := Patient."Appointments Scheduled";
            IntCompleted := Patient."Appointments Completed";
            IntRescheduled := Patient."Appointments Rescheduled";
            Patient.CALCFIELDS(Patient."Appointments Cancelled");
            IntCancelled := Patient."Appointments Cancelled";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        GetAppointmentTypeName(AppointmentTypeName, Rec."Appointment Type");
        GetDoctorName(Rec.Doctor, DoctorName);
        GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
        GetPatientName(Rec."Patient No.", PatientName);
        GetPatientAge(Rec."Patient No.", Rec.Age);
        GetAppointmentStats(Rec."Patient No.");
    end;
}

