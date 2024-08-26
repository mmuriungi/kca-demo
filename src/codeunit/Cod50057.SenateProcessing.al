codeunit 50057 "Senate Processing"
{
    var
        creg: Record "ACA-Course Registration";
        studunits: Record "ACA-Student Units";
        unitsNo: Decimal;
        unitsTotal: Decimal;
        senateTab: Record "Senate Report New";
        gradSys: Record "ACA-Exam Gradding Setup";
        avgMark: Decimal;
        prog: Record "ACA-Programme";
        examCategory: Text;
        grade, examCatg : text;
        passStatus: Code[20];
        cust: Record Customer;
        studName: Text;
        suppExamReg: Record "Aca-Special Exams Details";
        unitsSub: Record "ACA-Units/Subjects";
        fail: List of [Text];
        deffered: Record defferedStudents;

    procedure processResults(progz: Code[20]; Semester: code[20])
    begin
        prog.Reset();
        prog.SetRange(Code, progz);
        if prog.Find('-') then begin
            examCategory := prog."Exam Category";
            unitsSub.Reset();
            unitsSub.SetRange("Programme Code", progz);
            if unitsSub.Find('-') then begin
                repeat
                    if unitsSub."Default Exam Category" = '' then begin
                        unitsSub."Default Exam Category" := examCategory;
                        unitsSub.Modify();
                    end;
                until unitsSub.Next() = 0;
            end;
        end;
        //ABSCONDED
        cust.Reset();
        cust.SetRange(Status, cust.Status::Registration);
        cust.SetRange("Customer Type", cust."Customer Type"::Student);
        if cust.Find('-') then begin
            repeat
                creg.Reset();
                creg.SetRange(Semester, Semester);
                creg.SetRange("Student No.", cust."No.");
                if not creg.Find('-') then begin
                    senateTab.Init();
                    senateTab."Student No." := cust."No.";
                    senateTab.Semester := Semester;
                    senateTab."Student Name" := cust.Name;
                    //senateTab.Average := avgMark;
                    //senateTab.Grade := grade;
                    senateTab.Status := 'ABSCONDED';
                    //senateTab.Programme := creg.Programmes;
                    //senateTab.Stage := creg.Stage;
                    //senateTab."Year of Study" := creg."Year Of Study";
                    senateTab.Insert();
                end;
            until cust.Next() = 0;
        end;
        //ACADEMIC LEAVE
        cust.Reset();
        cust.SetRange(Status, cust.Status::Registration);
        if cust.Find('-') then begin
            repeat
                deffered.Reset();
                deffered.SetRange(studentNo, cust."No.");
                if deffered.Find('-') then begin
                    senateTab.Init();
                    senateTab."Student No." := cust."No.";
                    senateTab.Semester := Semester;
                    senateTab."Student Name" := cust.Name;
                    //senateTab.Average := avgMark;
                    //senateTab.Grade := grade;
                    senateTab.Status := 'ACADEMIC LEAVE';
                    //senateTab.Programme := creg.Programmes;
                    //senateTab.Stage := creg.Stage;
                    //senateTab."Year of Study" := creg."Year Of Study";
                    senateTab.Insert();
                end;
            until cust.Next() = 0;
        end;
        //DESEACED
        cust.Reset();
        cust.SetRange(Status, cust.Status::Deceased);
        if cust.Find('-') then begin
            repeat
                senateTab.Init();
                senateTab."Student No." := cust."No.";
                //senateTab.Semester := creg.Semester;
                senateTab."Student Name" := cust.Name;
                //senateTab.Average := avgMark;
                //senateTab.Grade := grade;
                senateTab.Status := 'DESCEASED';
                //senateTab.Programme := creg.Programmes;
                //senateTab.Stage := creg.Stage;
                //senateTab."Year of Study" := creg."Year Of Study";
                senateTab.Insert();
            until cust.Next() = 0;
        end;
        creg.Reset();
        creg.SetRange(Semester, Semester);
        creg.SetRange(Programmes, progz);
        creg.SetRange(Reversed, false);
        if creg.Find('-') then begin
            //clear existing records
            senateTab.Reset();
            senateTab.SetRange(Semester, Semester);
            senateTab.SetRange(Status, Semester);
            IF senateTab.Find('-') then begin
                senateTab.DeleteAll();
            end;
            repeat
                Clear(unitsNo);
                Clear(avgMark);
                Clear(unitsTotal);
                Clear(examCategory);
                Clear(studName);
                creg.CalcFields("Units Taken");
                if creg."Units Taken" > 0 then begin
                    prog.Reset();
                    prog.SetRange(Code, creg.Programmes);
                    if prog.Find('-') then begin
                        examCategory := prog."Exam Category";
                    end;
                    studunits.Reset();
                    studunits.SetRange(Semester, creg.Semester);
                    studunits.SetRange(Programme, creg.Programmes);
                    studunits.SetRange("Student No.", creg."Student No.");
                    if studunits.Find('-') then begin
                        unitsNo := studunits.Count();
                        repeat
                            studunits.CalcFields("Total Score");
                            studunits.CalcFields("EXAMs Marks Exists");
                            unitsTotal := unitsTotal + studunits."Total Score";
                            gradSys.Reset();
                            gradSys.SetRange(Category, examCategory);
                            gradSys.SetFilter("Lower Limit", '<=%1', studunits."Total Score");
                            gradSys.SetFilter("Upper Limit", '>=%1', studunits."Total Score");
                            if gradSys.FindFirst() then begin
                                grade := gradSys.Grade;
                                if gradSys.Failed = true then
                                    passStatus := 'FAIL'
                                else
                                    passStatus := 'PASS';
                            end;
                            if (studunits."EXAMs Marks Exists" = false) then
                                studunits.Remarks := 'RETAKE ONE'
                            else
                                studunits.Remarks := passStatus;
                            studunits.Modify();
                        until studunits.Next() = 0;
                        avgMark := (unitsTotal / unitsNo);
                    end;
                    studunits.Reset();
                    studunits.SetRange(Semester, creg.Semester);
                    studunits.SetRange(Programme, creg.Programmes);
                    studunits.SetRange("Student No.", creg."Student No.");
                    studunits.SetRange(Remarks, 'FAIL');
                    if studunits.Find('-') then begin
                        cust.Reset();
                        cust.SetRange("No.", creg."Student No.");
                        if cust.Find('-') then begin
                            // studName := cust."First Name" + ' ' + cust."Middle Name" + ' ' + cust."Last Name";
                            studName := cust.Name;
                        end;
                        senateTab.Init();
                        senateTab."Student No." := creg."Student No.";
                        senateTab.Semester := creg.Semester;
                        senateTab."Student Name" := studName;
                        senateTab.Average := avgMark;
                        senateTab.Grade := grade;
                        senateTab.Status := 'FAIL';
                        senateTab.Programme := creg.Programmes;
                        senateTab.Stage := creg.Stage;
                        senateTab."Year of Study" := creg."Year Of Study";
                        senateTab.Insert();
                    end ELSE begin
                        studunits.Reset();
                        studunits.SetRange(Semester, creg.Semester);
                        studunits.SetRange(Programme, creg.Programmes);
                        studunits.SetRange("Student No.", creg."Student No.");
                        studunits.SetRange(Remarks, 'RETAKE ONE');
                        if studunits.Find('-') then begin
                            cust.Reset();
                            cust.SetRange("No.", creg."Student No.");
                            if cust.Find('-') then begin
                                // studName := cust."First Name" + ' ' + cust."Middle Name" + ' ' + cust."Last Name";
                                studName := cust.Name;
                            end;
                            senateTab.Init();
                            senateTab."Student No." := creg."Student No.";
                            senateTab.Semester := creg.Semester;
                            senateTab."Student Name" := studName;
                            senateTab.Average := avgMark;
                            senateTab.Grade := grade;
                            senateTab.Status := 'RETAKE ONE';
                            senateTab.Programme := creg.Programmes;
                            senateTab.Stage := creg.Stage;
                            senateTab."Year of Study" := creg."Year Of Study";
                            senateTab.Insert();
                        end

                        //if studunits.Remarks = 'RETAKE ONE' then begin

                        //end
                        else begin
                            cust.Reset();
                            cust.SetRange("No.", creg."Student No.");
                            if cust.Find('-') then begin
                                // studName := cust."First Name" + ' ' + cust."Middle Name" + ' ' + cust."Last Name";
                                studName := cust.Name;
                            end;
                            senateTab.Init();
                            senateTab."Student No." := creg."Student No.";
                            senateTab.Semester := creg.Semester;
                            senateTab."Student Name" := studName;
                            senateTab.Average := avgMark;
                            senateTab.Grade := grade;
                            senateTab.Status := 'PASS';
                            senateTab.Programme := creg.Programmes;
                            senateTab.Stage := creg.Stage;
                            senateTab."Year of Study" := creg."Year Of Study";
                            senateTab.Insert();
                        end;

                    end;
                end;
            until creg.Next() = 0;
        end;
        //process supps
        creg.Reset();
        creg.SetRange(Semester, Semester);
        creg.SetRange(Programmes, progz);
        creg.SetRange(Reversed, false);
        if creg.Find('-') then begin
            //clear existing records first
            suppExamReg.Reset();
            suppExamReg.SetRange(Programme, progz);
            suppExamReg.SetRange(Semester, Semester);
            if suppExamReg.Find('-') then begin
                suppExamReg.DeleteAll();
            end;
            repeat
                studunits.Reset();
                studunits.SetRange(Semester, creg.Semester);
                studunits.SetRange(Programme, creg.Programmes);
                studunits.SetRange("Student No.", creg."Student No.");
                studunits.SetRange(Stage, creg.Stage);
                if studunits.Find('-') then begin
                    unitsSub.Reset();
                    unitsSub.SetRange(Code, studunits.Unit);
                    if unitsSub.Find('-') then begin
                        examCategory := unitsSub."Default Exam Category";
                    end;
                    repeat
                        studunits.CalcFields("Total Score");
                        studunits.CalcFields("EXAMs Marks Exists");
                        studunits.CalcFields("CATs Marks Exists");
                        gradSys.Reset();
                        gradSys.SetRange(Category, examCategory);
                        gradSys.SetFilter("Lower Limit", '<=%1', studunits."Total Score");
                        gradSys.SetFilter("Upper Limit", '>=%1', studunits."Total Score");
                        if gradSys.FindFirst() then begin
                            if gradSys.Failed = true then begin
                                if (studunits."EXAMs Marks Exists" = false) or (studunits."Total Score" = 0) then begin
                                    suppExamReg.Init();
                                    suppExamReg."Unit Code" := studunits.Unit;
                                    suppExamReg."Academic Year" := creg."Academic Year";
                                    suppExamReg.Semester := creg.Semester;
                                    suppExamReg."Student No." := studunits."Student No.";
                                    suppExamReg.Stage := creg.Stage;
                                    suppExamReg.Programme := studunits.Programme;
                                    suppExamReg.Catogory := suppExamReg.Catogory::Resit;
                                    suppExamReg.Insert();
                                end else begin
                                    suppExamReg.Init();
                                    suppExamReg."Unit Code" := studunits.Unit;
                                    suppExamReg."Academic Year" := creg."Academic Year";
                                    suppExamReg.Semester := creg.Semester;
                                    suppExamReg."Student No." := studunits."Student No.";
                                    suppExamReg.Stage := creg.Stage;
                                    suppExamReg.Programme := studunits.Programme;
                                    suppExamReg.Catogory := suppExamReg.Catogory::Supplementary;
                                    suppExamReg.Insert();
                                end;


                            end;
                        end;

                    until studunits.next = 0;

                end;
            until creg.Next() = 0;
        end;
    end;
}
