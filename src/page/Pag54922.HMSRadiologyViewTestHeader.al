page 54922 "HMS-Radiology View Test Header"
{
    PageType = Document;
    SourceTable = "HMS-Radiology Form Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Radiology No."; Rec."Radiology No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology Area"; Rec."Radiology Area")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology Date"; Rec."Radiology Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Radiology Time"; Rec."Radiology Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
                    end;
                }
                field(Status; Rec.Status)
                {
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
                field(SupervisorName; SupervisorName)
                {
                    Caption = 'Supervisor Name';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(Part; "HMS-Radiology View Test Line")
            {
                SubPageLink = "Radiology no." = FIELD("Radiology No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }



    var
        PatientName: Text[100];
        SupervisorName: Text[100];
        Patient: Record "HMS-Patient";
        Supervisor: Record "User";


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
        Supervisor.RESET;
        SupervisorName := '';
        IF Supervisor.GET("User ID") THEN BEGIN
            SupervisorName := Supervisor."User Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
    end;
}

