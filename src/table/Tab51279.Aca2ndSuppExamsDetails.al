table 51279 "Aca-2nd Supp. Exams Details"
{
    Caption = 'Aca-2nd Supp. Exams Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(2; Semester; Code[20])
        {
            Caption = 'Semester';
        }
        field(3; "Exam Session"; Code[20])
        {
            Caption = 'Exam Session';
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
        }
        field(5; Stage; Code[20])
        {
            Caption = 'Stage';
        }
        field(6; Programme; Code[20])
        {
            Caption = 'Programme';
        }
        field(7; "Unit Code"; Code[20])
        {
            Caption = 'Unit Code';
            trigger OnValidate()
            begin
                IF GENGeneralSetUp.FIND('-') THEN BEGIN
                    IF GENGeneralSetUp."Special Exam Fee" <> 0 THEN "Cost Per Exam" := GENGeneralSetUp."Special Exam Fee";
                END;
                IF Category = Category::Supplementary THEN BEGIN
                    ACAAcademicYear.RESET;
                    ACAAcademicYear.SETRANGE(Current, TRUE);
                    IF ACAAcademicYear.FIND('-') THEN BEGIN
                        Rec."Current Academic Year" := ACAAcademicYear.Code;
                    END;
                    ACAStudentUnits.RESET;
                    ACAStudentUnits.SETRANGE(Unit, Rec."Unit Code");
                    ACAStudentUnits.SETRANGE("Student No.", Rec."Student No.");
                    IF ACAStudentUnits.FIND('+') THEN BEGIN
                        "Academic Year" := ACAStudentUnits."Academic Year";
                        Semester := ACAStudentUnits.Semester;
                        Stage := ACAStudentUnits.Stage;
                        Programme := ACAStudentUnits.Programme;
                        Category := Rec.Category::Supplementary;
                    END ELSE
                        ERROR('The unit selected is not available for Supplementary');
                END;
            end;
        }
        field(8; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Units/Subjects".Desription WHERE("Programme Code" = FIELD(Programme), Code = FIELD("Unit Code")));
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Approved,Rejected;
            trigger OnValidate()
            begin
                IF Status = Status::Approved THEN BEGIN// Bill the student for the Unit
                                                       //if Category = Category::Supplementary THEN BEGIN
                    ACAGeneralSetUp.RESET;
                    IF ACAGeneralSetUp.FIND('-') THEN BEGIN
                        IF ACAGeneralSetUp."2nd Supp Fee" <> 0 THEN "Cost Per Exam" := ACAGeneralSetUp."2nd Supp Fee";
                        ACAGeneralSetUp.TESTFIELD("2nd Supp Fee");
                        ACAGeneralSetUp.TESTFIELD("2nd Supp Fee Code");
                        ACAGeneralSetUp.TESTFIELD("Transaction Nos.");
                        ACAStdCharges.RESET;
                        ACAStdCharges.SETRANGE("Student No.", Rec."Student No.");
                        ACAStdCharges.SETRANGE(Code, Rec."Unit Code");
                        ACAStdCharges.SETRANGE(Semester, Rec.Semester);
                        IF NOT (ACAStdCharges.FIND('-')) THEN BEGIN
                            ACACourseRegistration.RESET;
                            ACACourseRegistration.SETRANGE(Reversed, FALSE);
                            ACACourseRegistration.SETRANGE("Student No.", Rec."Student No.");
                            IF ACACourseRegistration.FIND('+') THEN BEGIN
                                ACAStdCharges.INIT;
                                ACAStdCharges."Transacton ID" := NoSeriesManagement.GetNextNo(ACAGeneralSetUp."Transaction Nos.", TODAY, TRUE);
                                ACAStdCharges."Student No." := ACACourseRegistration."Student No.";
                                ACAStdCharges."Reg. Transacton ID" := ACACourseRegistration."Reg. Transacton ID";
                                ACAStdCharges."Reg. Transaction ID" := ACACourseRegistration."Reg. Transacton ID";
                                ACAStdCharges.Code := ACAGeneralSetUp."2nd Supp Fee Code";
                                ACAStdCharges."Transaction Type" := ACAStdCharges."Transaction Type"::Charges;
                                ACAStdCharges.Amount := ACAGeneralSetUp."2nd Supp Fee";
                                ACAStdCharges.INSERT;
                                ACAUnitsSubjects.RESET;
                                ACAUnitsSubjects.SETRANGE("Programme Code", Rec.Programme);
                                ACAUnitsSubjects.SETRANGE(Code, Rec."Unit Code");
                                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                    ACAStdCharges.Description := '2nd Supp Unit Billing: ' + ACAUnitsSubjects.Desription;
                                    ACAStdCharges.MODIFY;
                                    BillStudent(ACACourseRegistration, ACAUnitsSubjects);     //Billing Stopped till further Notice
                                END;
                            END;
                        END;
                        Rec."Charge Posted" := TRUE;
                    END ELSE
                        ERROR('General Setup does not exist!');
                    //END;
                end;
            end;
        }
        field(11; "CAT Marks"; Decimal)
        {
            Caption = 'CAT Marks';
            DecimalPlaces = 2 : 2;
        }
        field(12; "Exam Marks"; Decimal)
        {
            Caption = 'Exam Marks';
            DecimalPlaces = 2 : 2;
        }
        field(13; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
            DecimalPlaces = 2 : 2;
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
        }
        field(15; "Cost Per Exam"; Decimal)
        {
            Caption = 'Cost Per Exam';
            DecimalPlaces = 2 : 2;
        }
        field(16; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " ",Special,Supplementary;
            OptionCaption = ' ,Special,Supplementary';
        }
        field(17; "Current Academic Year"; Code[20])
        {
            Caption = 'Current Academic Year';
        }
        field(18; "Marks Exists"; Boolean)
        {
            Caption = 'Marks Exists';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-2nd Supp. Exams Results" WHERE("Student No." = FIELD("Student No."), Unit = FIELD("Unit Code"), Semester = FIELD(Semester)));
        }
        field(19; Sequence; Integer)
        {
            Caption = 'Sequence';
        }
        field(20; "Special Exam Reason"; Code[20])
        {
            Caption = 'Special Exam Reason';
        }
        field(21; "Current Semester"; Code[20])
        {
            Caption = 'Current Semester';
        }
        field(22; "Charge Posted"; Boolean)
        {
            Caption = 'Charge Posted';
        }
        field(23; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(25; "Created Date/Time"; DateTime)
        {
            Caption = 'Created Date/Time';
            Editable = false;
        }
        field(26; "Last Edited By"; Code[50])
        {
            Caption = 'Last Edited By';
            Editable = false;
        }
        field(27; "Last Edited Date/Time"; DateTime)
        {
            Caption = 'Last Edited Date/Time';
            Editable = false;
        }
        field(28; "Original Marks"; Decimal)
        {
            Caption = 'Original Marks';
            DecimalPlaces = 2 : 2;
        }
        field(29; "New Mark"; Decimal)
        {
            Caption = 'New Mark';
            DecimalPlaces = 2 : 2;
        }
        field(42; "Semester flow"; Code[20])
        {
            Caption = 'Semester flow';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Student Units".Semester WHERE("Student No." = FIELD("Student No."), Programme = FIELD(Programme), Unit = FIELD("Unit Code"), "Reg. Reversed" = FILTER(false)));
        }
        field(43; "Academic Year (Flow)"; Code[20])
        {
            Caption = 'Academic Year (Flow)';
            FieldClass = FlowField;
            CalcFormula = Lookup("ACA-Semesters"."Academic Year" WHERE(Code = FIELD(Semester)));
        }
        //Exists Supp one Marks
        field(44; "Exists Supp One Marks"; Boolean)
        {
            Caption = 'Exists Supp One Marks';
            FieldClass = FlowField;
            CalcFormula = Exist("Aca-Special Exams Details" WHERE("Student No." = FIELD("Student No."), "Unit Code" = FIELD("Unit Code"), Category = const(Supplementary), "Exam Marks" = FILTER(<> 0)));
        }
    }

    keys
    {
        key(PK; "Student No.", "Unit Code", "Academic Year", Semester, Sequence)
        {
            Clustered = true;
        }
        key(IX1; Sequence)
        {
        }
    }
    var
        GENGeneralSetUp: Record "ACA-General Set-Up";
        ACAAcademicYear: Record "ACA-Academic Year";
        ACAStudentUnits: Record "ACA-Student Units";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAStdCharges: Record "ACA-Std Charges";
        ACACharge: Record "ACA-Charge";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        ACACourseRegistration: Record "ACA-Course Registration";
        NoSeriesManagement: Codeunit NoSeriesManagement;


    trigger OnInsert()
    begin
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            Rec."Current Academic Year" := ACAAcademicYear.Code;
        END;
        "Created By" := UserId;
        "Created Date/Time" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Edited By" := UserId;
        "Last Edited Date/Time" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin
        IF Rec."Charge Posted" THEN ERROR('Charge Posted. Deletion is not allowed!.');
    end;

    procedure BillStudent(CReg: Record "ACA-Course Registration"; ACAUnitsSubjects: Record "ACA-Units/Subjects")
    var
        GenJournalLine: Record "Gen. Journal Line";
        StudentCharges: Record "ACA-Std Charges";
        Sems: Record "ACA-Semesters";
        GenJnl: Record "Gen. Journal Line";
        DueDatez: Date;
        Customersz: Record Customer;
        Charges: Record "ACA-Charge";
        ProgrammeSetUp: Record "ACA-Programme";
        LineNo: Integer;
    begin
        CLEAR(LineNo);
        LineNo := 100000;
        //Charge Student if not charged
        StudentCharges.RESET;
        StudentCharges.SETRANGE(StudentCharges."Student No.", "Student No.");
        StudentCharges.SETRANGE(StudentCharges.Recognized, FALSE);
        StudentCharges.SETRANGE(StudentCharges."Transaction Type", StudentCharges."Transaction Type"::Charges);
        StudentCharges.SETFILTER(StudentCharges.Amount, '<>%1', 1);
        IF StudentCharges.FIND('-') THEN BEGIN
            GenJnl.RESET;
            GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
            GenJnl.SETRANGE(GenJnl."Journal Batch Name", 'STUD PAY');
            GenJnl.DELETEALL;


            GenJnl.RESET;
            GenJnl.SETRANGE(GenJnl."Journal Template Name", 'SALES');
            GenJnl.SETRANGE(GenJnl."Journal Batch Name", 'STUD PAY');
            IF GenJnl.FIND('+') THEN LineNo := GenJnl."Line No.";//GenJnl.DELETE;

            REPEAT
                Charges.RESET;
                Charges.SETRANGE(Code, StudentCharges.Code);
                IF Charges.FIND('-') THEN;
                DueDatez := StudentCharges.Date;
                IF Sems.GET(StudentCharges.Semester) THEN BEGIN
                    IF Sems.From <> 0D THEN BEGIN
                        IF Sems.From > DueDatez THEN
                            DueDatez := Sems.From;
                    END;
                END;

                IF DueDatez = 0D THEN DueDatez := TODAY;//
                IF Charges."G/L Account" <> ' ' THEN
                    IF Customersz.GET("Student No.") THEN BEGIN

                        LineNo := LineNo + 1;
                        GenJnl.INIT;
                        GenJnl."Line No." := LineNo;
                        GenJnl."Posting Date" := TODAY;
                        GenJnl."Document No." := StudentCharges."Transacton ID";
                        GenJnl.VALIDATE(GenJnl."Document No.");
                        GenJnl."Journal Template Name" := 'SALES';
                        GenJnl."Journal Batch Name" := 'STUD PAY';
                        GenJnl."Account Type" := GenJnl."Account Type"::Customer;
                        GenJnl.Description := COPYSTR('Supp - ' + ACAUnitsSubjects.Code + ': ' + ACAUnitsSubjects.Desription, 1, 50);
                        // IF Customersz."Bill-to Customer No." <> '' THEN
                        GenJnl."Account No." := Customersz."No.";
                        // ELSE
                        // GenJnl."Account No.":="Student No.";
                        IF StudentCharges.Amount = 0 THEN StudentCharges.Amount := 200;
                        GenJnl.Amount := StudentCharges.Amount;
                        GenJnl.VALIDATE(GenJnl."Account No.");
                        GenJnl.VALIDATE(GenJnl.Amount);
                        //GenJnl.Description:=StudentCharges.Description;
                        GenJnl."Bal. Account Type" := GenJnl."Account Type"::"G/L Account";
                        GenJnl."Bal. Account No." := Charges."G/L Account";
                        GenJnl.VALIDATE(GenJnl."Bal. Account No.");

                        CReg.RESET;
                        CReg.SETRANGE(CReg."Student No.", "Student No.");
                        CReg.SETRANGE(CReg.Reversed, FALSE);
                        IF CReg.FIND('+') THEN BEGIN
                            IF ProgrammeSetUp.GET(CReg.Programmes) THEN BEGIN
                                ProgrammeSetUp.TESTFIELD(ProgrammeSetUp."Department Code");
                                //ProgrammeSetUp.TESTFIELD(Cust."Global Dimension 1 Code");
                                GenJnl."Shortcut Dimension 1 Code" := Customersz."Global Dimension 1 Code";
                                GenJnl."Shortcut Dimension 2 Code" := ProgrammeSetUp."Department Code";
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 1 Code");
                                GenJnl.VALIDATE(GenJnl."Shortcut Dimension 2 Code");
                            END;
                        END;

                        GenJnl."Due Date" := DueDatez;
                        GenJnl.VALIDATE(GenJnl."Due Date");
                        IF StudentCharges."Recovery Priority" <> 0 THEN
                            GenJnl."Recovery Priority" := StudentCharges."Recovery Priority"
                        ELSE
                            GenJnl."Recovery Priority" := 25;
                        GenJnl.INSERT;
                    END;
                StudentCharges.Recognized := TRUE;
                StudentCharges.MODIFY;

            UNTIL StudentCharges.NEXT = 0;
            //ERROR('debugging ---');
            //Post New
            GenJnl.RESET;
            GenJnl.SETRANGE("Journal Template Name", 'SALES');
            GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
            IF GenJnl.FindSet() THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJnl);
            END;

            //Post New



        END
    end;
}
