page 54928 "HMS Referral Header Active"
{
    PageType = Document;
    SourceTable = "HMS-Referral Header";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Treatment no."; Rec."Treatment no.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Referred"; Rec."Date Referred")
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
                field("Hospital No."; Rec."Hospital No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(HospitalName; HospitalName)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Referral Reason"; Rec."Referral Reason")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Referral Remarks"; Rec."Referral Remarks")
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
            group("&Functions")
            {
                Caption = '&Functions';
                action("Referral Completed")
                {
                    Caption = 'Referral Completed';
                    Image = Refresh;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Referrral Confirmed?', TRUE) = FALSE THEN BEGIN EXIT END;

                        Rec.Status := Rec.Status::Released;
                        Rec.MODIFY;
                        MESSAGE('The Referral has been confirmed');
                    end;
                }
                action("Progress Notes")
                {
                    Caption = 'Progress Notes';
                    Image = PutawayLines;
                    Promoted = true;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST(15),
                                  "No." = FIELD("Treatment no.");
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        PatientName: Text[100];
        HospitalName: Text[100];
        Patient: Record "HMS-Patient";
        Hospital: Record 23;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        PatientName := '';
        HospitalName := '';

        Patient.RESET;
        IF Patient.GET(Rec."Patient No.") THEN BEGIN
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        END;

        Hospital.RESET;
        IF Hospital.GET(Rec."Hospital No.") THEN BEGIN
            HospitalName := Hospital.Name;
        END;
    end;
}

