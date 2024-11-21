codeunit 50049 "Academic Background Tasks"
{
    trigger OnRun()
    begin
        insertExamPaperSubmissions();
    end;

    procedure insertExamPaperSubmissions()
    var
        PaperSubmission: Record "Unit Exam Paper Submission";
        Units: Record "ACA-Units/Subjects";
        Semester: Record "ACA-Semesters";
        CurrSem: code[20];
    begin
        Semester.Reset();
        Semester.SetRange("Current Semester", TRUE);
        if Semester.FindFirst() then
            CurrSem := Semester."Code";

        Units.Reset();
        if Units.FindSet() then
            repeat
                PaperSubmission.reset;
                PaperSubmission.SetRange("Semester", CurrSem);
                PaperSubmission.SetRange("Programme Code", Units."Programme Code");
                PaperSubmission.SetRange("Programme Option", Units."Programme Option");
                PaperSubmission.SetRange("Stage Code", Units."Stage Code");
                PaperSubmission.SetRange("Code", Units."Code");
                if not PaperSubmission.FindSet() then begin
                    PaperSubmission.TransferFields(Units);
                    PaperSubmission.Semester := CurrSem;
                    PaperSubmission.Insert();
                end;
            until Units.Next() = 0;

    end;
}
