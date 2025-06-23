page 51792 "HMS Referral Header Active"
{
    PageType = Document;
    SourceTable = "HMS-Referral Header";

    layout
    {
        area(content)
        {
            group("General Information")
            {
                Caption = 'General Information';

                field("Referral No."; Rec."Referral No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Treatment no."; Rec."Treatment no.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Date Referred"; Rec."Date Referred")
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

            group("PART A - To be retained by Consultant/Hospital")
            {
                Caption = 'PART A - To be retained by Consultant/Hospital';

                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Staff/Dependant/Student Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("PF/STD No."; Rec."PF/STD No.")
                {
                    ApplicationArea = All;
                }
                field("Referred Hospital"; Rec."Referred Hospital")
                {
                    Caption = 'Referred to Prof/Dr/Mr';
                    ApplicationArea = All;
                }
                field("Clinical History"; Rec."Clinical History")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Examination Findings"; Rec."Examination Findings")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Investigations Done"; Rec."Investigations Done")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Provisional Diagnosis"; Rec."Provisional Diagnosis")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Present Treatment"; Rec."Present Treatment")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Comments"; Rec."Comments")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }

            group("Reason(s) for Referral")
            {
                Caption = 'Reason(s) for Referral';

                field("Opinion/Advice"; Rec."Opinion/Advice")
                {
                    ApplicationArea = All;
                }
                field("Investigation (Specify)"; Rec."Investigation (Specify)")
                {
                    ApplicationArea = All;
                }
                field("Further Management"; Rec."Further Management")
                {
                    ApplicationArea = All;
                }
                field("For Review"; Rec."For Review")
                {
                    ApplicationArea = All;
                }
            }

            group("Chief Medical Officer")
            {
                Caption = 'For: Chief Medical Officer';

                field("CMO Name"; Rec."CMO Name")
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("CMO Signature/Stamp"; Rec."CMO Signature/Stamp")
                {
                    Caption = 'Signature/Stamp';
                    ApplicationArea = All;
                }
                field("CMO Date"; Rec."CMO Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
            }

            group("PART B - Confidential Report")
            {
                Caption = 'PART B - Confidential Report (To be returned to University Clinic by Patient)';

                field("Clinical Lab Findings"; Rec."Clinical Lab Findings")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Diagnosis"; Rec."Diagnosis")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Further Invest Required"; Rec."Further Invest Required")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Treatment Started"; Rec."Treatment Started")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Other Remarks"; Rec."Other Remarks")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    Caption = 'Doctors Name';
                    ApplicationArea = All;
                }
                field("Doctor Sign"; Rec."Doctor Sign")
                {
                    Caption = 'Sign';
                    ApplicationArea = All;
                }
                field("Report Date"; Rec."Report Date")
                {
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field("Official Rubber Stamp"; Rec."Official Rubber Stamp")
                {
                    ApplicationArea = All;
                }
            }

            group("PART C - To be attached to medical claim")
            {
                Caption = 'PART C - To be attached to medical claim';

                field("Consultant/Specialist Name"; Rec."Consultant/Specialist Name")
                {
                    ApplicationArea = All;
                }
                field("Consultant PF No."; Rec."Consultant PF No.")
                {
                    ApplicationArea = All;
                }
                field("Consultant Signature"; Rec."Consultant Signature")
                {
                    ApplicationArea = All;
                }
                field("Consultant Date/Stamp"; Rec."Consultant Date/Stamp")
                {
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
                action("Print Referral Form")
                {
                    Caption = 'Print Referral Form';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // Add report call here
                        MESSAGE('Print functionality to be implemented');
                    end;
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