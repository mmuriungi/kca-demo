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
                                Kin.SETRANGE(Type, Kin.Type::"Next of Kin");
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
                                Kin.SETRANGE(Type, Kin.Type::"Next of Kin");
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
                    sourceRec: record customer;
                    targetRec: Record "HMS-Patient";
                    HMSSetup: Record "HMS-Setup";
                    NoSeriesMgt: Codeunit 396;
                    Nextno: code[20];
                begin
                    IF CONFIRM('This will load Missing Students, Continue?', TRUE) = FALSE THEN ERROR('Cancelled by user:' + USERID);
                    HMSSetup.GET;
                    HMSSetup.TESTFIELD("Patient Nos");
                    Nextno := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", today, true);
                    sourcerec.RESET;
                    sourcerec.SetRange(Status, sourcerec.Status::Registration);
                    IF sourcerec.FIND('-') THEN BEGIN
                        REPEAT
                        BEGIN

                            targetRec.RESET;

                            targetRec.SETRANGE(targetRec."Student No.", sourcerec."No.");
                            IF NOT (targetRec.FIND('-')) THEN BEGIN
                                targetRec.INIT;


                                targetRec."Student No." := sourceRec."No.";
                                targetRec.Gender := sourceRec.Gender;
                                targetRec."Date Of Birth" := sourceRec."Date Of Birth";
                                targetRec."Full Name" := sourceRec.Name;
                                targetRec.Photo := sourceRec."Barcode Picture";
                                targetRec."ID Number" := sourceRec."ID No";
                                targetRec."Marital Status" := sourceRec."Marital Status";
                                targetRec."Patient Type" := targetRec."Patient Type"::Student;

                                targetRec.VALIDATE("Student No.");
                                targetRec.INSERT;
                            END ELSE BEGIN

                                targetRec."Full Name" := sourcerec.Name;
                                //targetRec.VALIDATE("Lecturer Code");
                                targetRec.MODIFY;
                            END;
                        END;
                        UNTIL sourcerec.NEXT = 0;
                    END;
                    CurrPage.UPDATE;
                end;



            }


        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
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
