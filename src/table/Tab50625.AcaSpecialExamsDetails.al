table 50625 "Aca-Special Exams Details"
{
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
                        //  "Academic Year":=ACAStudentUnits."Academic Year";
                        //  Semester:=ACAStudentUnits.Semester;
                        //  Stage:=ACAStudentUnits.Stage;
                        //  Programme:=ACAStudentUnits.Programme;
                        //  Category:=Rec.Category::Supplementary;
                    END;// ELSE ERROR('The unit selected is not available for Supplementary');
                END;

            end;
        }
        field(8; "Unit Description"; Text[150])
        {
            Caption = 'Unit Description';
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Approved,Rejected;
            trigger OnValidate()
            begin

                IF Status = Status::Approved THEN BEGIN// Bill the student for the Unit
                    ACAGeneralSetUp.RESET;
                    IF ACAGeneralSetUp.FIND('-') THEN BEGIN
                        IF GENGeneralSetUp."Supplementary Fee" <> 0 THEN "Cost Per Exam" := GENGeneralSetUp."Supplementary Fee";
                        ACAGeneralSetUp.TESTFIELD("Supplementary Fee");
                        ACAGeneralSetUp.TESTFIELD("Supplementary Fee Code");
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
                                ACAStdCharges.Code := ACAGeneralSetUp."Supplementary Fee Code";
                                ACAStdCharges."Transaction Type" := ACAStdCharges."Transaction Type"::Charges;
                                ACAStdCharges.Amount := ACAGeneralSetUp."Supplementary Fee";
                                ACAStdCharges.INSERT;
                                ACAUnitsSubjects.RESET;
                                ACAUnitsSubjects.SETRANGE("Programme Code", Rec.Programme);
                                ACAUnitsSubjects.SETRANGE(Code, Rec."Unit Code");
                                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                                    ACAStdCharges.Description := ' Supp Unit Billing: ' + ACAUnitsSubjects.Desription;
                                    ACAStdCharges.MODIFY;
                                    BillStudent(ACACourseRegistration, ACAUnitsSubjects);     //Billing Stopped till further Notice
                                END;
                            END;
                        END;
                        Rec."Charge Posted" := TRUE;
                    END ELSE
                        ERROR('General Setup does not exist!');
                END;

            end;
        }
        field(11; "CAT Marks"; Decimal)
        {
            Caption = 'CAT Marks';
        }
        field(12; "Exam Marks"; Decimal)
        {
            Caption = 'Exam Marks';
        }
        field(13; "Total Marks"; Decimal)
        {
            Caption = 'Total Marks';
        }
        field(14; Grade; Code[10])
        {
            Caption = 'Grade';
        }
        field(15; "Cost Per Exam"; Decimal)
        {
            Caption = 'Cost Per Exam';
        }
        field(16; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " ",Special,Supplementary,Resit;
        }
        field(17; "Current Academic Year"; Code[20])
        {
            Caption = 'Current Academic Year';
        }
        field(18; "Marks Exists"; Boolean)
        {
            Caption = 'Marks Exists';
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
        field(23; "Flow Marks"; Decimal)
        {
            Caption = 'Flow Marks';
        }
        field(24; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(25; "Created Date/Time"; DateTime)
        {
            Caption = 'Created Date/Time';
        }
        field(26; "Last Edited By"; Code[20])
        {
            Caption = 'Last Edited By';
        }
        field(27; "Last Edited Date/Time"; DateTime)
        {
            Caption = 'Last Edited Date/Time';
        }
        field(28; "Original Marks"; Decimal)
        {
            Caption = 'Original Marks';
        }
        field(29; "New Mark"; Decimal)
        {
            Caption = 'New Mark';
        }
        field(30; Occurances; Integer)
        {
            Caption = 'Occurances';
        }
        field(31; "Corect Semester Year"; Code[20])
        {
            Caption = 'Corect Semester Year';
        }
        field(32; "Academic Year Matches"; Boolean)
        {
            Caption = 'Academic Year Matches';
        }
        field(33; "Combined Score"; Decimal)
        {
            Caption = 'Combined Score';
        }
        field(34; "Exact Score Exists"; Boolean)
        {
            Caption = 'Exact Score Exists';
        }
        field(35; "Year of Study"; Integer)
        {
            Caption = 'Year of Study';
        }
        field(36; "Results Released"; Boolean)
        {
            Caption = 'Results Released';
        }
        field(37; Billed; Boolean)
        {
            Caption = 'Billed';
        }
        field(38; "Total Score"; Decimal)
        {
            Caption = 'Total Score';
        }
        field(39; "CATs Marks"; Decimal)
        {
            Caption = 'CATs Marks';
        }
        field(40; "EXAMs Marks"; Decimal)
        {
            Caption = 'EXAMs Marks';
        }
        field(41; "Results Audit"; Integer)
        {
            Caption = 'Results Audit';
        }
        field(42; "Semester flow"; Code[20])
        {
            Caption = 'Semester flow';
        }
        field(43; "Academic Year (Flow)"; Code[20])
        {
            Caption = 'Academic Year (Flow)';
        }
        field(44; Occurance; Integer)
        {
            Caption = 'Occurance';
        }
        field(45; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(46; "2nd Supp Marks"; Decimal)
        {
            Caption = '2nd Supp Marks';
        }
    }

    keys
    {
        key(PK; "Student No.", "Unit Code", "Academic Year", Semester, Sequence, Category, Programme)
        {
            Clustered = true;
        }
        key(SK1; Sequence)
        {
        }
        key(SK2; Programme, "Unit Code", "Student No.")
        {
        }
    }

    trigger OnInsert()
    begin
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            Rec."Current Academic Year" := ACAAcademicYear.Code;
        END;
        ACAAcademicYear.RESET;
        ACAAcademicYear.SETRANGE(Current, TRUE);
        IF ACAAcademicYear.FIND('-') THEN BEGIN
            Rec."Current Academic Year" := ACAAcademicYear.Code;
        END;
        CLEAR(AcaSpecialSuppDetailsAudit2);
        AcaSpecialSuppDetailsAudit2.RESET;
        AcaSpecialSuppDetailsAudit2.SETRANGE("Student No.", Rec."Student No.");
        IF AcaSpecialSuppDetailsAudit2.FIND('-') THEN;
        CLEAR(CountedEntries);
        CountedEntries := AcaSpecialSuppDetailsAudit2.COUNT;
        CountedEntries += 1;
        AcaSpecialSuppDetailsAudit.INIT;
        AcaSpecialSuppDetailsAudit."Student No." := Rec."Student No.";
        AcaSpecialSuppDetailsAudit."Unit Code" := Rec."Unit Code";
        AcaSpecialSuppDetailsAudit."Academic Year" := Rec."Academic Year";
        AcaSpecialSuppDetailsAudit.Semester := Rec.Semester;
        AcaSpecialSuppDetailsAudit.Sequence := Rec.Sequence;
        AcaSpecialSuppDetailsAudit.Programme := Rec.Programme;
        AcaSpecialSuppDetailsAudit.Stage := Rec.Stage;
        AcaSpecialSuppDetailsAudit.Category := Rec.Category;
        AcaSpecialSuppDetailsAudit."Entry No." := CountedEntries;
        AcaSpecialSuppDetailsAudit."Exam Session" := Rec."Exam Session";
        AcaSpecialSuppDetailsAudit.Status := Rec.Status;
        AcaSpecialSuppDetailsAudit."CAT Marks" := Rec."CAT Marks";
        AcaSpecialSuppDetailsAudit."Exam Marks" := Rec."Exam Marks";
        AcaSpecialSuppDetailsAudit."Total Marks" := Rec."Total Marks";
        AcaSpecialSuppDetailsAudit.Grade := Rec.Grade;
        AcaSpecialSuppDetailsAudit."Update Type" := 'Insert';
        AcaSpecialSuppDetailsAudit.INSERT;
    end;

    trigger OnModify()
    begin
        CLEAR(AcaSpecialSuppDetailsAudit2);
        AcaSpecialSuppDetailsAudit2.RESET;
        AcaSpecialSuppDetailsAudit2.SETRANGE("Student No.", Rec."Student No.");
        IF AcaSpecialSuppDetailsAudit2.FIND('-') THEN;
        CLEAR(CountedEntries);
        CountedEntries := AcaSpecialSuppDetailsAudit2.COUNT;
        CountedEntries += 1;
        AcaSpecialSuppDetailsAudit.INIT;
        AcaSpecialSuppDetailsAudit."Student No." := Rec."Student No.";
        AcaSpecialSuppDetailsAudit."Unit Code" := Rec."Unit Code";
        AcaSpecialSuppDetailsAudit."Academic Year" := Rec."Academic Year";
        AcaSpecialSuppDetailsAudit.Semester := Rec.Semester;
        AcaSpecialSuppDetailsAudit.Sequence := Rec.Sequence;
        AcaSpecialSuppDetailsAudit.Programme := Rec.Programme;
        AcaSpecialSuppDetailsAudit.Stage := Rec.Stage;
        AcaSpecialSuppDetailsAudit.Category := Rec.Category;
        AcaSpecialSuppDetailsAudit."Entry No." := CountedEntries;
        AcaSpecialSuppDetailsAudit."Exam Session" := Rec."Exam Session";
        AcaSpecialSuppDetailsAudit.Status := Rec.Status;
        AcaSpecialSuppDetailsAudit."CAT Marks" := Rec."CAT Marks";
        AcaSpecialSuppDetailsAudit."Exam Marks" := Rec."Exam Marks";
        AcaSpecialSuppDetailsAudit."Total Marks" := Rec."Total Marks";
        AcaSpecialSuppDetailsAudit.Grade := Rec.Grade;
        AcaSpecialSuppDetailsAudit."Update Type" := 'Edit';
        AcaSpecialSuppDetailsAudit.INSERT;
    end;

    trigger OnDelete()
    begin
        IF Rec."Marks Exists" THEN ERROR('Marks posted. Deletion is NOT ALLOWED!.');
        IF Rec."Charge Posted" THEN ERROR('BILL ALREADY POSTED!');
        IF Billed = TRUE THEN ERROR('Posted already');
        IF Rec.Status = Rec.Status::Approved THEN ERROR('Posted aready!');

        CLEAR(AcaSpecialSuppDetailsAudit2);
        AcaSpecialSuppDetailsAudit2.RESET;
        AcaSpecialSuppDetailsAudit2.SETRANGE("Student No.", Rec."Student No.");
        IF AcaSpecialSuppDetailsAudit2.FIND('-') THEN;
        CLEAR(CountedEntries);
        CountedEntries := AcaSpecialSuppDetailsAudit2.COUNT;
        CountedEntries += 1;
        AcaSpecialSuppDetailsAudit.INIT;
        AcaSpecialSuppDetailsAudit."Student No." := Rec."Student No.";
        AcaSpecialSuppDetailsAudit."Unit Code" := Rec."Unit Code";
        AcaSpecialSuppDetailsAudit."Academic Year" := Rec."Academic Year";
        AcaSpecialSuppDetailsAudit.Semester := Rec.Semester;
        AcaSpecialSuppDetailsAudit.Sequence := Rec.Sequence;
        AcaSpecialSuppDetailsAudit.Programme := Rec.Programme;
        AcaSpecialSuppDetailsAudit.Stage := Rec.Stage;
        AcaSpecialSuppDetailsAudit.Category := Rec.Category;
        AcaSpecialSuppDetailsAudit."Entry No." := CountedEntries;
        AcaSpecialSuppDetailsAudit."Exam Session" := Rec."Exam Session";
        AcaSpecialSuppDetailsAudit.Status := Rec.Status;
        AcaSpecialSuppDetailsAudit."CAT Marks" := Rec."CAT Marks";
        AcaSpecialSuppDetailsAudit."Exam Marks" := Rec."Exam Marks";
        AcaSpecialSuppDetailsAudit."Total Marks" := Rec."Total Marks";
        AcaSpecialSuppDetailsAudit.Grade := Rec.Grade;
        AcaSpecialSuppDetailsAudit."Update Type" := 'Delete';
        AcaSpecialSuppDetailsAudit.INSERT;
    end;

    trigger OnRename()
    begin

        CLEAR(AcaSpecialSuppDetailsAudit2);
        AcaSpecialSuppDetailsAudit2.RESET;
        AcaSpecialSuppDetailsAudit2.SETRANGE("Student No.", Rec."Student No.");
        IF AcaSpecialSuppDetailsAudit2.FIND('-') THEN;
        CLEAR(CountedEntries);
        CountedEntries := AcaSpecialSuppDetailsAudit2.COUNT;
        CountedEntries += 1;
        AcaSpecialSuppDetailsAudit.INIT;
        AcaSpecialSuppDetailsAudit."Student No." := Rec."Student No.";
        AcaSpecialSuppDetailsAudit."Unit Code" := Rec."Unit Code";
        AcaSpecialSuppDetailsAudit."Academic Year" := Rec."Academic Year";
        AcaSpecialSuppDetailsAudit.Semester := Rec.Semester;
        AcaSpecialSuppDetailsAudit.Sequence := Rec.Sequence;
        AcaSpecialSuppDetailsAudit.Programme := Rec.Programme;
        AcaSpecialSuppDetailsAudit.Stage := Rec.Stage;
        AcaSpecialSuppDetailsAudit.Category := Rec.Category;
        AcaSpecialSuppDetailsAudit."Entry No." := CountedEntries;
        AcaSpecialSuppDetailsAudit."Exam Session" := Rec."Exam Session";
        AcaSpecialSuppDetailsAudit.Status := Rec.Status;
        AcaSpecialSuppDetailsAudit."CAT Marks" := Rec."CAT Marks";
        AcaSpecialSuppDetailsAudit."Exam Marks" := Rec."Exam Marks";
        AcaSpecialSuppDetailsAudit."Total Marks" := Rec."Total Marks";
        AcaSpecialSuppDetailsAudit.Grade := Rec.Grade;
        AcaSpecialSuppDetailsAudit."Update Type" := 'Rename';
        AcaSpecialSuppDetailsAudit.INSERT;
    end;

    var
        GENGeneralSetUp: Record "ACA-General Set-Up";
        ACAAcademicYear: Record "ACA-Academic Year";
        ACAStudentUnits: Record "ACA-Student Units";
        SExams: Record "ACA-Exams Setup";
        Gradings: Record "ACA-Exam Gradding Setup";
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Gradings2: Record "ACA-Exam Gradding Setup";
        EResults: Record "ACA-Exam Results";
        Exams: Record "ACA-Exams Setup";
        Course_Reg: Record "ACA-Course Registration";
        stud_Units: Record "ACA-Student Units";
        prog: Record "ACA-Programme";
        Course_Reg2: Record "ACA-Course Registration";
        stud_Units2: Record "ACA-Student Units";
        ACAGeneralSetUp: Record "ACA-General Set-Up";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        ACAStdCharges: Record "ACA-Std Charges";
        ACACharge: Record "ACA-Charge";
        AcaSpecialExamsDetails: Record "Aca-Special Exams Details";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        AcaSpecialSuppDetailsAudit: Record "Aca-Special/Supp Details Audit";
        AcaSpecialSuppDetailsAudit2: Record "Aca-Special/Supp Details Audit";
        CountedEntries: Integer;
        ACASemesters: Record "ACA-Semesters";
        ACACourseRegistration: Record "ACA-Course Registration";

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