codeunit 51316 "Timetable Change Management"
{
    procedure CopyTimetableWithModifications(SourceHeader: Record "Timetable Header"; var NewHeader: Record "Timetable Header")
    var
        SourceEntry: Record "Timetable Entry";
        NewEntry: Record "Timetable Entry";
        ChangeLog: Record "Timetable Change Log";
        Window: Dialog;
        TotalRecords: Integer;
        CurrentRecord: Integer;
    begin
        // Validate source timetable exists
        if SourceHeader."Document No." = '' then
            Error('Source timetable document number cannot be empty.');

        // Copy header information
        NewHeader."Academic Year" := SourceHeader."Academic Year";
        NewHeader.Semester := SourceHeader.Semester;
        NewHeader.Type := SourceHeader.Type;
        NewHeader."Linked Timetable No." := SourceHeader."Document No.";
        NewHeader."Timetable Status" := NewHeader."Timetable Status"::Draft;
        
        if NewHeader.Insert(true) then begin
            // Copy all timetable entries from source
            SourceEntry.SetRange("Document No.", SourceHeader."Document No.");
            TotalRecords := SourceEntry.Count();
            
            Window.Open('Copying Timetable Entries\' +
                       'Total: #1###\' +
                       'Current: #2###\' +
                       'Unit: #3##################');
                       
            if SourceEntry.FindSet() then begin
                repeat
                    CurrentRecord += 1;
                    Window.Update(1, TotalRecords);
                    Window.Update(2, CurrentRecord);
                    Window.Update(3, SourceEntry."Unit Code");
                    
                    // Create new entry based on source
                    NewEntry.Init();
                    NewEntry.TransferFields(SourceEntry);
                    NewEntry."Entry No." := 0; // Auto-increment will assign new number
                    NewEntry."Document No." := NewHeader."Document No.";
                    
                    if NewEntry.Insert(true) then begin
                        // Log the copy action
                        LogTimetableChange(
                            NewHeader."Document No.",
                            SourceHeader."Document No.",
                            ChangeLog."Change Type"::"Other",
                            NewEntry."Programme Code",
                            NewEntry."Stage Code",
                            NewEntry."Unit Code",
                            NewEntry."Group No",
                            'Entry copied from source timetable',
                            '',
                            '',
                            NewEntry."Academic Year",
                            NewEntry.Semester,
                            NewEntry."Entry No."
                        );
                    end;
                until SourceEntry.Next() = 0;
            end;
            
            Window.Close();
            Message('Timetable copied successfully. %1 entries copied.', TotalRecords);
        end;
    end;

    procedure LogTimetableChange(
        TimetableDocNo: Code[20];
        SourceDocNo: Code[20];
        ChangeType: Option;
        ProgrammeCode: Code[20];
        StageCode: Code[20];
        UnitCode: Code[20];
        Stream: Code[100];
        Description: Text[250];
        OldValue: Text[100];
        NewValue: Text[100];
        AcademicYear: Code[25];
        Semester: Code[25];
        OriginalEntryNo: Integer)
    var
        ChangeLog: Record "Timetable Change Log";
    begin
        ChangeLog.Init();
        ChangeLog."Timetable Document No." := TimetableDocNo;
        ChangeLog."Source Document No." := SourceDocNo;
        ChangeLog."Change Type" := ChangeType;
        ChangeLog."Programme Code" := ProgrammeCode;
        ChangeLog."Stage Code" := StageCode;
        ChangeLog."Unit Code" := UnitCode;
        ChangeLog.Stream := Stream;
        ChangeLog."Change Description" := Description;
        ChangeLog."Old Value" := OldValue;
        ChangeLog."New Value" := NewValue;
        ChangeLog."Academic Year" := AcademicYear;
        ChangeLog.Semester := Semester;
        ChangeLog."Original Entry No." := OriginalEntryNo;
        ChangeLog.Insert(true);
    end;

    procedure LogLecturerChange(
        TimetableDocNo: Code[20];
        SourceDocNo: Code[20];
        ProgrammeCode: Code[20];
        StageCode: Code[20];
        UnitCode: Code[20];
        Stream: Code[100];
        OldLecturerCode: Code[20];
        NewLecturerCode: Code[20];
        Reason: Text[250];
        AcademicYear: Code[25];
        Semester: Code[25];
        OriginalEntryNo: Integer)
    var
        ChangeLog: Record "Timetable Change Log";
        OldLecturer: Record "HRM-Employee C";
        NewLecturer: Record "HRM-Employee C";
        Description: Text[250];
    begin
        // Get lecturer names for better description
        if OldLecturer.Get(OldLecturerCode) then;
        if NewLecturer.Get(NewLecturerCode) then;
        
        Description := StrSubstNo('Lecturer changed from %1 to %2 for %3', 
            OldLecturer."First Name" + ' ' + OldLecturer."Last Name",
            NewLecturer."First Name" + ' ' + NewLecturer."Last Name",
            UnitCode);
            
        ChangeLog.Init();
        ChangeLog."Timetable Document No." := TimetableDocNo;
        ChangeLog."Source Document No." := SourceDocNo;
        ChangeLog."Change Type" := ChangeLog."Change Type"::"Lecturer Change";
        ChangeLog."Programme Code" := ProgrammeCode;
        ChangeLog."Stage Code" := StageCode;
        ChangeLog."Unit Code" := UnitCode;
        ChangeLog.Stream := Stream;
        ChangeLog."Change Description" := Description;
        ChangeLog."Old Lecturer Code" := OldLecturerCode;
        ChangeLog."New Lecturer Code" := NewLecturerCode;
        ChangeLog."Change Reason" := Reason;
        ChangeLog."Academic Year" := AcademicYear;
        ChangeLog.Semester := Semester;
        ChangeLog."Original Entry No." := OriginalEntryNo;
        ChangeLog.Insert(true);
    end;

    procedure LogRoomChange(
        TimetableDocNo: Code[20];
        SourceDocNo: Code[20];
        ProgrammeCode: Code[20];
        StageCode: Code[20];
        UnitCode: Code[20];
        Stream: Code[100];
        OldRoomCode: Code[20];
        NewRoomCode: Code[20];
        Reason: Text[250];
        AcademicYear: Code[25];
        Semester: Code[25];
        OriginalEntryNo: Integer)
    var
        ChangeLog: Record "Timetable Change Log";
        Description: Text[250];
    begin
        Description := StrSubstNo('Room changed from %1 to %2 for %3', OldRoomCode, NewRoomCode, UnitCode);
            
        ChangeLog.Init();
        ChangeLog."Timetable Document No." := TimetableDocNo;
        ChangeLog."Source Document No." := SourceDocNo;
        ChangeLog."Change Type" := ChangeLog."Change Type"::"Room Change";
        ChangeLog."Programme Code" := ProgrammeCode;
        ChangeLog."Stage Code" := StageCode;
        ChangeLog."Unit Code" := UnitCode;
        ChangeLog.Stream := Stream;
        ChangeLog."Change Description" := Description;
        ChangeLog."Old Room Code" := OldRoomCode;
        ChangeLog."New Room Code" := NewRoomCode;
        ChangeLog."Change Reason" := Reason;
        ChangeLog."Academic Year" := AcademicYear;
        ChangeLog.Semester := Semester;
        ChangeLog."Original Entry No." := OriginalEntryNo;
        ChangeLog.Insert(true);
    end;

    procedure LogTimeChange(
        TimetableDocNo: Code[20];
        SourceDocNo: Code[20];
        ProgrammeCode: Code[20];
        StageCode: Code[20];
        UnitCode: Code[20];
        Stream: Code[100];
        OldTimeSlot: Code[20];
        NewTimeSlot: Code[20];
        OldDay: Option;
        NewDay: Option;
        OldStartTime: Time;
        NewStartTime: Time;
        OldEndTime: Time;
        NewEndTime: Time;
        Reason: Text[250];
        AcademicYear: Code[25];
        Semester: Code[25];
        OriginalEntryNo: Integer)
    var
        ChangeLog: Record "Timetable Change Log";
        Description: Text[250];
    begin
        Description := StrSubstNo('Time changed from %1 %2-%3 to %4 %5-%6 for %7', 
            OldDay, OldStartTime, OldEndTime, NewDay, NewStartTime, NewEndTime, UnitCode);
            
        ChangeLog.Init();
        ChangeLog."Timetable Document No." := TimetableDocNo;
        ChangeLog."Source Document No." := SourceDocNo;
        ChangeLog."Change Type" := ChangeLog."Change Type"::"Time Change";
        ChangeLog."Programme Code" := ProgrammeCode;
        ChangeLog."Stage Code" := StageCode;
        ChangeLog."Unit Code" := UnitCode;
        ChangeLog.Stream := Stream;
        ChangeLog."Change Description" := Description;
        ChangeLog."Old Time Slot" := OldTimeSlot;
        ChangeLog."New Time Slot" := NewTimeSlot;
        ChangeLog."Old Day" := OldDay;
        ChangeLog."New Day" := NewDay;
        ChangeLog."Old Start Time" := OldStartTime;
        ChangeLog."New Start Time" := NewStartTime;
        ChangeLog."Old End Time" := OldEndTime;
        ChangeLog."New End Time" := NewEndTime;
        ChangeLog."Change Reason" := Reason;
        ChangeLog."Academic Year" := AcademicYear;
        ChangeLog.Semester := Semester;
        ChangeLog."Original Entry No." := OriginalEntryNo;
        ChangeLog.Insert(true);
    end;

    procedure MarkTimetableAsChanged(TimetableDocNo: Code[20])
    var
        TimetableHeader: Record "Timetable Header";
        ChangeLog: Record "Timetable Change Log";
    begin
        if TimetableHeader.Get(TimetableDocNo) then begin
            // Check if there are any change logs for this timetable
            ChangeLog.SetRange("Timetable Document No.", TimetableDocNo);
            TimetableHeader."Has Changes" := not ChangeLog.IsEmpty();
            TimetableHeader.Modify();
        end;
    end;

    procedure GetChangesSummary(TimetableDocNo: Code[20]): Text
    var
        ChangeLog: Record "Timetable Change Log";
        Summary: Text;
        LecturerChanges: Integer;
        RoomChanges: Integer;
        TimeChanges: Integer;
        UnitAdditions: Integer;
        UnitRemovals: Integer;
        Others: Integer;
    begin
        ChangeLog.SetRange("Timetable Document No.", TimetableDocNo);
        if ChangeLog.FindSet() then begin
            repeat
                case ChangeLog."Change Type" of
                    ChangeLog."Change Type"::"Lecturer Change":
                        LecturerChanges += 1;
                    ChangeLog."Change Type"::"Room Change":
                        RoomChanges += 1;
                    ChangeLog."Change Type"::"Time Change":
                        TimeChanges += 1;
                    ChangeLog."Change Type"::"Unit Addition":
                        UnitAdditions += 1;
                    ChangeLog."Change Type"::"Unit Removal":
                        UnitRemovals += 1;
                    else
                        Others += 1;
                end;
            until ChangeLog.Next() = 0;
        end;
        
        Summary := StrSubstNo('Changes: %1 Lecturer, %2 Room, %3 Time, %4 Unit Added, %5 Unit Removed, %6 Other',
            LecturerChanges, RoomChanges, TimeChanges, UnitAdditions, UnitRemovals, Others);
            
        exit(Summary);
    end;
}