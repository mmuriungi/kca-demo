page 51741 "HMS-Observations Header"
{
    Caption = 'Appointments Card';
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    SourceTable = "HMS-Observation Form Header";

    layout
    {
        area(content)
        {
            group(General)
            {
            }
            group(Group)
            {
                field("Observation No."; Rec."Observation No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Observation Type"; Rec."Observation Type")
                {
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Rec."Observation Type" = Rec."Observation Type"::Appointment THEN BEGIN
                            //    GetAppointmentDetails();
                        END
                    end;
                }
                field("Observation Date"; Rec."Observation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Observation Time"; Rec."Observation Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Observation User ID"; Rec."Observation User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Observation Remarks"; Rec."Observation Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Closed; Rec.Closed)
                {
                    Caption = 'Released';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
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
                field("Patient Name"; Rec."Patient Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(AllergicTo; rec.AllergicTo)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group("Medical details")
            {
                Editable = true;
                field("Examining Officer"; Rec."Examining Officer")
                {
                    ApplicationArea = All;
                }

                field(Height; Rec.Height)
                {
                    ApplicationArea = All;
                    Caption = 'Height (cm)';
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = All;
                    Caption = 'Weight (Kg)';
                }
                field(BMI; Rec.BMI)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rhesus Factor"; Rec."Rhesus Factor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Blood Pressure"; Rec."Blood Pressure")
                {
                    ApplicationArea = All;
                }
                field("Heart Rate"; Rec."Heart Rate")
                {
                    ApplicationArea = All;

                }
                field("Body Temp."; Rec."Body Temp.")
                {
                    ApplicationArea = All;

                }
                field("Physical Impairment Details"; Rec."Physical Impairment Details")
                {
                    ApplicationArea = All;
                }
                field("Medical Details Not Covered"; Rec."Medical Details Not Covered")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {

            // action("Observation Details")
            // {
            //     Caption = 'Observation Details';
            //     Image = Allocations;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     RunObject = Page "HMS-Observation Form Header";
            //     RunPageLink = "Patient No." = FIELD("Patient No.");
            //     ApplicationArea = All;
            // }

            action(sendToDoctorList)
            {
                Caption = 'Doctor''s list';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var

                begin
                    IF CONFIRM('Dispatch selected Patient to the Doctor''s List?', FALSE) = FALSE THEN BEGIN EXIT END;
                    /*Create an Doctor*/
                    if Rec."Sent to Treatment" = false then begin
                        HMSSetup.RESET;
                        HMSSetup.GET();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, TRUE);
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
                        Doctor."Observation remarks" := Rec."Observation Remarks";
                        Doctor.AllergicTo := rec.AllergicTo;
                        Doctor.Location := Doctor.Location::Queue;

                        Doctor.INSERT;
                        //"Patient Current Location":="Patient Current Location"::"Doctor List";
                        // "Doctor Visit Status":="Doctor Visit Status"::Doctor;
                        //"Observation Status":="Observation Status"::Cleared;
                        Rec."Sent to Treatment" := true;
                        rec.Closed := true;
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

