page 54811 "HMS-Admission Form Header List"
{
    CardPageID = "HMS Admission Form Header";
    PageType = List;
    SourceTable = "HMS-Admission Form Header";
    SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Admission Area"; Rec."Admission Area")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Ward; Rec.Ward)
                {
                    ApplicationArea = All;
                }
                field(Bed; Rec.Bed)
                {
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
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
        }
    }

    actions
    {
        area(processing)
        {
            action("&Admit Patient")
            {
                Caption = '&Admit Patient';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Admit Patient?', TRUE) = FALSE THEN BEGIN EXIT END;
                    Rec.Status := Rec.Status::Admitted;
                    Rec.MODIFY;
                    MESSAGE('Patient Admitted');
                end;
            }
            action("&Cancel Admission")
            {
                Caption = '&Cancel Admission';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Cancel the Admission Request?', FALSE) = FALSE THEN BEGIN EXIT END;
                    //Status:=Status::Cancelled;
                    Rec.MODIFY;
                    MESSAGE('Admission Request Cancelled');
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

