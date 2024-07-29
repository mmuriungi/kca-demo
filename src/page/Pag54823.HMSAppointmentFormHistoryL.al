page 54823 "HMS-Appointment Form History L"
{
    Editable = false;
    PageType = List;
    SourceTable = "HMS-Appointment Form Header";
    SourceTableView = WHERE(Status = CONST(Completed));

    layout
    {
        area(content)
        {
            repeater(rep)
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
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CheckPatientType();
                    end;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetPatientName(Rec."Patient No.", PatientName);
                        GetPatientNo(Rec."Patient No.", Rec."Student No.", Rec."Employee No.", Rec."Relative No.");
                        GetAppointmentStats(Rec."Patient No.");
                    end;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Employee/Relative No.';
                    Enabled = "Employee No.Enable";
                    Visible = "Employee No.Visible";
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Enabled = "Relative No.Enable";
                    Visible = "Relative No.Visible";
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
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
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* repeater("Appointment Statistics")
                {
                    Caption = 'Appointment Statistics';
                    field(IntScheduled; IntScheduled)
                    {
                        Caption = 'No. of appointments scheduled';
                        Editable = false;
                    }
                    field(IntCompleted; IntCompleted)
                    {
                        Caption = 'No. of appointments completed';
                        Editable = false;
                    }
                    field(IntRescheduled; IntRescheduled)
                    {
                        Caption = 'No. of appointments rescheduled';
                        Editable = false;
                    }
                    field(IntCancelled; IntCancelled)
                    {
                        Caption = 'No. of appointments cancelled';
                        Editable = false;
                    }
                } */
            }
        }
    }

    actions
    {
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
        Age: Text[100];
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
            Doctor.CALCFIELDS(Doctor."Doctor's Name");
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

