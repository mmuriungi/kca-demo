page 54820 "HMS-Appointment Form Control"
{
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "HMS-Appointment Form Header";
    SourceTableView = WHERE(Status = FILTER(New | Dispatched));

    layout
    {
        area(content)
        {
            group(group)
            {
                field("Appointment No."; Rec."Appointment No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appointment Type"; Rec."Appointment Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(AppointmentTypeName; AppointmentTypeName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    Enabled = "Employee No.Enable";
                    Visible = "Employee No.Visible";
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    Enabled = "Student No.Enable";
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Patient';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Appointment Time"; Rec."Appointment Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    Enabled = "Relative No.Enable";
                    Visible = "Relative No.Visible";
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
            group("Reschedule details")
            {
                Caption = 'Reschedule details';
                field("ReAppointment Date"; Rec."ReAppointment Date")
                {
                    Editable = "ReAppointment DateEditable";
                    ApplicationArea = All;
                }
                field("ReAppointment Time"; Rec."ReAppointment Time")
                {
                    Editable = "ReAppointment TimeEditable";
                    ApplicationArea = All;
                }
                field("ReAppointment Type Code"; Rec."ReAppointment Type Code")
                {
                    Editable = ReAppointmentTypeCodeEditable;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetAppointmentTypeName(ReAppointmentTypeName, Rec."ReAppointment Type Code");
                    end;
                }
                field(ReAppointmentTypeName; ReAppointmentTypeName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ReAppointment Doctor ID"; Rec."ReAppointment Doctor ID")
                {
                    Editable = ReAppointmentDoctorIDEditable;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetDoctorName(Rec."ReAppointment Doctor ID", ReAppointmentDoctorName);
                    end;
                }
                field(ReAppointmentDoctorName; ReAppointmentDoctorName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(part; "HMS-Appointment Form Line")
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
                action("Reschedule Appointment")
                {
                    Caption = 'Reschedule Appointment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        "ReAppointment DateEditable" := TRUE;
                        "ReAppointment TimeEditable" := TRUE;
                        ReAppointmentTypeCodeEditable := TRUE;
                        ReAppointmentDoctorIDEditable := TRUE;
                    end;
                }
                action("Cancel Rescheduling")
                {
                    Caption = 'Cancel Rescheduling';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec."ReAppointment Date" := 0D;
                        Rec."ReAppointment Time" := 0T;
                        Rec."ReAppointment Type Code" := '';
                        Rec."ReAppointment Doctor ID" := '';
                        Rec.MODIFY;
                        "ReAppointment DateEditable" := NOT TRUE;
                        "ReAppointment TimeEditable" := NOT TRUE;
                        ReAppointmentTypeCodeEditable := NOT TRUE;
                        ReAppointmentDoctorIDEditable := NOT TRUE;
                    end;
                }
                separator(sep)
                {
                }
                action("Cancel Appointment")
                {
                    Caption = 'Cancel Appointment';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you wish to Cancel the Current Appointment?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.MODIFY;
                        MESSAGE('Appointment Cancelled');
                    end;
                }
            }
            action("&Create Appointment")
            {
                Caption = '&Create Appointment';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Create an appointment*/
                    IF CONFIRM('Reschedule the Appointment?') = FALSE THEN BEGIN EXIT END;
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Appointment Nos", 0D, TRUE);
                    Appointment.INIT;
                    Appointment."Appointment No." := NewNo;
                    Appointment."Appointment Date" := Rec."ReAppointment Date";
                    Appointment."Appointment Time" := Rec."ReAppointment Time";
                    Appointment."Appointment Type" := Rec."Appointment Type";
                    Appointment."Patient Type" := Rec."Patient Type";
                    Appointment."Patient No." := Rec."Patient No.";
                    Appointment."Student No." := Rec."Student No.";
                    Appointment."Employee No." := Rec."Employee No.";
                    Appointment."Relative No." := Rec."Relative No.";
                    Appointment.Doctor := Rec.Doctor;
                    Appointment.Remarks := Rec.Remarks;
                    Appointment.Status := Rec.Status::New;
                    Appointment.INSERT;
                    Rec."ReAppointment No." := NewNo;
                    Rec.Status := Rec.Status::Rescheduled;
                    Rec.MODIFY;
                    MESSAGE('Appointment Rescheduled');

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
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
        LastAppointmentType: Code[20];
        LastAppointmentDoctor: Code[20];
        ReAppointmentTypeName: Text[30];
        ReAppointmentDoctorName: Text[30];
        Age: Text[100];
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Appointment: Record "HMS-Appointment Form Header";
        NewNo: Code[20];
        [InDataSet]
        "ReAppointment DateEditable": Boolean;
        [InDataSet]
        "ReAppointment TimeEditable": Boolean;
        [InDataSet]
        ReAppointmentTypeCodeEditable: Boolean;
        [InDataSet]
        ReAppointmentDoctorIDEditable: Boolean;
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
        IF AppType.GET(AppointmentTypeCode) THEN BEGIN
            AppointmentTypeName := AppType.Description;
        END;
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
            IF Patient."Date Of Birth" = 0D THEN BEGIN
                Age := '';
            END
            ELSE BEGIN
                Age := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
            END;
        END;
    end;


    procedure GetDoctorName(var DoctorCode: Code[20]; var DoctorName: Text[100])
    var
        Doctor: Record "HMS-Setup Doctor";
    begin
        Doctor.RESET;
        IF Doctor.GET(DoctorCode) THEN BEGIN
            //Doctor.CALCFIELDS(Doctor."Doctor's Name");
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
        GetPatientName(Rec."Patient No.", PatientName);
        GetDoctorName(Rec.Doctor, DoctorName);
        GetAppointmentStats(Rec."Patient No.");
    end;
}

