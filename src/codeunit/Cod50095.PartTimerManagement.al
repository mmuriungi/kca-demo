codeunit 50095 "PartTimer Management"
{
    procedure checkClaimEligibility(Var parttimeLine: Record "Parttime Claim Lines")
    var
        PartTime: Record "Parttime Claim Header";
        LecturerUnits: Record "ACA-Lecturers Units";
        ExamMarks: Record "ACA-Exam Results";
    begin
        LecturerUnits.Reset();
        LecturerUnits.SetRange(Lecturer, parttimeLine."Lecture No.");
        LecturerUnits.SetRange("Unit", parttimeLine."Unit");
        if LecturerUnits.FindFirst() then begin
            
        end else
            parttimeLine.Excluded := true;
    end;
}
