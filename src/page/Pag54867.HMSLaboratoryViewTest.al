page 54867 "HMS-Laboratory View Test"
{
    PageType = Document;
    SourceTable = "HMS-Laboratory Form Header";

    layout
    {
        area(content)
        {
            group(rep)
            {
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    Caption = 'Laboratory Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    Caption = 'Laboratory Time';
                    Editable = false;
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
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Scheduled Time"; Rec."Scheduled Time")
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
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Laboratory Test Findings")
            {
                Caption = 'Laboratory Test Findings';
                part(Part; "HMS-Labaratory Test Line")
                {
                    Editable = false;
                    SubPageLink = "Laboratory No." = FIELD("Laboratory No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Mark as Completed")
            {
                Caption = '&Mark as Completed';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Mark the Laboratory Test as Completed?', FALSE) = FALSE THEN EXIT;
                    blnCompleted := TRUE;
                    LabLine.RESET;
                    LabLine.SETRANGE(LabLine."Laboratory No.", Rec."Laboratory No.");
                    IF LabLine.FIND('-') THEN BEGIN
                                                  REPEAT
                                                      IF LabLine.Completed = FALSE THEN blnCompleted := FALSE;
                                                  UNTIL LabLine.NEXT = 0;
                    END;

                    IF blnCompleted = FALSE THEN BEGIN
                        ERROR('Please ensure that all the tests are marked as completed');
                    END
                    ELSE BEGIN
                        Rec.Status := Rec.Status::Completed;
                        Rec.MODIFY;
                        MESSAGE('Laboratory Test Marked as Completed');
                    END;
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
        //  OnAfterGetCurrRecord;
    end;

    var
        Patient: Record "HMS-Patient";
        User: Record "User";
        PatientName: Text[100];
        SupervisorName: Text[100];
        LabLine: Record "HMS-Laboratory Test Line";
        blnCompleted: Boolean;


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
            SupervisorName := User."User Name";
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
    end;
}

