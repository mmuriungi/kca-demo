page 54970 "HMS-Treatment Form Admission"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Admission";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Ward No."; Rec."Ward No.")
                {
                    ApplicationArea = All;
                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;
                }
                field("Date Of Admission"; Rec."Date Of Admission")
                {
                    ApplicationArea = All;
                }
                field("Admission Reason"; Rec."Admission Reason")
                {
                    ApplicationArea = All;
                }
                field("Admission Remarks"; Rec."Admission Remarks")
                {
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
            action("&Place Request")
            {
                Caption = '&Place Request';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Ask for user confirmation*/
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, TRUE);
                    IF CONFIRM('Send the admission request?', FALSE) = FALSE THEN BEGIN EXIT END;
                    TreatmentHeader.RESET;
                    IF TreatmentHeader.GET(Rec."Treatment No.") THEN BEGIN
                        AdmissionHeader.RESET;
                        AdmissionHeader.INIT;
                        AdmissionHeader."Admission No." := NewNo;
                        AdmissionHeader."Admission Date" := TODAY;
                        AdmissionHeader."Admission Time" := TIME;
                        AdmissionHeader."Admission Area" := AdmissionHeader."Admission Area"::Doctor;
                        AdmissionHeader."Patient No." := TreatmentHeader."Patient No.";
                        AdmissionHeader."Employee No." := TreatmentHeader."Treatment No.";
                        AdmissionHeader."Relative No." := TreatmentHeader."Relative No.";
                        AdmissionHeader.Ward := Rec."Ward No.";
                        AdmissionHeader.Bed := Rec."Bed No.";
                        AdmissionHeader.Doctor := TreatmentHeader."Doctor ID";
                        AdmissionHeader.Remarks := Rec."Admission Remarks";
                        AdmissionHeader."Admission Reason" := Rec."Admission Reason";
                        AdmissionHeader."Student No." := TreatmentHeader."Student No.";
                        AdmissionHeader."Link Type" := 'Doctor';
                        AdmissionHeader."Link No." := TreatmentHeader."Treatment No.";
                        AdmissionHeader.INSERT();
                        MESSAGE('The Admission Request has been sent');
                    END;

                end;
            }
        }
    }

    var
        TreatmentHeader: Record "HMS-Treatment Form Header";
        TreatmentLine: Record "HMS-Treatment Admission";
        AdmissionHeader: Record "HMS-Admission Form Header";
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        NewNo: Code[20];
}

