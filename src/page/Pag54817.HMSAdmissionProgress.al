page 54817 "HMS Admission Progress"
{
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "HMS-Admission Form Header";
    SourceTableView = WHERE(Status = CONST(Admitted));

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
                field("Admission Date"; Rec."Admission Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admission Area"; Rec."Admission Area")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Ward; Rec.Ward)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Bed; Rec.Bed)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
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
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Employee No./Relative No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admission Reason"; Rec."Admission Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Daily Processes/Procedures")
            {
                Caption = 'Daily Processes/Procedures';
                part(Page; "HMS Admission Form Process")
                {
                    SubPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
            }
            group("Nurse Notes")
            {
                Caption = 'Nurse Notes';
                part(Page2; "HMS Admission Nurse Notes")
                {
                    SubPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
            }
            group("Injections Administered")
            {
                Caption = 'Injections Administered';
                part(Page3; "HMS Admission Injection")
                {
                    SubPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
            }
            group(Prescription)
            {
                Caption = 'Prescription';
                part(Prescrp; "HMS Admission Form Drug")
                {
                    SubPageLink = "Admission No." = FIELD("Admission No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Initiate Discharge")
            {
                Caption = '&Initiate Discharge';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you wish to initiate Patient discharge?', FALSE) = FALSE THEN BEGIN EXIT END;


                    DischargeHeader.RESET;
                    DischargeHeader.SETRANGE(DischargeHeader."Admission No.", Rec."Admission No.");
                    IF DischargeHeader.FIND('-') THEN BEGIN DischargeHeader.DELETEALL END;
                    DischargeHeader.RESET;
                    DischargeHeader.INIT;
                    DischargeHeader."Admission No." := Rec."Admission No.";
                    DischargeHeader."Patient No." := Rec."Patient No.";
                    DischargeHeader."Ward No." := Rec.Ward;
                    DischargeHeader."Bed No." := Rec.Bed;
                    DischargeHeader."Date of Admission" := Rec."Admission Date";
                    DischargeHeader."Time Of Admission" := Rec."Admission Time";
                    DischargeHeader.INSERT();

                    DischargeLine.RESET;
                    DischargeLine.SETRANGE(DischargeLine."Admission No.", Rec."Admission No.");
                    IF DischargeLine.FIND('-') THEN BEGIN DischargeLine.DELETEALL END;
                    DischargeProcesses.RESET;
                    IF DischargeProcesses.FIND('-') THEN BEGIN
                                                             REPEAT
                                                                 DischargeLine.INIT;
                                                                 DischargeLine."Admission No." := Rec."Admission No.";
                                                                 DischargeLine."Process Code" := DischargeProcesses.Code;
                                                                 DischargeLine.VALIDATE(DischargeLine."Process Code");
                                                                 DischargeLine.INSERT();
                                                             UNTIL DischargeProcesses.NEXT = 0;
                    END;

                    Rec.Status := Rec.Status::"Discharge Pending";
                    Rec.MODIFY;
                    MESSAGE('Patient Admission Discharge Process Initiated');
                end;
            }
        }
    }



    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    var
        PatientName: Text[100];
        Patient: Record "HMS-Patient";
        DischargeHeader: Record "HMS-Admission Discharge Header";
        DischargeLine: Record "HMS-Admission Discharge Line";
        DischargeProcesses: Record "HMS-Setup Discharge Processes";

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
    end;
}

