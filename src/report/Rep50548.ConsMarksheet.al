report 50548 "Cons Marksheet"
{

    RDLCLayout = './Layouts/consReport(New).rdl';
    dataset
    {
        dataitem(SenateReportNew; "Senate Report New")
        {
            RequestFilterFields = Semester, "Year of Study";
            column(AcdemicYear; "Acdemic Year")
            {
            }
            column(Average; "Average")
            {
            }
            column(Grade; Grade)
            {
            }
            column(Programme; Programme)
            {
            }
            column(Semester; Semester)
            {
            }
            column(Stage; Stage)
            {
            }
            column(Status; Status)
            {
            }
            column(StudentName; "Student Name")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(pic; CompInfo.Picture)
            {

            }
            column(name; CompInfo.Name)
            {

            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                CalcFields = "Total Score";
                DataItemLink = "Student No." = FIELD("Student No.");
                column(Unit; Unit)
                {

                }
                column(Unit_Description; "Unit Description")
                {

                }
                column(Student_No_; "Student No.")
                {

                }
                column(Total_Score; "Total Score")
                {

                }
                column(currSem; currSem)
                {

                }
                column(currAcad; currAcad)
                {

                }
                column(progName; progName)
                {

                }
                column(seq; seq)
                {

                }


            }
            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
                prog.Reset();
                prog.SetRange(Code, SenateReportNew.Programme);
                if prog.Find('-') then begin
                    progName := prog.Description;
                    departName := prog."Department Name";
                    facultyName := prog."Faculty Name";
                end;
                currSem := GetCurrentSemester(SenateReportNew.Semester);
                currAcad := GetCurrentYear(SenateReportNew.Semester);
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
        CompInfo: Record "Company Information";
        prog: Record "ACA-Programme";
        progName, departName, facultyName, currAcad, currSem : text;
        CurrentYr: Record "ACA-Academic Year";
        CurrentSem: Record "ACA-Semesters";
        seq: Integer;

    procedure GetCurrentYear(sem: Code[20]) Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE(Code, sem);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem."Academic Year";
        END;
    end;

    procedure GetCurrentSemester(sem: Code[20]) Message: Text
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE(Code, sem);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Description;
        END;
    end;

}


