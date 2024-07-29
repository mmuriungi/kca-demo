page 54858 "HMS Laboratory Form History"
{
    PageType = Document;
    SourceTable = "HMS-Laboratory Form Header";
    SourceTableView = WHERE(Status = CONST(Completed));

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
                part(Page; "HMS-Labaratory Test Line")
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
    }

    trigger OnAfterGetRecord()
    begin
        //  OnAfterGetCurrRecord;
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
        /*Patient.RESET;
        PatientName:='';
        IF Patient.GET(PatientNo) THEN
          BEGIN
            PatientName:=Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
          END;  */

    end;


    procedure GetSupervisorName(var "User ID": Code[20]; var SupervisorName: Text[100])
    begin
        /*User.RESET;
        SupervisorName:='';
        IF User.GET("User ID") THEN
          BEGIN
           // SupervisorName:=User.Name;
          END;*/

    end;

    trigger OnAfterGetCurrRecord()
    begin
        /*xRec := Rec;
        GetPatientName("Patient No.",PatientName);
        GetSupervisorName("Supervisor ID",SupervisorName);*/

    end;
}

