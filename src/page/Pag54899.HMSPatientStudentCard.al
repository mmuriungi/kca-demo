page 54899 "HMS Patient Student Card"
{
    DeleteAllowed = true;
    PageType = Card;
    Editable = true;
    SourceTable = "HMS-Patient";
    layout
    {
        area(content)
        {
            group("Personal details")
            {
                Caption = 'Personal details';
                Editable = true;
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    Caption = 'Clinic No.';
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type2")
                {
                    Editable = true;
                    ApplicationArea = All;
                    //OptionCaption = 'Employee,Student,Others';

                    trigger OnValidate()
                    begin
                        rec.IsPatientTypeOthers := (rec."Patient Type2" = rec."Patient Type2"::Others);
                        if rec.IsPatientTypeOthers then begin
                            rec."Employee No." := '';
                            Rec."Full Name" := '';
                            Rec.Gender := Rec.Gender;
                            Rec."ID Number" := '';
                            Rec."Date Of Birth" := 0D;
                            Rec."Correspondence Address 1" := '';
                            rec."Emergency Consent Full Name" := '';
                            rec."Correspondence Address 2" := '';
                            rec."Correspondence Address 3" := '';
                            rec.Age := '';
                            rec.email := '';
                            Clear(rec.Photo);

                        end;
                        rec.Modify();
                        CurrPage.UPDATE(true);

                    end;
                }
                // field("Student No."; Rec."Student No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Employee No."; Rec."Employee No.")
                {
                    Caption = 'Patient  Number';
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Editable = rec.IsPatientTypeOthers;

                }
                field("Telephone No. 1"; rec."Telephone No. 1")
                {
                    ApplicationArea = all;
                }
                // field("File No."; Rec."File No.")
                // {
                //     ApplicationArea = All;

                // }
                // field("Relative No."; Rec."Relative No.")
                // {
                //     ApplicationArea = All;
                // }
                /*  field("Region"; Rec."Global Dimension 1 Code")
                 {
                     Caption = 'Region';
                     ApplicationArea = All;
                 }
                 field("Cost Center"; Rec."Global Dimension 2 Code")
                 {
                     Caption = 'Cost Center';
                     ApplicationArea = All;
                 } */
                // field(Title; Rec.Title)
                // {
                //     ApplicationArea = All;
                // }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    Editable = REC.IsPatientTypeOthers;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                    Editable = REC.IsPatientTypeOthers;

                    trigger OnValidate()
                    begin
                        IF Rec."Date Of Birth" <> 0D THEN BEGIN
                            rec.Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
                            CurrPage.Update();
                        END;

                    end;
                }
                // field("Marital Status"; Rec."Marital Status")
                // {
                //     ApplicationArea = All;
                // }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                    Editable = REC.IsPatientTypeOthers;

                }
                field(Age; rec.Age)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Photo; Rec.Photo)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field(Email; rec.Email)
                {
                    ApplicationArea = All;
                }
            }
            group("Pre Medical details")
            {
                Caption = 'Examination Results';
                Editable = true;
                field("Examining Officer"; Rec."Examining Officer")
                {
                    ApplicationArea = All;
                }
                field("Medical Exam Date"; Rec."Medical Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }
                field("Rhesus Factor"; Rec."Rhesus Factor")
                {
                    ApplicationArea = All;
                }
                field("Physical Impairment Details"; Rec."Physical Impairment Details")
                {
                    ApplicationArea = All;
                }
                // field(IsAllergic; rec.IsAllergic)
                // {
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     var
                //         myInt: Integer;
                //     begin
                //         CurrPage.Update();
                //     end;

                // }
                field(AllergicTo; rec.AllergicTo)
                {
                    ApplicationArea = all;
                    //Visible = rec.IsAllergic;
                }

            }
            group("Emergency Contacts")
            {
                // field("Emergency Consent Relationship"; Rec."Emergency Consent Relationship")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Contact Relationship';
                // }
                field("Emergency Consent Full Name"; Rec."Emergency Consent Full Name")
                {
                    ApplicationArea = All;
                    Caption = 'Next Of kin Phone NO:';
                }
                field("Emergency contact email adress"; Rec."Emergency Consent Address 1")
                {
                    ApplicationArea = All;
                    Caption = 'Next Of kin  email adress';
                }
                field("Contact Phone Number"; Rec."Emergency Consent Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Next Of kin Phone Name';
                }
                field("Emergency Consent Relationship"; rec."Emergency Consent Address 3")
                {
                    ApplicationArea = All;
                    Caption = 'Next Of kin RelationShip';
                }
            }
            // group("Historical Medical Conditions")
            // {
            //     Caption = 'Past Medical/Surgical History';
            //     Editable = true;
            //     part(Part; "HMS Patient Medical Condition")
            //     {
            //         SubPageLink = "Patient No." = FIELD("Patient No.");
            //         ApplicationArea = All;
            //         Editable = true;
            //     }
            // }
            // group("Historical Immunizations")
            // {
            //     Caption = 'Historical Immunizations';
            //     Editable = true;
            //     part(Pt2; "HMS Patient Immunization")
            //     {
            //         SubPageLink = "Patient No." = FIELD("Patient No.");
            //         ApplicationArea = All;
            //     }
            // }
            // group("Spouse details (If Married)")
            // {
            //     Caption = 'Spouse details (If Married)';
            //     Editable = true;
            //     field("Spouse Name"; Rec."Spouse Name")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Address 1"; Rec."Spouse Address 1")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Address 2"; Rec."Spouse Address 2")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Address 3"; Rec."Spouse Address 3")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Telephone No. 1"; Rec."Spouse Telephone No. 1")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Telephone No. 2"; Rec."Spouse Telephone No. 2")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Email"; Rec."Spouse Email")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Spouse Fax"; Rec."Spouse Fax")
            //     {
            //         ApplicationArea = All;
            //     }
            // }
            // group("Correspondence Address")
            // {
            //     Caption = 'Correspondence Address';
            //     Editable = true;
            //     field("Place of Birth Village"; Rec."Place of Birth Village")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Place of Birth Location"; Rec."Place of Birth Location")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Place of Birth District"; Rec."Place of Birth District")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Name of Chief"; Rec."Name of Chief")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Nearest Police Station"; Rec."Nearest Police Station")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Correspondence Address 1"; Rec."Correspondence Address 1")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Correspondence Address 2"; Rec."Correspondence Address 2")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Correspondence Address 3"; Rec."Correspondence Address 3")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Telephone No. 1"; Rec."Telephone No. 1")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Telephone No. 2"; Rec."Telephone No. 2")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field(Email; Rec.Email)
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Fax No."; Rec."Fax No.")
            //     {
            //         ApplicationArea = All;
            //     }
            // }
            group("Parent Details")
            {
                Caption = 'Parent Details';
                Editable = true;
                // field("Mother Alive or Dead"; Rec."Mother Alive or Dead")
                // {
                //     ApplicationArea = All;
                // }
                field("Mother Full Name"; Rec."Mother Full Name")
                {
                    ApplicationArea = All;
                }
                field("Mother Occupation"; Rec."Mother Occupation")
                {
                    ApplicationArea = All;
                }
                // field("Father Alive or Dead"; Rec."Father Alive or Dead")
                // {
                //     ApplicationArea = All;
                // }
                field("Father Full Name"; Rec."Father Full Name")
                {
                    ApplicationArea = All;
                }
                field("Father Occupation"; Rec."Father Occupation")
                {
                    ApplicationArea = All;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                }
                field("Guardian Occupation"; Rec."Guardian Occupation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
        }
        area(processing)
        {
            action(Statistics)
            {
                Caption = 'Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "HMS-Patient Card";
                RunPageLink = "Patient No." = FIELD("Patient No.");
                ApplicationArea = All;
            }
            action("Register Visit")
            {
                ApplicationArea = All;
                Image = Registered;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.CreateObservation();
                end;
            }
            action(sendToDoctorList)
            {
                Caption = 'Doctor''s list';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var

                begin
                    IF CONFIRM('Dispatch selected Patient to the Doctor''s List?', FALSE) = FALSE THEN BEGIN EXIT END;
                    /*Create an Doctor*/
                    if pt.Get(rec."Patient No.") then begin

                        HMSSetup.RESET;
                        HMSSetup.GET();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, TRUE);
                        Doctor.INIT();
                        pt.CalcFields(Photo);
                        Doctor."Treatment No." := NewNo;
                        Doctor."Treatment Type" := Doctor."Treatment Type"::Outpatient;
                        Doctor."Treatment Date" := TODAY;
                        Doctor."Treatment Time" := TIME;
                        Doctor."Patient No." := pt."Employee No.";
                        Doctor."Patient Name" := pt."Full Name";
                        Doctor."ID Number" := pt."ID Number";
                        Doctor.AllergicTo := pt.AllergicTo;
                        Doctor.age := pt.Age;
                        Doctor.gender := pt.Gender;
                        Doctor.Photo := pt.Photo;
                        Doctor.Email := pt.Email;
                        Doctor."Telephone No. 1" := pt."Telephone No. 1";

                        Doctor.Status := Doctor.Status::New;
                        Doctor."Link No." := pt."Patient No.";
                        Doctor."Link Type" := 'Appointment';
                        Doctor."Student No." := pt."Student No.";
                        Doctor."Treatment Date" := today();
                        Doctor."Treatment Time" := System.Time();
                        Doctor.AllergicTo := rec.AllergicTo;
                        Doctor.Location := Doctor.Location::Queue;

                        Doctor.INSERT(true);
                        //"Patient Current Location":="Patient Current Location"::"Doctor List";
                        // "Doctor Visit Status":="Doctor Visit Status"::Doctor;
                        //"Observation Status":="Observation Status"::Cleared;

                        Rec.MODIFY;
                        MESSAGE('Selected Patient has been dispatched to the Doctor''s List!.')
                    end ELSE
                        ERROR('This Is alreadly Sent');
                end;
            }
        }
    }


    trigger OnInit()
    begin
        "Relative No.Enable" := TRUE;
        "Employee No.Enable" := TRUE;
        "Student No.Enable" := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        REC."Examining Officer" := UserId();
        REC."Patient Type2" := REC."Patient Type2"::Others;
    end;



    trigger OnOpenPage()
    begin
        if Rec."File No." = '' then begin
            Rec."File No." := '';
            if (Rec."Patient No." <> '') then begin
                Rec."File No." := 'CN/' + Rec."Employee No.";
            end;
        end;
    end;

    var
        HasValue: Boolean;
        HRDates: Codeunit "HR Dates";
        Age: Text[100];
        [InDataSet]
        "Student No.Enable": Boolean;
        [InDataSet]
        "Employee No.Enable": Boolean;
        [InDataSet]
        "Relative No.Enable": Boolean;
        NewNo: Code[20];
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        pt: Record "HMS-Patient";
        Doctor: Record "HMS-Treatment Form Header";

    procedure CheckPatientType()
    begin
        IF Rec."Patient Type" = Rec."Patient Type2"::Others THEN BEGIN
            "Student No.Enable" := TRUE;
            "Employee No.Enable" := FALSE;
            "Relative No.Enable" := FALSE;
        END
        ELSE BEGIN
            "Student No.Enable" := FALSE;
            "Employee No.Enable" := TRUE;
            "Relative No.Enable" := TRUE;
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        CheckPatientType();
        IF Rec."Date Of Birth" <> 0D THEN BEGIN
            rec.Age := HRDates.DetermineAge(Rec."Date Of Birth", TODAY);
        END;
    end;

    var
        IsPatientTypeOthers: Boolean;

    trigger OnAfterGetRecord()
    begin
        REC.IsPatientTypeOthers := (REC."Patient Type2" = REC."Patient Type2"::Others);
    end;


    local procedure ShowAllergicToField(): Boolean;
    begin
        exit(Rec."IsAllergic");
    end;
}

