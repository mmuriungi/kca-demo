codeunit 50106 "Academics Handler"
{
    procedure ValidateStudentProgression(var CosReg: Record "ACA-Course Registration")
    var
        GenSetup: Record "ACA-General Set-Up";
    begin
        GenSetup.Get();
        if CosReg."Year Of Study" in [1, 2] then
            exit;
        if GetTotalSuppsWithoutMarks(CosReg."Student No.", CosReg."Year Of Study" - GenSetup."Max Supp Carry Forward Years") <= 0 then
            exit;
        Error('You have %1 Supplementary Exams without marks', GetTotalSuppsWithoutMarks(CosReg."Student No.", CosReg."Year Of Study" - GenSetup."Max Supp Carry Forward Years"));
    end;

    procedure GetTotalSuppsWithoutMarks(studentNo: Code[20]; YearOfStudy: Integer): Integer
    var
        SuppExams: Record "Aca-Special Exams Details";
    begin
        SuppExams.Reset();
        SuppExams.SetRange("Student No.", studentNo);
        SuppExams.SetRange("Year Of Study", YearOfStudy);
        SuppExams.SetRange("Status", SuppExams.Status::Approved);
        SuppExams.SetRange("Total Marks", 0);
        exit(SuppExams.Count);
    end;
}
