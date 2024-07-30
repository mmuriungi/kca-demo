report 52169 "Senate Report(NEW)"
{
    //Caption = 'Senate Report(NEW)';
    RDLCLayout = './Layouts/senateReport(New)2.rdl';
    dataset
    {
        dataitem(Senate; "Senate Report New")
        {
            RequestFilterFields = Semester, Programme;
            DataItemTableView = sorting(order) order(Ascending);
            //PrintOnlyIfDetail = true;

            //DataItemTableView = where(Status = filter('Pass'));
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Average; Average)
            {

            }

            column(pic; CompInfo.Picture)
            {

            }
            column(name; CompInfo.Name)
            {

            }

            column(PassListCount; PassListCount)
            {

            }
            column(progName; progName)
            {

            }
            column(departName; departName)
            {

            }
            column(facultyName; facultyName)
            {

            }
            column(seq; seq)
            {

            }
            column(currSem; currSem)
            {

            }
            column(currAcad; currAcad)
            {

            }
            column(Status; Status)
            {

            }
            column(failList; failList)
            {

            }
            column(Stage; Stage)
            {

            }
            column(Grade; Grade)
            {

            }
            column(supCount; supCount)
            {

            }
            column(retakeCount; retakeCount)
            {

            }
            column(Programmez; Programme)
            {

            }
            column(order; order)
            {

            }
            column(SchoolTxt; SchoolTxt)
            {

            }
            column(StageTxt; StageTxt)
            {

            }
            column(ProgramTxt; ProgramTxt)
            {

            }
            column(Narration; Narration)
            {

            }
            column(PassCcountTxt; PassCcountTxt)
            {

            }
            column(FailcountTxt; FailcountTxt)
            {

            }
            column(RetakeOnecountTxt; RetakeOnecountTxt)
            {

            }
            column(AbscondedCountTxt; AbscondedCountTxt)
            {

            }
            column(SuppCountTxt; SuppCountTxt)
            {

            }
            column(specialCountTxt; specialCountTxt)
            {

            }
            column(YearTxt; YearTxt)
            {

            }
            column(SemesterTxt; SemesterTxt)
            {

            }
            column(DeanTxt; DeanTxt)
            {

            }
            column(VCtxt; VCtxt)
            {

            }
            trigger OnAfterGetRecord()
            begin
                ///Senate.Reset();
                //Senate.SetRange(Status, Senate.Status::Pass);
                ///if Senate.Find('-') then begin
                //seq := seq + 1;
                senateList.Reset();
                senateList.SetRange(Status, 'PASS');
                senateList.SetRange(Semester, Senate.Semester);
                senateList.SetRange(Programme, Senate.Programme);
                if senateList.Find('-') then begin
                    PassListCount := senateList.Count();
                end;
                senateList.Reset();
                senateList.SetRange(Status, 'FAIL');
                senateList.SetRange(Semester, Senate.Semester);
                senateList.SetRange(Programme, Senate.Programme);
                if senateList.Find('-') then begin
                    failList := senateList.Count();
                end;
                specialsup.Reset();
                specialsup.SetRange(Programme, Senate.Programme);
                specialsup.SetRange(Catogory, specialsup.Catogory::Supplementary);
                if specialsup.Find('-') then begin
                    Clear(uniqueStudNo);
                    repeat
                        // Check if the student number is already in the list
                        if not uniqueStudNo.Contains(specialsup."Student No.") then begin
                            // If not, add it to the list
                            uniqueStudNo.Add(specialsup."Student No.");
                        end;
                        supCount := uniqueStudNo.Count();
                    until specialsup.Next() = 0;
                end;
                specialsup.Reset();
                specialsup.SetRange(Programme, Senate.Programme);
                specialsup.SetRange(Catogory, specialsup.Catogory::Resit);
                if specialsup.Find('-') then begin
                    Clear(uniqueStudNo);
                    repeat
                        // Check if the student number is already in the list
                        if not uniqueStudNo.Contains(specialsup."Student No.") then begin
                            // If not, add it to the list
                            uniqueStudNo.Add(specialsup."Student No.");
                        end;
                        retakeCount := uniqueStudNo.Count();
                    until specialsup.Next() = 0;

                end;
                prog.Reset();
                prog.SetRange(Code, Senate.Programme);
                if prog.Find('-') then begin
                    progName := prog.Description;
                    departName := prog."Department Name";
                    facultyName := prog."Faculty Name";
                end;
                currSem := GetCurrentSemester();
                currAcad := GetCurrentYear();

                //studUnits.SetRange();
                Checkreport.InitTextVariable();
                Checkreport.FormatNoText(NumberTx, PassListCount, '');
                PassCcountTxt := NumberTx[1] + ' (' + Format(PassListCount) + ')';
                Clear(NumberTx);
                Clear(checkreport);
                Checkreport.InitTextVariable();
                Checkreport.FormatNoText(NumberTx, failList, '');
                FailcountTxt := NumberTx[1] + ' (' + Format(failList) + ')';
                Clear(NumberTx);
                Clear(checkreport);
                Checkreport.InitTextVariable();
                Checkreport.FormatNoText(NumberTx, retakeCount, '');
                RetakeOnecountTxt := NumberTx[1] + ' (' + Format(retakeCount) + ')';
                Clear(NumberTx);
                Clear(checkreport);
                Checkreport.InitTextVariable();
                Checkreport.FormatNoText(NumberTx, supCount, '');
                SuppCountTxt := NumberTx[1] + ' (' + Format(supCount) + ')';
                // Clear(NumberTx);
                // Clear(checkreport);
                // Checkreport.InitTextVariable();
                // Checkreport.FormatNoText(NumberTx, specialCount,'');
                // specialCountTxt:= NumberTx[1]+' ('+Format(specialCount)+')';
                // Clear(NumberTx);
                if not facultyName.Contains('School') then begin
                    SchoolTxt := 'School of ' + facultyName;
                end
                else begin
                    SchoolTxt := facultyName;
                end;
                getStageTxt(Senate.Stage, StageTxt);
                ProgramTxt := progName;

                setNaration(Senate.Status, Narration);
                GetDean(DeanTxt);
                GetVC(VCtxt);



            end;
        }
        dataitem("Aca-Special Exams Details"; "Aca-Special Exams Details")
        {
            //DataItemLink = Programme = field(Programme);
            RequestFilterFields = Programme;
            DataItemTableView = sorting(Stage);
            column(StudNo; "Student No.")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Unit_Code; "Unit Code")
            {

            }
            column(StageUnits; Stage)
            {

            }
            column(Programme; Programme)
            {

            }
            column(Catogory; Catogory)
            {

            }
            column(custName; custName)
            {

            }

            trigger OnAfterGetRecord()
            begin
                cust.Reset();
                cust.SetRange("No.", "Aca-Special Exams Details"."Student No.");
                if cust.Find('-') then begin
                    custName := cust.Name;
                end;

            end;
        }
    }

    trigger OnInitReport()
    begin

        if CompInfo.Get() then begin
            CompInfo.CalcFields(CompInfo.Picture);
        end;



    end;

    var
        studUnits: Record "ACA-Student Units";
        senateList: Record "Senate Report New";
        gender: Option;
        CompInfo: Record "Company Information";
        CurrentYr: Record "ACA-Academic Year";
        CurrentSem: Record "ACA-Semesters";
        currSem: Text;
        currAcad, custName : Text;
        seq, PassListCount, failList, supCount, retakeCount : Decimal;
        prog: Record "ACA-Programme";
        progName, departName, facultyName : text;
        cust: Record Customer;
        specialsup: Record "Aca-Special Exams Details";
        uniqueStudNo: List of [Text];
        Narration: text;
        PassCcountTxt: text;
        FailcountTxt: text;
        RetakeOnecountTxt: text;
        AbscondedCountTxt: text;
        SuppCountTxt: text;
        specialCountTxt: text;
        SchoolTxt: text;
        StageTxt: Code[25];
        ProgramTxt: Text;
        NumberTx: array[2] of Text;
        Checkreport: Report Check;
        YearTxt: Code[30];
        SemesterTxt: Code[30];
        DeanTxt: Text;
        VCtxt: Text;




    procedure GetCurrentYear() Message: Text
    begin
        CurrentYr.RESET;
        CurrentYr.SETRANGE(Current, TRUE);
        IF CurrentYr.FIND('-') THEN BEGIN
            Message := CurrentYr.Code;
        END;
    end;

    procedure GetCurrentSemester() Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;

    procedure setNaration(status: code[25]; var Narration: text)
    begin
        case
            status of
            'PASS':
                begin
                    Narration := StrSubstNo('The following %1 candidates satisfied the Board of Examiners of the %2 in the %3 Examinations in the programmes indicated. %4', PassCcountTxt, SchoolTxt, StageTxt, ProgramTxt);
                end;
            'FAIL':
                begin
                    Narration := StrSubstNo('The following %1 candidates  failed to satisfy the Board of Examiners of the %2 in the %3 Examinations in the units indicated. %4', FailcountTxt, SchoolTxt, StageTxt, ProgramTxt);
                end;
            'RETAKE ONE':
                begin
                    Narration := StrSubstNo('The following %1 candidates failed to satisfy the Board of Examiners of the %2 in the %3 Examinations in the programmes indicated due to the reasons indicated. The School Board of Examiners therefore recommends' +
'that the candidates retake the units when next offered. %4', RetakeOnecountTxt, SchoolTxt, StageTxt, ProgramTxt);
                end;
            'ABSCONDED':
                begin
                    Narration := StrSubstNo('The following %1 candidates failed to satisfy the Board of Examiners of the %2 in the %3 Examinations in the programmes indicated. %4', AbscondedCountTxt, SchoolTxt, StageTxt, ProgramTxt);
                end;
            'SUPPLEMENTARY':
                begin
                    Narration := StrSubstNo('The following %1 candidates failed to satisfy the Board of Examiners of the %2 in the %3 Examinations in the units indicated. The School Board ' +
'of Examiners therefore recommends that the candidates sit SUPPLEMENTARY examinations in the units indicated when next offered. %4', SuppCountTxt, SchoolTxt, StageTxt, ProgramTxt);
                end;
            'SPECIAL':
                begin
                    Narration := StrSubstNo('The following %1 candidates failed to satisfy the Board of Examiners of the %2 in the %3 Examinations in the units indicated. The School Board ' +
'of Examiners therefore recommends that the candidates sit SPECIAL examinations in the units indicated when next offered. %4', specialCountTxt, SchoolTxt, StageTxt, ProgramTxt);
                end;
        end;
    end;

    procedure getStageTxt(stage: code[20]; var StageTxt: code[30])
    var
        Year: Text;
        sem: Text; //Y1S1
    begin
        //initialize variables
        StageTxt := '';
        YearTxt := '';
        SemesterTxt := '';

        Year := CopyStr(stage, 2, 1);
        sem := CopyStr(stage, 4, 1);
        //set yeartxt and semestertxt


        case
            sem of
            '1':
                begin
                    StageTxt := 'First Semester';
                    SemesterTxt := 'SEMESTER ONE';
                end;
            '2':
                begin
                    StageTxt := 'Second Semester';
                    SemesterTxt := 'SEMESTER TWO';
                end;
        end;

        case
            Year of
            '1':
                begin
                    StageTxt := 'First Year ' + StageTxt;
                    YearTxt := 'YER ONE';
                end;
            '2':
                begin
                    StageTxt := 'Second Year ' + StageTxt;
                    YearTxt := 'YEAR TWO';
                end;
            '3':
                begin
                    StageTxt := 'Third Year ' + StageTxt;
                    YearTxt := 'YEAR THREE';
                end;
            '4':
                begin
                    StageTxt := 'Fourth Year ' + StageTxt;
                    YearTxt := 'YEAR FOUR';
                end;
            '5':
                begin
                    StageTxt := 'Fifth Year ' + StageTxt;
                    YearTxt := 'YEAR FIVE';
                end;
        end;
    end;

    procedure GetDean(var DeanTxt: Text)
    begin
        DeanTxt := 'Dean of School';
    end;

    procedure GetVC(var VCtxt: Text)
    begin
        VCtxt := 'Vice Chancellor';
    end;
}