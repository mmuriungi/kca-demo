page 54829 "HMS-Appointments Header"
{
    Caption = 'Appointments Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    SourceTable = "HMS-Patient";
    SourceTableView = WHERE("Patient Current Location" = FILTER(Appointment),
                            "Appointment Status" = FILTER(Appointment));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Patient Ref. No."; Rec."Patient Ref. No.")
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
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
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field("Correspondence Address 1"; Rec."Correspondence Address 1")
                {
                    ApplicationArea = All;
                }
                field("Telephone No. 1"; Rec."Telephone No. 1")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
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
            group(Activities)
            {
                Caption = 'Activities';
                action("Apointments list")
                {
                    Caption = 'Apointments list';
                    Image = Allocations;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS-Appointment Form Line";
                    RunPageLink = "Patient No." = FIELD("Patient No.");
                    ApplicationArea = All;
                }
            }
            group("&Send to..")
            {
                Caption = '&Send to..';
            }
            action(sendToObservation)
            {
                Caption = 'Observation Room';
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Dispatch selected Patient to Observation?', FALSE) = FALSE THEN BEGIN EXIT END;
                    /*Create an observation*/
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, TRUE);
                    Observation.INIT;
                    Observation."Observation No." := NewNo;
                    Observation."Observation Date" := TODAY;
                    Observation."Observation Time" := TIME;
                    //observation."Appointment Type":=observation."Appointment Type"::Registration;
                    // observation."Patient Type":="Patient Type";
                    Observation."Patient No." := Rec."Patient No.";
                    Observation."Link No." := Rec."Patient No.";
                    //observationRemarks:=Remarks;
                    Observation.Status := Observation.Status::New;
                    Observation.INSERT;
                    Rec."Patient Current Location" := Rec."Patient Current Location"::Observation;
                    Rec."Observation Status" := Rec."Observation Status"::Observation;
                    Rec."Appointment Status" := Rec."Appointment Status"::Cleared;
                    Rec.MODIFY;
                    MESSAGE('Selected Patient has been dispatched to the Observation Room.!')

                end;
            }
            action(sendToDoctorList)
            {
                Caption = 'Doctor''s list';
                Image = Register;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Dispatch selected Patient to the Doctor''s List?', FALSE) = FALSE THEN BEGIN EXIT END;

                    /*Create an Doctor*/
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Doctor Room", 0D, TRUE);
                    Doctor.INIT;
                    Doctor."Treatment No." := NewNo;
                    Doctor."Treatment Type" := Doctor."Treatment Type"::Outpatient;
                    Doctor."Treatment Date" := TODAY;
                    Doctor."Treatment Time" := TIME;
                    Doctor."Patient No." := Rec."Patient No.";
                    Doctor.Status := Doctor.Status::New;
                    Doctor."Link No." := Rec."Patient No.";
                    Doctor."Link Type" := 'Appointment';
                    Doctor.INSERT;
                    Rec."Patient Current Location" := Rec."Patient Current Location"::"Doctor List";
                    Rec."Doctor Visit Status" := Rec."Doctor Visit Status"::Doctor;
                    Rec."Appointment Status" := Rec."Appointment Status"::Cleared;

                    Rec.MODIFY;
                    MESSAGE('Selected Patient has been dispatched to the Doctor''s List!.')

                end;
            }
        }
    }

    var
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
        Observation: Record "HMS-Observation Form Header";
        Doctor: Record "HMS-Treatment Form Header";
}

