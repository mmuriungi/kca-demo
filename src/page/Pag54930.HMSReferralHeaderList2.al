page 54930 "HMS-Referral Header List2"
{
    CardPageID = "HMS Referral Header Released";
    PageType = List;
    SourceTable = "HMS-Referral Header";
    SourceTableView = WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            repeater(rep)
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

