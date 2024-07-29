page 54861 "HMS-Laboratory Form Test"
{
    PageType = Document;
    SourceTable = "HMS-Laboratory Form Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Laboratory No."; Rec."Laboratory No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lab. Reference No."; Rec."Lab. Reference No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Laboratory Date"; Rec."Laboratory Date")
                {
                    Caption = 'Laboratory Date';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Laboratory Time"; Rec."Laboratory Time")
                {
                    Caption = 'Laboratory Time';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Request Area"; Rec."Request Area")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Link No."; Rec."Link No.")
                {
                    Caption = 'Link No.';
                    Editable = true;
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
                field("Student No.2"; Rec."Student No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Gender"; Patient.Gender)
                {
                    Caption = 'Gender';
                    Description = 'Gender';
                    Editable = true;
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
                field(PatientName; Rec."Patient Name")
                {
                    Caption = 'Patient Name';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Employee No.1"; Rec."Employee No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Relative No.1"; Rec."Relative No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Employee No.2"; Rec."Employee No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Date of Birth"; Patient."Date Of Birth")
                {
                    Caption = 'Date of Birth';
                    ApplicationArea = All;
                }
                field(Age; Age)
                {
                    Caption = 'Age';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
            group("Laboratory Test Findings")
            {
                Caption = 'Laboratory Test Findings';
                part(Page; "HMS-Labaratory Test Line")
                {
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
            action("Register Item Usage")
            {
                Caption = 'Register Item Usage';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS Laboratory Item Header";
                RunPageLink = "Laboratory No." = FIELD("Laboratory No.");
                ApplicationArea = All;
            }

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
        //OnAfterGetCurrRecord;
        Patient.RESET;
        Patient.SETRANGE("Patient No.", Rec."Patient No.");
        IF Patient.FIND('-') THEN BEGIN
        END;
        CLEAR(Age);
        IF Patient."Date Of Birth" <> 0D THEN BEGIN
            Age := HRDates.DetermineAge(Patient."Date Of Birth", TODAY);
        END;
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
        LabLine: Record "HMS-Laboratory Test Line";
        blnCompleted: Boolean;
        blnsenttolab: Boolean;
        Age: Text[100];
        HRDates: Codeunit "HR Dates";

        LabHeader: Record "HMS-Laboratory Form Header";

        TreatmentHeader: Record "HMS-Treatment Form Header";
        TreatmentLine: Record "HMS-Treatment Form Laboratory";
        Tests: Record "HMS-Setup Lab Package Test";
        SpecimenList: Record "HMS-Setup Test Specimen";
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        NewNo: Code[20];
        DocLabRequestLines: Record "HMS-Treatment Form Laboratory";
        LabTestLines: Record "HMS-Laboratory Test Line";
        Labsetup: Record "HMS-Setup Lab Test";
        LabSpecimenSetup: Record "HMS-Setup Test Specimen";
        labheader2: Record "HMS-Laboratory Form Header";


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
        /*
        User.RESET;
        SupervisorName:='';
        IF User.GET("User ID") THEN
          BEGIN
            SupervisorName:=User."User Name";
          END;
         */

    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
        GetSupervisorName(Rec."Supervisor ID", SupervisorName);
    end;
}

