page 51756 "HMS-Patient List"
{
    CardPageID = "HMS Patient Student Card";
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "HMS-Patient";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                Editable = false;
                field(PatientNumber; rec."Patient No.")
                {
                    ApplicationArea = All;

                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Registration Date"; Rec."Date Registered")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Date Registered"; Rec."Date Registered")
                {
                    ApplicationArea = All;

                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }

                // field("Relative No."; Rec."Relative No.")
                // {
                //     ApplicationArea = All;
                // }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Patient Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Photo; Rec.Photo)
                {
                    ApplicationArea = All;
                }

                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
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
            action("Update Info")
            {
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    myInt: Integer;
                begin

                    //MoveRecords();
                end;
            }
            action("Load Missing Staff")
            {
                Caption = 'Load Missing Staff';
                Image = MoveToNextPeriod;
                PromotedCategory = Process;
                Promoted = true;

                ApplicationArea = All;

                trigger OnAction()
                var
                    HrEmployees: Record "HRM-Employee C";
                    targetSrc: record "HMS-Patient";
                    HMSSetup: Record "HMS-Setup";
                    Kin: Record "HRM-Employee Kin";
                    NoSeriesMgt: Codeunit 396;
                    Nextno: code[20];
                begin
                    IF CONFIRM('This will load Missing staff, Continue?', TRUE) = FALSE THEN ERROR('Cancelled by user:' + USERID);
                    HrEmployees.RESET;
                    // HrEmployees.SETFILTER(HrEmployees.Lecturer, '=%1', TRUE);
                    HrEmployees.SETFILTER(Status, '=%1', HrEmployees.Status::Active);
                    HrEmployees.SetFilter("Full / Part Time", '=%1', HrEmployees."Full / Part Time"::"Full Time");
                    IF HrEmployees.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            targetSrc.RESET;
                            targetSrc.SETRANGE(targetSrc."Employee No.", HrEmployees."No.");
                            IF NOT (targetSrc.FIND('-')) THEN BEGIN
                                targetSrc.INIT;
                                HMSSetup.GET;
                                HMSSetup.TESTFIELD("Patient Nos");
                                targetSrc."Patient No." := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", TODAY, TRUE);
                                targetSrc."No. Series" := HMSSetup."Patient Nos";
                                targetSrc."Date Registered" := TODAY;
                                targetSrc."Employee No." := HrEmployees."No.";
                                targetSrc."Full Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                                targetSrc."Date Of Birth" := HrEmployees."Date Of Birth";
                                targetSrc."Marital Status" := HrEmployees."Marital Status";
                                targetSrc."Patient Type" := targetSrc."Patient Type"::Employee;
                                targetSrc."Patient Type2" := targetSrc."Patient Type2"::Employee;
                                targetSrc.Gender := HrEmployees.Gender;
                                targetSrc."ID Number" := HrEmployees."ID Number";
                                targetSrc.Email := HrEmployees."Company E-Mail";
                                targetSrc."Telephone No. 1" := HrEmployees."Cellular Phone Number";

                                Kin.RESET;
                                Kin.SETRANGE("Employee Code", HrEmployees."No.");
                                IF Kin.FINDFIRST THEN BEGIN
                                    targetSrc."Emergency Consent Full Name" := Kin."Other Names" + ' ' + Kin.SurName;
                                    targetSrc."Emergency Consent Address 1" := Kin."E-mail";
                                    targetSrc."Emergency Consent Address 2" := Kin."Home Tel No";
                                    targetSrc."Emergency Consent Address 3" := Kin.Relationship;
                                END;

                                targetSrc.INSERT;
                                targetSrc.VALIDATE("Employee No.");
                                targetSrc.MODIFY;
                            END ELSE BEGIN
                                targetSrc."Full Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                                targetSrc.Gender := HrEmployees.Gender;
                                targetSrc."ID Number" := HrEmployees."ID Number";
                                targetSrc."Date Of Birth" := HrEmployees."Date Of Birth";
                                targetSrc.Email := HrEmployees."Company E-Mail";
                                targetSrc."Telephone No. 1" := HrEmployees."Cellular Phone Number";

                                Kin.RESET;
                                Kin.SETRANGE("Employee Code", HrEmployees."No.");
                                IF Kin.FINDFIRST THEN BEGIN
                                    targetSrc."Emergency Consent Full Name" := Kin."Other Names" + ' ' + Kin.SurName;
                                    targetSrc."Emergency Consent Address 1" := Kin."E-mail";
                                    targetSrc."Emergency Consent Address 2" := Kin."Home Tel No";
                                    targetSrc."Emergency Consent Address 3" := Kin.Relationship;
                                END;

                                targetSrc.MODIFY;
                            END;
                        END;
                        UNTIL HrEmployees.NEXT = 0;
                        MESSAGE('Staff loading completed successfully.');
                    END ELSE
                        MESSAGE('No active staff found to load.');

                    CurrPage.UPDATE;
                end;
            }
            action("Load Missing students")
            {
                Caption = 'Load Missing students ';
                Image = MoveToNextPeriod;
                PromotedCategory = Process;
                Promoted = true;

                ApplicationArea = All;

                trigger OnAction()
                var
                    StudentsRec: Record "Customer";
                    targetSrc: record "HMS-Patient";
                    HMSSetup: Record "HMS-Setup";
                    StudentKin: Record "ACA-Student Kin";
                    NoSeriesMgt: Codeunit 396;
                    Nextno: code[20];
                begin
                    IF CONFIRM('This will load Missing students, Continue?', TRUE) = FALSE THEN ERROR('Cancelled by user:' + USERID);
                    StudentsRec.RESET;
                    // HrEmployees.SETFILTER(HrEmployees.Lecturer, '=%1', TRUE);
                    StudentsRec.SETFILTER(Status, '=%1', StudentsRec.Status::Current);
                    IF StudentsRec.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN
                            targetSrc.RESET;
                            targetSrc.SETRANGE(targetSrc."Employee No.", StudentsRec."No.");
                            IF NOT (targetSrc.FIND('-')) THEN BEGIN
                                targetSrc.INIT;
                                HMSSetup.GET;
                                HMSSetup.TESTFIELD("Patient Nos");
                                targetSrc."Patient No." := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", TODAY, TRUE);
                                targetSrc."No. Series" := HMSSetup."Patient Nos";
                                targetSrc."Date Registered" := TODAY;
                                targetSrc."Employee No." := StudentsRec."No.";
                                targetSrc."Full Name" := StudentsRec."Name";
                                targetSrc."Date Of Birth" := StudentsRec."Date Of Birth";
                                targetSrc."Marital Status" := StudentsRec."Marital Status";
                                targetSrc."Patient Type" := targetSrc."Patient Type"::Student;
                                targetSrc."Patient Type2" := targetSrc."Patient Type2"::Student;
                                targetSrc.Gender := StudentsRec.Gender;
                                targetSrc."ID Number" := StudentsRec."ID No";
                                targetSrc.Email := StudentsRec."University Email";
                                targetSrc."Telephone No. 1" := StudentsRec."Phone No.";

                                StudentKin.RESET;
                                StudentKin.SETRANGE("Student No", StudentsRec."No.");
                                IF StudentKin.FINDFIRST THEN BEGIN
                                    targetSrc."Emergency Consent Full Name" := StudentKin."Other Names" + ' ' + StudentKin.Name;
                                    targetSrc."Emergency Consent Address 1" := StudentKin.Address;
                                    targetSrc."Emergency Consent Address 2" := StudentKin."Home Tel No";
                                    targetSrc."Emergency Consent Address 3" := StudentKin.Relationship;
                                END;

                                targetSrc.INSERT;
                                targetSrc.VALIDATE("Employee No.");
                                targetSrc.MODIFY;
                            END ELSE BEGIN
                                targetSrc."Full Name" := StudentsRec."Name";
                                targetSrc.Gender := StudentsRec.Gender;
                                targetSrc."ID Number" := StudentsRec."ID No";
                                targetSrc."Date Of Birth" := StudentsRec."Date Of Birth";
                                targetSrc.Email := StudentsRec."University Email";
                                targetSrc."Telephone No. 1" := StudentsRec."Phone No.";

                                StudentKin.RESET;
                                StudentKin.SETRANGE("Student No", StudentsRec."No.");
                                IF StudentKin.FINDFIRST THEN BEGIN
                                    targetSrc."Emergency Consent Full Name" := StudentKin."Other Names" + ' ' + StudentKin.Name;
                                    targetSrc."Emergency Consent Address 1" := StudentKin.Address;
                                    targetSrc."Emergency Consent Address 2" := StudentKin."Home Tel No";
                                    targetSrc."Emergency Consent Address 3" := StudentKin.Relationship;
                                END;

                                targetSrc.MODIFY;
                            END;
                        END;
                        UNTIL StudentsRec.NEXT = 0;
                        MESSAGE('Students loading completed successfully.');
                    END ELSE
                        MESSAGE('No active students found to load.');

                    CurrPage.UPDATE;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    trigger OnAfterGetRecord()
    var
        Student: Record Customer;
        Employee: Record "HRM-Employee C";
    begin

    end;


    local procedure MoveRecords()
    var
        sourceRec: record customer;
        targetRec: Record "HMS-Patient";
        NewId: Integer;
        labelS: Label 'PT';
    begin


        sourceRec.SetRange(Status, sourceRec.Status::Registration);


        if sourceRec.FindSet() then begin

            repeat
            begin

                if not targetRec.FindLast() then
                    NewId := 1
                else
                    // NewId := targetRec.PatientNumber + 1;
                    //move data from customer i.e student list to  patient list
                    targetRec.Init();
                //targetRec.PatientNumber := newID;
                targetRec."Student No." := sourceRec."No.";
                targetRec.Gender := sourceRec.Gender;
                targetRec."Date Of Birth" := sourceRec."Date Of Birth";
                targetRec."Full Name" := sourceRec.Name;
                targetRec.Photo := sourceRec."Barcode Picture";
                targetRec."ID Number" := sourceRec."ID No";
                targetRec."Marital Status" := sourceRec."Marital Status";
                targetRec."Patient Type" := targetRec."Patient Type"::Student;
                targetRec.Insert();
                //end;
            end
            until sourceRec.Next() = 0;
            Message('All students are updated successfully ');
        end;

    end;
}
