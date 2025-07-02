codeunit 50150 "Stream Splitting Mgt"
{
    procedure SplitLecturerUnitIntoStreams(var LecturerUnit: Record "ACA-Lecturers Units")
    var
        NewLecturerUnit: Record "ACA-Lecturers Units";
        StreamCode: Code[10];
        StudentAllocation: Integer;
        MaxStudentsPerStream: Integer;
        NumberOfStreams: Integer;
        StudentsPerStream: Integer;
        RemainingStudents: Integer;
        i: Integer;
        StreamChar: Char;
    begin
        MaxStudentsPerStream := 100;
        
        LecturerUnit.CalcFields("Registered Students");
        StudentAllocation := LecturerUnit."Student Allocation";
        
        if StudentAllocation = 0 then
            StudentAllocation := LecturerUnit."Registered Students";
            
        if StudentAllocation <= MaxStudentsPerStream then
            Error('Student allocation (%1) does not exceed the maximum per stream (%2). No splitting required.', 
                  StudentAllocation, MaxStudentsPerStream);
        
        NumberOfStreams := Round(StudentAllocation / MaxStudentsPerStream, 1, '>');
        StudentsPerStream := Round(StudentAllocation / NumberOfStreams, 1);
        RemainingStudents := StudentAllocation;
        
        if LecturerUnit.Stream <> '' then
            Error('This unit already has a stream assigned: %1', LecturerUnit.Stream);
        
        StreamChar := 65; // ASCII for 'A'
        
        for i := 1 to NumberOfStreams do begin
            StreamCode := Format(StreamChar);
            
            if i = 1 then begin
                // Update the original record to become Stream A
                LecturerUnit.Stream := StreamCode;
                if i = NumberOfStreams then
                    LecturerUnit."Student Allocation" := RemainingStudents
                else
                    LecturerUnit."Student Allocation" := StudentsPerStream;
                LecturerUnit.Modify(true);
                RemainingStudents -= LecturerUnit."Student Allocation";
            end else begin
                // Create new records for additional streams
                Clear(NewLecturerUnit);
                NewLecturerUnit.Init();
                
                // Copy all field values manually
                NewLecturerUnit.Lecturer := LecturerUnit.Lecturer;
                NewLecturerUnit.Programme := LecturerUnit.Programme;
                NewLecturerUnit.Stage := LecturerUnit.Stage;
                NewLecturerUnit.Unit := LecturerUnit.Unit;
                NewLecturerUnit.Semester := LecturerUnit.Semester;
                NewLecturerUnit.Description := LecturerUnit.Description;
                NewLecturerUnit.Stream := StreamCode;
                NewLecturerUnit.Remarks := LecturerUnit.Remarks;
                NewLecturerUnit."No. Of Hours" := LecturerUnit."No. Of Hours";
                NewLecturerUnit."No. Of Hours Contracted" := LecturerUnit."No. Of Hours Contracted";
                NewLecturerUnit."Available From" := LecturerUnit."Available From";
                NewLecturerUnit."Available To" := LecturerUnit."Available To";
                NewLecturerUnit."Minimum Contracted" := LecturerUnit."Minimum Contracted";
                NewLecturerUnit.Class := LecturerUnit.Class;
                NewLecturerUnit."Unit Class" := LecturerUnit."Unit Class";
                NewLecturerUnit."Student Type" := LecturerUnit."Student Type";
                NewLecturerUnit.Rate := LecturerUnit.Rate;
                NewLecturerUnit."Lect. Hrs" := LecturerUnit."Lect. Hrs";
                NewLecturerUnit."Pract. Hrs" := LecturerUnit."Pract. Hrs";
                NewLecturerUnit."Tut. Hrs" := LecturerUnit."Tut. Hrs";
                NewLecturerUnit."Class Type" := LecturerUnit."Class Type";
                NewLecturerUnit."Campus Code" := LecturerUnit."Campus Code";
                NewLecturerUnit."Class Size" := LecturerUnit."Class Size";
                NewLecturerUnit."Engagement Terms" := LecturerUnit."Engagement Terms";
                NewLecturerUnit."Unit Cost" := LecturerUnit."Unit Cost";
                NewLecturerUnit."Group Type" := LecturerUnit."Group Type";
                NewLecturerUnit.Day := LecturerUnit.Day;
                NewLecturerUnit.TimeSlot := LecturerUnit.TimeSlot;
                NewLecturerUnit.ModeOfStudy := LecturerUnit.ModeOfStudy;
                NewLecturerUnit."Required Equipment" := LecturerUnit."Required Equipment";
                NewLecturerUnit."Academic Year" := LecturerUnit."Academic Year";
                NewLecturerUnit."Program Option" := LecturerUnit."Program Option";
                NewLecturerUnit."Year of Study" := LecturerUnit."Year of Study";
                
                if i = NumberOfStreams then
                    NewLecturerUnit."Student Allocation" := RemainingStudents
                else
                    NewLecturerUnit."Student Allocation" := StudentsPerStream;
                    
                NewLecturerUnit.Amount := NewLecturerUnit."No. Of Hours" * NewLecturerUnit.Rate;
                NewLecturerUnit."Unit Cost" := NewLecturerUnit."No. Of Hours" * NewLecturerUnit.Rate;
                NewLecturerUnit."Claimed Amount" := NewLecturerUnit."No. Of Hours" * NewLecturerUnit.Rate;
                
                RemainingStudents -= NewLecturerUnit."Student Allocation";
                NewLecturerUnit.Insert(true);
            end;
            
            StreamChar += 1;
        end;
        
        Message('Successfully split unit into %1 streams', NumberOfStreams);
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