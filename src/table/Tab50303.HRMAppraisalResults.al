table 50303 "HRM-Appraisal Results"
{

    fields
    {
        field(1; "Appraisal Job Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Jobs".Code;
        }
        field(3; "Appraisal Target"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HRM-Appraisal Targets".Code;
        }
        field(4; "Appraisal Period Code"; Code[50])
        {
            NotBlank = true;
            ///TableRelation = "HRM-Appraisal Periods";
        }
        field(5; Score; Decimal)
        {
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            begin
                // update trans_Reg
                Course_Reg.Reset;
                Course_Reg.SetRange(Course_Reg."PF No.", Rec."PF No.");
                Course_Reg.SetRange(Course_Reg."Appraisal Job Code", Rec."Appraisal Job Code");
                Course_Reg.SetRange(Course_Reg."Appraisal Period Code", Rec."Appraisal Period Code");
                Course_Reg.SetRange(Course_Reg."Appraisal Year Code", Rec."Appraisal Year Code");
                if Course_Reg.Find('-') then begin
                    //SETCURRENTKEY("PF No.",Programme,Stage,Unit,Semester,ExamType,"Reg. Transaction ID","Entry No");
                    //  RENAME("PF No.",Programme,Stage,Unit,Semester,ExamType,Course_Reg."Reg. Transacton ID","Entry No");

                    //EmployeeApprTargers.reset;
                    //EmployeeApprTargers.setrange();

                end;
                prog.Reset;
                prog.SetRange(Code, "Appraisal Job Code");
                if not prog.Find('-') then Error('Invalid Job Position!');
                if prog."Appraisal Category" = '' then Error('Appraisal category is missing on the program!');
                SExams.Reset;
                SExams.SetRange(SExams.Code, ExamType);
                SExams.SetRange(Category, prog."Appraisal Category");
                if SExams.Find('-') then begin
                    if Score > SExams."Max. Score" then
                        Error('Score can not be greater than the maximum score.');
                    if Score > 0 then begin
                        Percentage := (Score / SExams."Max. Score") * 100;
                        Contribution := Percentage * (SExams."% Contrib. Final Score" / 100);
                        //Gradings.Reset;
                        prog.Reset;
                        if prog.Get("Appraisal Job Code") then
                            if prog."Appraisal Category" = '' then
                                // Gradings.SetRange(Gradings.Category,'DEFAULT')
                                // else Gradings.SetRange(Gradings.Category,prog."Appraisal Category");
                                //Gradings.SetFilter("Lower Limit",'=%1|<%2',Score,Score);
                                // Gradings.SetFilter("Upper Limit",'=%1|>%2',Score,Score);
                                LastGrade := '';
                        LastScore := 0;
                        // if Gradings.Find('-') then begin
                        // Grade:=Gradings.Grade;
                        //  end;

                    end else begin
                        Percentage := 0;
                        Contribution := 0;
                        Grade := '';
                    end;

                end;


                Course_Reg.Reset;
                Course_Reg.SetRange(Course_Reg."PF No.", "PF No.");
                Course_Reg.SetRange(Course_Reg."Appraisal Job Code", "Appraisal Job Code");
                Course_Reg.SetRange(Course_Reg."Appraisal Period Code", "Appraisal Period Code");
                Course_Reg.SetRange(Course_Reg."Appraisal Year Code", "Appraisal Year Code");
                if Course_Reg.Find('-') then begin

                    EmployeeApprTargers.Reset;
                    EmployeeApprTargers.SetRange(EmployeeApprTargers."Appraisal Job Code", Course_Reg."Appraisal Job Code");
                    EmployeeApprTargers.SetRange(EmployeeApprTargers."Appraisal Target Code", Rec."Appraisal Target");
                    EmployeeApprTargers.SetRange(EmployeeApprTargers."Appraisal Period Code", "Appraisal Period Code");
                    EmployeeApprTargers.SetRange(EmployeeApprTargers."PF. No.", "PF No.");
                    if EmployeeApprTargers.Find('-') then begin
                        EmployeeApprTargers.CalcFields(EmployeeApprTargers."Total Score", EmployeeApprTargers."Individual Target");
                        EmployeeApprTargers."Final Score" := EmployeeApprTargers."Total Score";
                        EmployeeApprTargers."Total Marks" := EmployeeApprTargers."Total Score";
                        //  EmployeeApprTargers.Grade:=GetGrade(EmployeeApprTargers."Mid-Year Marks",0,EmployeeApprTargers."End-Year Marks",Course_Reg."Appraisal Job Code");
                        /*  IF (GetGrade(EmployeeApprTargers."Mid-Year Marks",0,EmployeeApprTargers."End-Year Marks",Course_Reg."Appraisal Job Code"))='E' THEN
                            EmployeeApprTargers."Consolidated Mark Pref.":='^';
                         */
                        ACAUnitsSubjects.Reset;
                        ACAUnitsSubjects.SetRange("Appraisal Job Code", "Appraisal Job Code");
                        ACAUnitsSubjects.SetRange(Code, "Appraisal Target");
                        if ACAUnitsSubjects.Find('-') then begin
                        end;
                        // EmployeeApprTargers."Old Unit":=GetGrade(EmployeeApprTargers."CAT-1",EmployeeApprTargers."CAT-2",EmployeeApprTargers."EXAMs Marks",Course_Reg.Programme);
                        // EmployeeApprTargers."Academic Year":="Academic Year";
                        EmployeeApprTargers.Modify;

                    end else begin
                        AppraisalRegi2.Reset;
                        AppraisalRegi2.SetRange(AppraisalRegi2."PF No.", "PF No.");
                        AppraisalRegi2.SetRange(AppraisalRegi2."Appraisal Job Code", "Appraisal Job Code");
                        AppraisalRegi2.SetRange(AppraisalRegi2."Appraisal Period Code", "Appraisal Period Code");
                        if AppraisalRegi2.Find('-') then begin
                            EmployeeApprTargers.Init;
                            EmployeeApprTargers."Reg. Transacton ID" := AppraisalRegi2."Reg. Transacton ID";
                            EmployeeApprTargers."Appraisal Job Code" := "Appraisal Job Code";
                            EmployeeApprTargers."Appraisal Target Code" := "Appraisal Target";
                            EmployeeApprTargers."Appraisal Period Code" := "Appraisal Period Code";
                            EmployeeApprTargers."PF. No." := "PF No.";
                            EmployeeApprTargers."Appraisal year Code" := "Appraisal Year Code";
                            EmployeeApprTargers.Insert;

                            EmployeeApprTargers.Reset;
                            EmployeeApprTargers.SetRange(EmployeeApprTargers."Appraisal Job Code", Course_Reg."Appraisal Job Code");
                            EmployeeApprTargers.SetRange(EmployeeApprTargers."Appraisal Target Code", "Appraisal Target");
                            EmployeeApprTargers.SetRange(EmployeeApprTargers."Appraisal Period Code", "Appraisal Period Code");
                            EmployeeApprTargers.SetRange(EmployeeApprTargers."PF. No.", "PF No.");
                            if EmployeeApprTargers.Find('-') then begin
                                ///  EmployeeApprTargers.CALCFIELDS(EmployeeApprTargers."Total Score",EmployeeApprTargers."Mid-Year Marks",EmployeeApprTargers."Mid-Year Total Marks",EmployeeApprTargers."End-Year  Marks",EmployeeApprTargers."End Year Marks Exists",
                                //  EmployeeApprTargers."Mid-Year Marks Exists");
                                /* EmployeeApprTargers."End-Year  Marks":=EmployeeApprTargers."Total Score";
                                 EmployeeApprTargers."Total Marks":=EmployeeApprTargers."Total Score";
                                 EmployeeApprTargers.Grade:=GetGrade(EmployeeApprTargers."Mid-Year Marks",0,EmployeeApprTargers."End-Year  Marks",Course_Reg."Appraisal Job Code");
                                 IF EmployeeApprTargers.Grade='E' THEN
                                   EmployeeApprTargers."Consolidated Mark Pref.":='^';

                                   ACAUnitsSubjects.RESET;
                                   ACAUnitsSubjects.SETRANGE("Appraisal Job Code","Appraisal Job Code");
                                   ACAUnitsSubjects.SETRANGE(Code,"Appraisal Target");
                                   IF ACAUnitsSubjects.FIND('-') THEN BEGIN

                                     END;*/
                                EmployeeApprTargers."Appraisal year Code" := "Appraisal Year Code";
                                EmployeeApprTargers.Modify;

                            end;
                        end;

                    end;

                end;

            end;
        }
        field(6; Exam; Code[50])
        {
        }
        field(7; "Reg. Transaction ID"; Code[50])
        {
        }
        field(8; "PF No."; Code[30])
        {
            Editable = true;
            TableRelation = Customer."No.";
        }
        field(9; Grade; Code[50])
        {
            TableRelation = "HRM-Appraisal Grading".Grade;
        }
        field(10; Percentage; Decimal)
        {
        }
        field(11; Contribution; Decimal)
        {
            Editable = false;
        }
        field(18; "Appraisal Category"; Code[50])
        {
        }
        field(19; ExamType; Code[50])
        {
        }
        field(20; "Admission No"; Code[50])
        {
        }
        field(21; SN; Boolean)
        {
        }
        field(22; Reported; Boolean)
        {
        }
        field(23; "Lecturer Names"; Text[250])
        {
        }
        field(24; UserID; Code[50])
        {
        }
        field(50001; "Original Score"; Decimal)
        {
        }
        field(50002; "Last Edited By"; Code[50])
        {
        }
        field(50003; "Last Edited On"; Date)
        {
        }
        field(50004; Submitted; Boolean)
        {
        }
        field(50005; "Submitted On"; Date)
        {
        }
        field(50006; "Submitted By"; Code[50])
        {
        }
        field(50007; Category; Code[50])
        {
        }
        field(50008; Department; Code[50])
        {
        }
        field(50009; "Original Contribution"; Decimal)
        {
        }
        field(50018; "Appraisal Year Code"; Code[50])
        {
            TableRelation = "HRM-Appraisal Years".Code;
        }
        field(50022; "User Name"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Reg. Transaction ID")
        {
            SumIndexFields = Score, Contribution;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //  ERROR('Please note that modification of results is not allowed');
    end;

    trigger OnModify()
    begin
        // ERROR('Please note that modification of results is not allowed');
    end;

    var
        SExams: Record "HRM-Appraisal Res. Setup";
        //Gradings: Record "ACA-Exam Gradding Setup";
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        //Gradings2: Record "ACA-Exam Gradding Setup";
        EResults: Record "HRM-Appraisal Results";
        Exams: Record "HRM-Appraisal Res. Setup";
        Course_Reg: Record "HRM-Appraisal Registration";
        EmployeeApprTargers: Record "HRM-Appraisal Emp. Targets";
        prog: Record "HRM-Appraisal Jobs";
        EResults2: Record "HRM-Appraisal Results";
        AppraisalRegi2: Record "HRM-Appraisal Registration";
        ACAUnitsSubjects: Record "HRM-Appraisal Targets";

    procedure GetGrade(CAT1: Decimal; CAT2: Decimal; FinalM: Decimal; prog: Code[100]) xGrade: Text[100]
    var
        UnitsRR: Record "HRM-Appraisal Targets";
        ProgrammeRec: Record "HRM-Appraisal Jobs";
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        //Gradings: Record "ACA-Exam Gradding Setup";
        //Gradings2: Record "ACA-Exam Gradding Setup";
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        Grd: Code[80];
        Grade: Code[20];
        GradeCategory: Code[50];
        Marks: Decimal;
    begin
        //     GradeCategory:='';
        //     Clear(Marks);
        //     ProgrammeRec.Reset;
        //     if ProgrammeRec.Get(prog) then
        //     GradeCategory:=ProgrammeRec."Appraisal Category";
        //     if GradeCategory='' then Error('Please note that you must specify Appraisal Category in Appraisal Job Setup');
        //     xGrade:='';
        //     if CAT1+CAT2+FinalM > 0 then begin
        //     Marks:=CAT1+CAT2+FinalM;
        //     //Gradings.Reset;
        //     //Gradings.SetRange(Gradings.Category,GradeCategory);
        //     LastGrade:='';
        //     LastRemark:='';
        //     LastScore:=0;
        //     //if Gradings.Find('-') then begin
        //     ExitDo:=false;
        //     repeat
        //    // LastScore:=Gradings."Up to";
        //     if Marks < LastScore then begin
        //     if ExitDo = false then begin
        //    // xGrade:=Gradings.Grade;
        //    // if Gradings.Failed=false then
        //     LastRemark:='PASS'
        //     //else
        //     //LastRemark:='FAIL';
        //     //ExitDo:=true;
        //     end;
        //     end;

        //     until 
        //     Gradings.Next = 0;


        //     end;

        //    // end else begin
        //    // Grade:='';
        //     end;
    end;
}

