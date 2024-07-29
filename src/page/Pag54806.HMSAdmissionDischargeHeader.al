page 54806 "HMS Admission Discharge Header"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "HMS-Admission Discharge Header";
    SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Discharge Date"; Rec."Discharge Date")
                {
                    Caption = 'Discharge Date/Time';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Discharge Time"; Rec."Discharge Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date of Admission"; Rec."Date of Admission")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Of Admission"; Rec."Time Of Admission")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ward No."; Rec."Ward No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bed No."; Rec."Bed No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Doctor.RESET;
                        IF Doctor.GET(Rec."Doctor ID") THEN BEGIN
                            Doctor.CALCFIELDS(Doctor."Doctor's Name");
                            DoctorName := Doctor."Doctor's Name";
                        END;
                    end;
                }
                field(DoctorName; DoctorName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Nurse ID"; Rec."Nurse ID")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        User.RESET;
                        IF User.GET(Rec."Nurse ID") THEN BEGIN
                            //  NurseName:=User.Name;
                        END;
                    end;
                }
                field(NurseName; NurseName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            part(Page; "HMS Admission Discharge Line")
            {
                SubPageLink = "Admission No." = FIELD("Admission No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Discharge")
            {
                Caption = '&Discharge';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Discharge Patient?', FALSE) = FALSE THEN BEGIN EXIT END;
                    Lines.RESET;
                    Lines.SETRANGE(Lines."Admission No.", Rec."Admission No.");
                    IF Lines.FIND('-') THEN BEGIN
                                                REPEAT
                                                    Lines.CALCFIELDS(Lines.Mandatory);
                                                    blnMand := Lines.Mandatory;
                                                    IF blnMand <> Lines.Done THEN BEGIN
                                                        MESSAGE('Please ensure that the Mandatory processes are finished first');
                                                    END;
                                                UNTIL Lines.NEXT = 0;
                    END;

                    Admission.RESET;
                    IF Admission.GET(Rec."Admission No.") THEN BEGIN
                        Admission.Status := Admission.Status::Discharged;
                        Admission.MODIFY;
                        Rec."Discharge Date" := TODAY;
                        Rec."Discharge Time" := TIME;
                        Rec.Status := Rec.Status::Completed;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }



    var
        PatientName: Text[200];
        DoctorName: Text[200];
        NurseName: Text[200];
        Doctor: Record "HMS-Setup Doctor";
        User: Record "User";
        Patient: Record "HMS-Patient";
        Lines: Record "HMS-Admission Discharge Line";
        blnMand: Boolean;
        Admission: Record "HMS-Admission Form Header";

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        Doctor.RESET;
        DoctorName := '';
        IF Doctor.GET(Rec."Doctor ID") THEN BEGIN
            Doctor.CALCFIELDS(Doctor."Doctor's Name");
            DoctorName := Doctor."Doctor's Name";
        END;
        User.RESET;
        NurseName := '';
        IF User.GET(Rec."Nurse ID") THEN BEGIN
            // NurseName:=User.Name;
        END;
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(Rec."Patient No.") THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;
}

