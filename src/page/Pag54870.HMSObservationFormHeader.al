page 54870 "HMS-Observation Form Header"
{
    PageType = Document;
    SourceTable = "HMS-Observation Form Header";
    SourceTableView = WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Observation No."; Rec."Observation No.")
                {
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
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = true;
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
            }
            group("DetailedObservation")
            {
                Caption = 'Detailed Observation';
                field("Detailed Observation"; Rec."Detailed Observation")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group("Process/Vitals Signs Results")
            {
                Caption = 'Process/Vitals Signs Results';
                part(Part; "HMS-Observation Form Proc")
                {
                    SubPageLink = "Observation No." = FIELD("Observation No.");
                    ApplicationArea = All;
                }
            }
            group(Injections)
            {
                Caption = 'Injections';
                part(Part2; "HMS-Observation Form Injection")
                {
                    SubPageLink = "Observation No." = FIELD("Observation No.");
                    ApplicationArea = All;
                }
            }
            group(Dressings)
            {
                Caption = 'Dressings';
                part(Part3; "HMS-Observation Form Dressing")
                {
                    SubPageLink = "Observation No." = FIELD("Observation No.");
                    ApplicationArea = All;
                }
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
                action("&Release Observation")
                {
                    Caption = '&Release Observation';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Allow the user to release the document*/
                        Rec.Closed := TRUE;
                        Rec.Status := Rec.Status::Pending;
                        Rec.MODIFY;
                        MESSAGE('Observation Record Released');

                    end;
                }
                action("&Reopen Observation")
                {
                    Caption = '&Reopen Observation';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*Allow the user to reopen the record*/
                        IF (Rec.Closed = TRUE) THEN BEGIN
                            Rec.Closed := FALSE;
                            Rec.MODIFY;
                            MESSAGE('Observation Record Reopened');
                        END;

                    end;
                }
                separator(sep)
                {
                }
                action("Mark as Completed")
                {
                    Caption = 'Mark as Completed';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Mark the Observation as Completed?', FALSE) = FALSE THEN BEGIN EXIT END;
                        Rec.Completed := TRUE;
                        Rec.Status := Rec.Status::Closed;
                        Rec.Closed := TRUE;
                        Rec.MODIFY;
                        MESSAGE('The Observation record has been marked as completed');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /// OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // OnAfterGetCurrRecord;
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
        /*
        User.RESET;
        IF User.GET("Observation User ID") THEN
          BEGIN
          //  ObservationUserIDName:=User."User Name";
          END;
         */

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        //VALIDATE("Patient No.");
        GetPatientName(Rec."Patient No.", PatientName);
        GetUserName;
    end;
}

