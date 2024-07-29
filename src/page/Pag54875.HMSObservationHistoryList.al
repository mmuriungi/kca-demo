page 54875 "HMS-Observation History List"
{
    CardPageID = "HMS Observation Form Header Cl";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS-Observation Form Header";
    SourceTableView = WHERE(Closed = CONST(true));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Observation No."; Rec."Observation No.")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Observation Type"; Rec."Observation Type")
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Observation Type" = Rec."Observation Type"::Appointment THEN BEGIN
                            GetAppointmentDetails();
                        END
                    end;
                }
                field("Observation Date"; Rec."Observation Date")
                {
                    ApplicationArea = All;
                }
                field("Observation Time"; Rec."Observation Time")
                {
                    ApplicationArea = All;
                }
                field("Observation User ID"; Rec."Observation User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ObservationUserIDName; ObservationUserIDName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Observation Remarks"; Rec."Observation Remarks")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    Caption = 'Released';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Patient Name';
                    Editable = false;
                    ApplicationArea = All;
                }
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    var
        PatientName: Text[100];
        ObservationUserIDName: Text[30];
        Appointment: Record "HMS-Appointment Form Header";
        Patient: Record "HMS-Patient";
        User: Record "User";


    procedure GetAppointmentDetails()
    begin
        /*Get the appointment details from the database*/
        Appointment.RESET;
        IF Appointment.GET(Rec."Link No.") THEN BEGIN
            Rec."Patient No." := Appointment."Patient No.";
            Rec."Student No." := Appointment."Student No.";
            Rec."Employee No." := Appointment."Employee No.";
            Rec."Relative No." := Appointment."Relative No.";
            Rec."Link Type" := 'Appointment';
            GetPatientName(Rec."Patient No.", PatientName);
        END;

    end;


    procedure GetVisitDetails()
    begin
    end;


    procedure GetAdmissionDetails()
    begin
    end;


    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;


    procedure GetUserName()
    begin
        User.RESET;
        IF User.GET(Rec."Observation User ID") THEN BEGIN
            ObservationUserIDName := User."User Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        //VALIDATE("Patient No.");
        GetPatientName(Rec."Patient No.", PatientName);
        GetUserName;
    end;
}

