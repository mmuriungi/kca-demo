page 54859 "HMS-Laboratory Form List"
{
    CardPageID = "HMS-Laboratory Form Header";
    PageType = List;
    SourceTable = "HMS-Laboratory Form Header";
    SourceTableView = WHERE(Status = CONST(New));

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    ApplicationArea = All;
                }
                field("Lab. Reference No."; Rec."Lab. Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    Caption = 'Laboratory Date';
                    ApplicationArea = All;
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    Caption = 'Laboratory Time';
                    ApplicationArea = All;
                }
                field("Request Area"; Rec."Request Area")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    Caption = 'Link No.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
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
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    ApplicationArea = All;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
                    end;
                }
                field(SupervisorName; SupervisorName)
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
                field("Employee No.1"; Rec."Employee No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Relative No."; Rec."Relative No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Student No.1"; Rec."Student No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
            action("&Forward for Findings")
            {
                Caption = '&Forward for Findings';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Ask for userconfirmation*/
                    IF CONFIRM('Forward the Laboratory Request?', TRUE) = FALSE THEN BEGIN EXIT END;
                    Rec.Status := Rec.Status::Forwarded;
                    Rec.MODIFY;
                    MESSAGE('Laboratory Test Request Forwarded');

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //OnAfterGetCurrRecord;
    end;

    var
        Patient: Record "HMS-Patient";
        User: Record "User";
        PatientName: Text[100];
        SupervisorName: Text[100];


    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.RESET;
        PatientName := '';
        IF Patient.GET(PatientNo) THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;
    end;


    procedure GetSupervisorName(var "User ID": Code[20]; var SupervisorName: Text[100])
    begin
        User.RESET;
        SupervisorName := '';
        IF User.GET("User ID") THEN BEGIN
            SupervisorName := User."Full Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        //GetSupervisorName("Supervisor ID",SupervisorName);
    end;
}

