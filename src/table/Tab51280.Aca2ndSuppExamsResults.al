table 51280 "Aca-2nd Supp. Exams Results"
{
    Caption = 'Aca-2nd Supp. Exams Results';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Programme; Code[20])
        {
            Caption = 'Programme';
        }
        field(2; Stage; Code[50])
        {
            Caption = 'Stage';
        }
        field(3; Unit; Code[50])
        {
            Caption = 'Unit';
        }
        field(4; Semester; Code[50])
        {
            Caption = 'Semester';
        }
        field(5; Score; Decimal)
        {
            Caption = 'Score';
            trigger onvalidate()
            begin
                IF Rec.Score < 0 THEN ERROR('Invalid score!');
                // update trans_Reg
                stud_Units.RESET;
                stud_Units.SETRANGE("Student No.", Rec."Student No.");
                stud_Units.SETRANGE(Unit, Rec.Unit);
                stud_Units.SETRANGE("Reg Reversed", FALSE);
                IF stud_Units.FIND('-') THEN BEGIN
                    Course_Reg.RESET;
                    Course_Reg.SETRANGE(Course_Reg."Student No.", stud_Units."Student No.");
                    Course_Reg.SETRANGE(Course_Reg.Programmes, stud_Units.Programme);
                    Course_Reg.SETRANGE(Course_Reg.Semester, stud_Units.Semester);
                    //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                    Course_Reg.SETRANGE(Course_Reg.Stage, stud_Units.Stage);
                    IF Course_Reg.FIND('-') THEN BEGIN

                    END;
                END;

                prog.RESET;
                prog.SETRANGE(Code, Programme);
                IF NOT prog.FIND('-') THEN ERROR('Invalid Program!');
                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, Rec.Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", Rec.Programme);
                IF ACAUnitsSubjects.FIND('-') THEN BEGIN
                END;

                IF prog."Exam Category" = '' THEN
                    IF ACAUnitsSubjects."Default Exam Category" = '' THEN ERROR('Exam category is missing on the program!');
                SExams.RESET;
                SExams.SETFILTER(SExams.Code, 'EXAM|FINAL EXAM');
                IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                    SExams.SETRANGE(Category, ACAUnitsSubjects."Default Exam Category")
                ELSE
                    SExams.SETRANGE(Category, prog."Exam Category");
                IF SExams.FIND('-') THEN BEGIN

                    IF Score > SExams."Max. Score" THEN
                        ERROR('Score can not be greater than the maximum score.');
                    IF Score > 0 THEN BEGIN
                        Percentage := (Score / SExams."Max. Score") * 100;
                        //Contribution:=Percentage*(SExams."% Contrib. Final Score"/100);
                        Contributions := Score;
                        Gradings.RESET;
                        prog.RESET;
                        IF prog.GET(Programme) THEN;
                        ACAExamCategory.RESET;
                        ACAExamCategory.SETRANGE(Code, prog."Exam Category");
                        IF ACAExamCategory.FIND('-') THEN;
                        IF prog."Exam Category" = '' THEN BEGIN
                            IF ACAUnitsSubjects."Default Exam Category" = '' THEN
                                Gradings.SETRANGE(Gradings.Category, 'DEFAULT') ELSE
                                Gradings.SETRANGE(Gradings.Category, ACAUnitsSubjects."Default Exam Category");
                        END
                        ELSE BEGIN
                            IF ACAUnitsSubjects."Default Exam Category" <> '' THEN
                                Gradings.SETRANGE(Gradings.Category, ACAUnitsSubjects."Default Exam Category") ELSE
                                Gradings.SETRANGE(Gradings.Category, prog."Exam Category");
                        END;
                        Gradings.SETFILTER("Lower Limit", '=%1|<%2', Score, Score);
                        Gradings.SETFILTER("Upper Limit", '=%1|>%2', Score, Score);
                        LastGrade := '';
                        LastScore := 0;
                        IF Gradings.FIND('-') THEN BEGIN
                            Grade := Gradings.Grade;

                        END;


                    END ELSE BEGIN
                        Percentage := 0;
                        Contributions := 0;
                        Grade := '';
                    END;

                END;

                // 
                // Course_Reg.RESET;
                // Course_Reg.SETRANGE(Course_Reg."Student No.",stud_Units."Student No.");
                // Course_Reg.SETRANGE(Course_Reg.Programme,stud_Units.Programme);
                // Course_Reg.SETRANGE(Course_Reg.Semester,stud_Units.Semester);
                // //Course_Reg.SETRANGE(Course_Reg."Academic Year","Academic Year");
                // Course_Reg.SETRANGE(Course_Reg.Stage,stud_Units.Stage);
                // IF Course_Reg.FIND('-') THEN BEGIN

                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Student No.", Rec."Student No.");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Current Academic Year", Rec."Current Academic Year");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Unit Code", Rec.Unit);
                //AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails.Semester,Semester);
                //AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Student No.","Student No.");
                IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                    stud_Units.CALCFIELDS(stud_Units."CATs Marks");
                    IF AcaSpecialExamsDetails.Category = AcaSpecialExamsDetails.Category::Special THEN BEGIN
                        AcaSpecialExamsDetails."CAT Marks" := stud_Units."CATs Marks";
                        AcaSpecialExamsDetails."Exam Marks" := Contributions;
                        AcaSpecialExamsDetails."Total Marks" := Contributions + stud_Units."CATs Marks";
                        AcaSpecialExamsDetails.Grade := GetGrade(0, stud_Units."CATs Marks", Contributions, Rec.Programme);
                        // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                        // stud_Units."Academic Year":="Academic Year";
                        AcaSpecialExamsDetails.MODIFY;
                    END ELSE IF AcaSpecialExamsDetails.Category = AcaSpecialExamsDetails.Category::Supplementary THEN BEGIN
                        AcaSpecialExamsDetails."CAT Marks" := stud_Units."CATs Marks";
                        IF ACAExamCategory."Supplementary Max. Score" <> 0 THEN BEGIN
                            IF ((Contributions > ACAExamCategory."Supplementary Max. Score") OR (Contributions = ACAExamCategory."Supplementary Max. Score")) THEN BEGIN
                                AcaSpecialExamsDetails."Total Marks" := ACAExamCategory."Supplementary Max. Score";
                            END ELSE BEGIN
                                AcaSpecialExamsDetails."Total Marks" := Contributions;//;
                            END;
                        END ELSE BEGIN
                            AcaSpecialExamsDetails."Total Marks" := Contributions;
                        END;
                        // // //      IF prog."Exam Category"='NURSING' THEN BEGIN
                        // // //      IF ((Contribution>50) OR (Contribution=50)) THEN BEGIN 
                        // // //  AcaSpecialExamsDetails."Total Marks":= 50;
                        // // //        END ELSE BEGIN 
                        // // //  AcaSpecialExamsDetails."Total Marks":= Contribution;//;
                        // // //      END;
                        // // //       END  ELSE BEGIN
                        // // //      IF ((Contribution>40) OR (Contribution=40)) THEN BEGIN 
                        // // //  AcaSpecialExamsDetails."Total Marks":= 40;
                        // // //        END ELSE BEGIN 
                        // // //  AcaSpecialExamsDetails."Total Marks":= Contribution;//;
                        // // //      END;
                        // // //      END;
                        //AcaSpecialExamsDetails."Exam Marks":=AcaSpecialExamsDetails."Total Marks"-AcaSpecialExamsDetails."CAT Marks";//Contribution;
                        // AcaSpecialExamsDetails.Grade:=GetGrade(0,0,AcaSpecialExamsDetails."Total Marks",Rec.Programme);
                        // stud_Units."Old Unit":=GetGrade(stud_Units."CAT-1",stud_Units."CAT-2",stud_Units."EXAMs Marks",Course_Reg.Programme);
                        // stud_Units."Academic Year":="Academic Year";
                        AcaSpecialExamsDetails.MODIFY;
                    END;

                    // END;
                END;
                ////////////////////////////// Update Special Exam Tables

                AcaSpecialExamsDetails.RESET;
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Student No.", Rec."Student No.");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Current Academic Year", Rec."Current Academic Year");
                AcaSpecialExamsDetails.SETRANGE(AcaSpecialExamsDetails."Unit Code", Rec.Unit);
                IF AcaSpecialExamsDetails.FIND('-') THEN BEGIN
                    Course_Reg2.RESET;
                    Course_Reg2.SETRANGE(Course_Reg2."Student No.", "Student No.");
                    Course_Reg2.SETRANGE(Course_Reg2.Programmes, Programme);
                    Course_Reg2.SETRANGE(Course_Reg2.Semester, Semester);
                    Course_Reg2.SETRANGE(Course_Reg2.Stage, Stage);
                    IF Course_Reg2.FIND('-') THEN BEGIN

                        stud_Units2.RESET;
                        stud_Units2.SETRANGE(stud_Units2.Programme, stud_Units.Programme);
                        stud_Units2.SETRANGE(stud_Units2.Stage, stud_Units.Stage);
                        stud_Units2.SETRANGE(stud_Units2.Unit, stud_Units.Unit);
                        stud_Units2.SETRANGE(stud_Units2.Semester, stud_Units.Semester);
                        stud_Units2.SETRANGE(stud_Units2."Student No.", stud_Units."Student No.");
                        stud_Units2.SETRANGE(stud_Units2.Reversed, FALSE);
                        IF stud_Units2.FIND('-') THEN BEGIN
                            stud_Units2."Supp. Exam Marks" := Contributions;
                            stud_Units2."Supp. Academic Year" := AcaSpecialExamsDetails."Current Academic Year";
                            stud_Units2."Supp. Exam Score" := Contributions;
                            stud_Units2."Supp. Final Score" := AcaSpecialExamsDetails."Total Marks";
                            stud_Units2."Supp. Total Score" := AcaSpecialExamsDetails."Total Marks";
                            stud_Units2."Supp. Total Marks" := AcaSpecialExamsDetails."Total Marks";
                            stud_Units2."Supp. Grade" := GetGrade(0, 0, AcaSpecialExamsDetails."Total Marks", AcaSpecialExamsDetails.Programme);
                            stud_Units2.MODIFY;
                        END;

                    END;
                END;

            end;
        }
        field(6; Exam; Code[50])
        {
            Caption = 'Exam';
        }
        field(7; "Reg. Transaction ID"; Code[50])
        {
            Caption = 'Reg. Transaction ID';
        }
        field(8; "Student No."; Code[30])
        {
            Caption = 'Student No.';
        }
        field(9; Grade; Code[50])
        {
            Caption = 'Grade';
        }
        field(10; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }
        field(11; Contributions; Decimal)
        {
            Caption = 'Contributions';
        }
        field(18; "Exam Category"; Code[50])
        {
            Caption = 'Exam Category';
        }
        field(19; ExamType; Code[50])
        {
            Caption = 'Exam Type';
        }
        field(20; "Admission No"; Code[50])
        {
            Caption = 'Admission No';
        }
        field(22; Reported; Boolean)
        {
            Caption = 'Reported';
        }
        field(23; "Lecturer Names"; Text[250])
        {
            Caption = 'Lecturer Names';
        }
        field(24; UserID; Code[50])
        {
            Caption = 'User ID';
        }
        field(50018; "Academic Year"; Code[50])
        {
            Caption = 'Academic Year';
        }
        field(50019; "Exam Session"; Code[10])
        {
            Caption = 'Exam Session';
        }
        field(50020; Category; Option)
        {
            Caption = 'Category';
            OptionMembers = " ",Special,Supplementary;
        }
        field(50021; "Current Academic Year"; Code[20])
        {
            Caption = 'Current Academic Year';
        }
        field(50022; "Capture Date"; Date)
        {
            Caption = 'Capture Date';
        }
        field(50023; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
        }
        field(50024; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
        }
        field(50025; "Modified By Name"; Text[250])
        {
            Caption = 'Modified By Name';
        }
    }

    keys
    {
        key(PK; Programme, Stage, Unit, Semester, "Student No.", "Academic Year")
        {
            Clustered = true;
        }
    }

    var
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
        ACAExamCategory: Record "ACA-Exam Category";
        AcaSpecialExamsDetails: Record "Aca-2nd Supp. Exams Details";


    procedure GetGrade(CAT1: Decimal; CAT2: Decimal; FinalM: Decimal; progz: Code[100]) xGrade: Code[20]
    var
        UnitsRR: Record "ACA-Units/Subjects";
        ProgrammeRec: Record "ACA-Programme";
        LastRemark: Code[20];
        GLabel: Code[20];
        i: Integer;
        GLabel2: Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        GradeCategory: Code[50];
        Marks: Decimal;
    begin
        GradeCategory := '';
        Clear(Marks);
        Gradings.Reset();
        Marks := CAT1 + CAT2 + FinalM;
        ProgrammeRec.Reset();
        if ProgrammeRec.Get(progz) then
            GradeCategory := ProgrammeRec."Exam Category";
        if GradeCategory = '' then
            GradeCategory := 'DEFAULT';
        xGrade := '';
        if Marks > 0 then begin
            if GradeCategory = '' then
                Gradings.SetRange(Gradings.Category, 'DEFAULT')
            else
                Gradings.SetRange(Gradings.Category, ProgrammeRec."Exam Category");
            Gradings.SetFilter("Lower Limit", '=%1|<%2', Marks, Marks);
            Gradings.SetFilter("Upper Limit", '=%1|>%2', Marks, Marks);
            if Gradings.FindFirst() then begin
                xGrade := Gradings.Grade;
            end;
        end else begin
            xGrade := '';
        end;
    end;
}