page 54879 "HMS-Observations List"
{
    Caption = 'Observation';
    CardPageID = "HMS-Observations Header";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "HMS-Observation Form Header";
    SourceTableView = WHERE(Closed = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Observation No."; Rec."Observation No.")
                {
                    ApplicationArea = All;
                }
                field("Observation Type"; Rec."Observation Type")
                {
                    ApplicationArea = All;
                }
                field("Observation Date"; Rec."Observation Date")
                {
                    ApplicationArea = All;
                }
                field("Observation Time"; Rec."Observation Time")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                }
                field("Observation User ID"; Rec."Observation User ID")
                {
                    ApplicationArea = All;
                }
                field("Observation Remarks"; Rec."Observation Remarks")
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

            action("Observation Details")
            {
                ApplicationArea = All;
                Caption = 'Observation Details';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS-Observation Form Header";
                RunPageLink = "Patient No." = FIELD("Patient No.");
            }

            action(sendToDoctorList)
            {
                Caption = 'Doctor''s list';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Dispatch selected Patient to the Doctor''s List?', FALSE) = FALSE THEN BEGIN EXIT END;
                    /*Create an Doctor*/
                    if Rec."Sent to Treatment" = false then begin
                        HMSSetup.RESET;
                        HMSSetup.GET();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Doctor Room", 0D, TRUE);
                        Doctor.INIT;
                        Doctor."Treatment No." := NewNo;
                        Doctor."Treatment Type" := Doctor."Treatment Type"::Outpatient;
                        Doctor."Treatment Date" := TODAY;
                        Doctor."Treatment Time" := TIME;
                        Doctor."Patient No." := Rec."Patient No.";
                        Doctor."Employee No." := Rec."Employee No.";
                        Doctor.Status := Doctor.Status::New;
                        Doctor."Link No." := Rec."Patient No.";
                        Doctor."Link Type" := 'Appointment';
                        Doctor."Observation No." := Rec."Observation No.";
                        Doctor."Student No." := Rec."Student No.";
                        Doctor."Patient Name" := Rec."Patient Name";
                        Doctor."Treatment Date" := today();
                        Doctor."Treatment Time" := System.Time();
                        Doctor."Observation No." := Rec."Observation No.";
                        Doctor."Treatment Remarks" := Rec."Observation Remarks";
                        Doctor.AllergicTo := rec.AllergicTo;
                        Doctor.INSERT;
                        // "Patient Current Location":="Patient Current Location"::"Doctor List";
                        // "Doctor Visit Status":="Doctor Visit Status"::Doctor;
                        //"Observation Status":="Observation Status"::Cleared;
                        Rec."Sent to Treatment" := true;
                        Rec.MODIFY;
                        MESSAGE('Selected Patient has been dispatched to the Doctor''s List!.')
                    end ELSE
                        ERROR('This Is alreadly Sent');


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

