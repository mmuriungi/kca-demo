codeunit 50150 "Stream Splitting Mgt"
{
    procedure SplitLecturerUnitIntoStreams(var LecturerUnit: Record "ACA-Lecturers Units")
    var
        NewLecturerUnit: Record "ACA-Lecturers Units";
        TempLecturerUnit: Record "ACA-Lecturers Units";
        OriginalRecords: Record "ACA-Lecturers Units" temporary;
        StudentAllocation: Integer;
        TotalStudentAllocation: Integer;
        MaxStudentsPerStream: Integer;
        NumberOfStreams: Integer;
        StudentsPerStream: Integer;
        i: Integer;
        StreamCode: Code[10];
    begin
        MaxStudentsPerStream := 100;

        // Calculate total student allocation for this lecturer, unit, and semester across all programmes
        TotalStudentAllocation := 0;
        TempLecturerUnit.Reset();
        TempLecturerUnit.SetRange(Lecturer, LecturerUnit.Lecturer);
        TempLecturerUnit.SetRange(Unit, LecturerUnit.Unit);
        TempLecturerUnit.SetRange(Semester, LecturerUnit.Semester);
        TempLecturerUnit.SetRange(Stream, ''); // Only count units without streams
        if TempLecturerUnit.FindSet() then begin
            repeat
                TempLecturerUnit.CalcFields("Registered Students");
                StudentAllocation := TempLecturerUnit."Student Allocation";
                if StudentAllocation = 0 then
                    StudentAllocation := TempLecturerUnit."Registered Students";
                TotalStudentAllocation += StudentAllocation;

                // Copy to temporary table for processing
                OriginalRecords := TempLecturerUnit;
                OriginalRecords."Student Allocation" := StudentAllocation;
                OriginalRecords.Insert();
            until TempLecturerUnit.Next() = 0;
        end;

        if TotalStudentAllocation <= MaxStudentsPerStream then
            Error('Total student allocation (%1) does not exceed the maximum per stream (%2). No splitting required.',
                  TotalStudentAllocation, MaxStudentsPerStream);

        NumberOfStreams := Round(TotalStudentAllocation / MaxStudentsPerStream, 1, '>');
        StudentsPerStream := Round(TotalStudentAllocation / NumberOfStreams, 1);

        if LecturerUnit.Stream <> '' then
            Error('This unit already has a stream assigned: %1', LecturerUnit.Stream);

        // Step 1: Convert original records to Stream A
        OriginalRecords.Reset();
        if OriginalRecords.FindSet() then begin
            repeat
                TempLecturerUnit.Get(OriginalRecords.Programme, OriginalRecords.Stage, OriginalRecords."Campus Code",
                                    OriginalRecords."Group Type", OriginalRecords.Class, OriginalRecords.Lecturer,
                                    OriginalRecords.Unit, OriginalRecords.Semester, OriginalRecords.Description, '');

                TempLecturerUnit."Student Allocation" := Round(OriginalRecords."Student Allocation" * StudentsPerStream / TotalStudentAllocation, 1);
                TempLecturerUnit.Rename(TempLecturerUnit.Programme, TempLecturerUnit.Stage, TempLecturerUnit."Campus Code",
                                       TempLecturerUnit."Group Type", TempLecturerUnit.Class, TempLecturerUnit.Lecturer,
                                       TempLecturerUnit.Unit, TempLecturerUnit.Semester, TempLecturerUnit.Description, 'A');
            until OriginalRecords.Next() = 0;
        end;

        // Step 2: Create additional streams (B, C, D, etc.)
        for i := 2 to NumberOfStreams do begin
            case i of
                2:
                    StreamCode := 'B';
                3:
                    StreamCode := 'C';
                4:
                    StreamCode := 'D';
                5:
                    StreamCode := 'E';
                6:
                    StreamCode := 'F';
                7:
                    StreamCode := 'G';
                8:
                    StreamCode := 'H';
                9:
                    StreamCode := 'I';
                10:
                    StreamCode := 'J';
                else
                    StreamCode := 'Z';
            end;

            OriginalRecords.Reset();
            if OriginalRecords.FindSet() then begin
                repeat
                    Clear(NewLecturerUnit);
                    NewLecturerUnit.Init();

                    // Copy all field values manually
                    NewLecturerUnit.Lecturer := OriginalRecords.Lecturer;
                    NewLecturerUnit.Programme := OriginalRecords.Programme;
                    NewLecturerUnit.Stage := OriginalRecords.Stage;
                    NewLecturerUnit.Unit := OriginalRecords.Unit;
                    NewLecturerUnit.Semester := OriginalRecords.Semester;
                    NewLecturerUnit.Description := OriginalRecords.Description;
                    NewLecturerUnit.Stream := StreamCode;
                    NewLecturerUnit.Remarks := OriginalRecords.Remarks;
                    NewLecturerUnit."No. Of Hours" := OriginalRecords."No. Of Hours";
                    NewLecturerUnit."No. Of Hours Contracted" := OriginalRecords."No. Of Hours Contracted";
                    NewLecturerUnit."Available From" := OriginalRecords."Available From";
                    NewLecturerUnit."Available To" := OriginalRecords."Available To";
                    NewLecturerUnit."Minimum Contracted" := OriginalRecords."Minimum Contracted";
                    NewLecturerUnit.Class := OriginalRecords.Class;
                    NewLecturerUnit."Unit Class" := OriginalRecords."Unit Class";
                    NewLecturerUnit."Student Type" := OriginalRecords."Student Type";
                    NewLecturerUnit.Rate := OriginalRecords.Rate;
                    NewLecturerUnit."Lect. Hrs" := OriginalRecords."Lect. Hrs";
                    NewLecturerUnit."Pract. Hrs" := OriginalRecords."Pract. Hrs";
                    NewLecturerUnit."Tut. Hrs" := OriginalRecords."Tut. Hrs";
                    NewLecturerUnit."Class Type" := OriginalRecords."Class Type";
                    NewLecturerUnit."Campus Code" := OriginalRecords."Campus Code";
                    NewLecturerUnit."Class Size" := OriginalRecords."Class Size";
                    NewLecturerUnit."Engagement Terms" := OriginalRecords."Engagement Terms";
                    NewLecturerUnit."Unit Cost" := OriginalRecords."Unit Cost";
                    NewLecturerUnit."Group Type" := OriginalRecords."Group Type";
                    NewLecturerUnit.Day := OriginalRecords.Day;
                    NewLecturerUnit."Time Table Hours" := OriginalRecords."Time Table Hours";
                    NewLecturerUnit."Required Equipment" := OriginalRecords."Required Equipment";
                    NewLecturerUnit.TimeSlot := OriginalRecords.TimeSlot;
                    NewLecturerUnit.ModeOfStudy := OriginalRecords.ModeOfStudy;
                    NewLecturerUnit."Required Equipment" := OriginalRecords."Required Equipment";
                    NewLecturerUnit."Academic Year" := OriginalRecords."Academic Year";
                    NewLecturerUnit."Program Option" := OriginalRecords."Program Option";
                    NewLecturerUnit."Year of Study" := OriginalRecords."Year of Study";

                    // Calculate student allocation for this stream
                    NewLecturerUnit."Student Allocation" := Round(OriginalRecords."Student Allocation" * StudentsPerStream / TotalStudentAllocation, 1);

                    NewLecturerUnit.Amount := NewLecturerUnit."No. Of Hours" * NewLecturerUnit.Rate;
                    NewLecturerUnit."Unit Cost" := NewLecturerUnit."No. Of Hours" * NewLecturerUnit.Rate;
                    NewLecturerUnit."Claimed Amount" := NewLecturerUnit."No. Of Hours" * NewLecturerUnit.Rate;

                    NewLecturerUnit.Insert(true);
                until OriginalRecords.Next() = 0;
            end;
        end;

        Commit();
        //  Message('Successfully split unit into %1 streams across programmes', NumberOfStreams);
    end;

    procedure CalculateStreamsNeeded(StudentAllocation: Integer): Integer
    var
        MaxStudentsPerStream: Integer;
    begin
        MaxStudentsPerStream := 100;

        if StudentAllocation <= 0 then
            exit(0);

        exit(Round(StudentAllocation / MaxStudentsPerStream, 1, '>'));
    end;

    procedure PreviewStreamSplit(var LecturerUnit: Record "ACA-Lecturers Units")
    var
        StudentAllocation: Integer;
        NumberOfStreams: Integer;
        StudentsPerStream: Integer;
        PreviewText: Text;
        i: Integer;
        StreamChar: Char;
        RemainingStudents: Integer;
    begin
        LecturerUnit.CalcFields("Registered Students");
        StudentAllocation := LecturerUnit."Student Allocation";

        if StudentAllocation = 0 then
            StudentAllocation := LecturerUnit."Registered Students";

        NumberOfStreams := CalculateStreamsNeeded(StudentAllocation);

        if NumberOfStreams <= 1 then begin
            Message('No stream splitting required. Student allocation: %1', StudentAllocation);
            exit;
        end;

        StudentsPerStream := Round(StudentAllocation / NumberOfStreams, 1);
        RemainingStudents := StudentAllocation;

        PreviewText := 'Stream Split Preview:\';
        PreviewText += 'Total Students: ' + Format(StudentAllocation) + '\';
        PreviewText += 'Number of Streams: ' + Format(NumberOfStreams) + '\';
        PreviewText += '\Proposed Streams:\';

        StreamChar := 65; // ASCII for 'A'

        for i := 1 to NumberOfStreams do begin
            PreviewText += 'Stream ' + Format(StreamChar) + ': ';
            if i = NumberOfStreams then
                PreviewText += Format(RemainingStudents) + ' students\'
            else begin
                PreviewText += Format(StudentsPerStream) + ' students\';
                RemainingStudents -= StudentsPerStream;
            end;
            StreamChar += 1;
        end;

        Message(PreviewText);
    end;
}