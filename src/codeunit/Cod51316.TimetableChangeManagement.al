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

    procedure ProcessChangeRules(TimetableDocNo: Code[20]; PreviewOnly: Boolean): Integer
    var
        ChangeRule: Record "Timetable Change Rule";
        TimetableEntry: Record "Timetable Entry";
        TotalChanges: Integer;
        Window: Dialog;
        CurrentRule: Integer;
        TotalRules: Integer;
    begin
        ChangeRule.SetRange("Timetable Document No.", TimetableDocNo);
        ChangeRule.SetRange(Active, true);
        ChangeRule.SetRange(Applied, false);
        ChangeRule.SetCurrentKey(Priority);
        
        TotalRules := ChangeRule.Count();
        if TotalRules = 0 then
            Error('No active change rules found for this timetable.');
            
        Window.Open('Processing Change Rules\' +
                   'Rule: #1### of #2###\' +
                   'Description: #3######################\' +
                   'Entries Processed: #4###');
                   
        if ChangeRule.FindSet() then begin
            repeat
                CurrentRule += 1;
                Window.Update(1, CurrentRule);
                Window.Update(2, TotalRules);
                Window.Update(3, ChangeRule.Description);
                
                TotalChanges += ProcessSingleRule(ChangeRule, PreviewOnly);
                
                Window.Update(4, TotalChanges);
            until ChangeRule.Next() = 0;
        end;
        
        Window.Close();
        
        if PreviewOnly then
            Message('%1 entries would be affected by the active rules.', TotalChanges)
        else
            Message('%1 entries have been updated successfully.', TotalChanges);
            
        exit(TotalChanges);
    end;

    local procedure ProcessSingleRule(var ChangeRule: Record "Timetable Change Rule"; PreviewOnly: Boolean): Integer
    var
        TimetableEntry: Record "Timetable Entry";
        AffectedEntries: Integer;
    begin
        // Build filter based on rule criteria
        TimetableEntry.SetRange("Document No.", ChangeRule."Timetable Document No.");
        
        if ChangeRule."Filter Programme" <> '' then
            TimetableEntry.SetRange("Programme Code", ChangeRule."Filter Programme");
        if ChangeRule."Filter Stage" <> '' then
            TimetableEntry.SetRange("Stage Code", ChangeRule."Filter Stage");
        if ChangeRule."Filter Unit" <> '' then
            TimetableEntry.SetRange("Unit Code", ChangeRule."Filter Unit");
        if ChangeRule."Filter Stream" <> '' then
            TimetableEntry.SetRange("Group No", ChangeRule."Filter Stream");
        if ChangeRule."Filter Lecturer" <> '' then
            TimetableEntry.SetRange("Lecturer Code", ChangeRule."Filter Lecturer");
        if ChangeRule."Filter Room" <> '' then
            TimetableEntry.SetRange("Lecture Hall Code", ChangeRule."Filter Room");
        if ChangeRule."Filter Day" <> 0 then
            TimetableEntry.SetRange("Day of Week", ChangeRule."Filter Day" - 1);
        if ChangeRule."Filter Time Slot" <> '' then
            TimetableEntry.SetRange("Time Slot Code", ChangeRule."Filter Time Slot");
            
        if TimetableEntry.FindSet() then begin
            repeat
                if ShouldApplyRule(TimetableEntry, ChangeRule) then begin
                    if not PreviewOnly then
                        ApplyRuleToEntry(TimetableEntry, ChangeRule);
                    AffectedEntries += 1;
                end;
            until TimetableEntry.Next() = 0;
        end;
        
        if not PreviewOnly then begin
            ChangeRule."Entries Affected" := AffectedEntries;
            ChangeRule.Applied := true;
            ChangeRule."Applied Date" := Today;
            ChangeRule."Applied By" := UserId;
            ChangeRule.Modify();
        end;
        
        exit(AffectedEntries);
    end;

    local procedure ShouldApplyRule(TimetableEntry: Record "Timetable Entry"; ChangeRule: Record "Timetable Change Rule"): Boolean
    begin
        // Additional date filtering if specified
        if (ChangeRule."Filter Date From" <> 0D) or (ChangeRule."Filter Date To" <> 0D) then begin
            if TimetableEntry.Date = 0D then
                exit(true); // If no date on entry, include it
                
            if (ChangeRule."Filter Date From" <> 0D) and (TimetableEntry.Date < ChangeRule."Filter Date From") then
                exit(false);
            if (ChangeRule."Filter Date To" <> 0D) and (TimetableEntry.Date > ChangeRule."Filter Date To") then
                exit(false);
        end;
        
        exit(true);
    end;

    local procedure ApplyRuleToEntry(var TimetableEntry: Record "Timetable Entry"; ChangeRule: Record "Timetable Change Rule")
    var
        OldLecturer: Code[20];
        OldRoom: Code[20];
        OldDay: Option;
        OldTimeSlot: Code[20];
        OldStartTime: Time;
        OldEndTime: Time;
        TimeSlot: Record "Time Slot";
    begin
        case ChangeRule."Rule Type" of
            ChangeRule."Rule Type"::"Lecturer Change":
                begin
                    if ChangeRule."New Lecturer" <> '' then begin
                        OldLecturer := TimetableEntry."Lecturer Code";
                        TimetableEntry."Lecturer Code" := ChangeRule."New Lecturer";
                        TimetableEntry.Modify();
                        
                        LogLecturerChange(
                            TimetableEntry."Document No.",
                            ChangeRule."Timetable Document No.",
                            TimetableEntry."Programme Code",
                            TimetableEntry."Stage Code",
                            TimetableEntry."Unit Code",
                            TimetableEntry."Group No",
                            OldLecturer,
                            ChangeRule."New Lecturer",
                            ChangeRule."Change Reason",
                            TimetableEntry."Academic Year",
                            TimetableEntry.Semester,
                            TimetableEntry."Entry No."
                        );
                    end;
                end;
                
            ChangeRule."Rule Type"::"Room Change":
                begin
                    if ChangeRule."New Room" <> '' then begin
                        OldRoom := TimetableEntry."Lecture Hall Code";
                        TimetableEntry."Lecture Hall Code" := ChangeRule."New Room";
                        TimetableEntry.Modify();
                        
                        LogRoomChange(
                            TimetableEntry."Document No.",
                            ChangeRule."Timetable Document No.",
                            TimetableEntry."Programme Code",
                            TimetableEntry."Stage Code",
                            TimetableEntry."Unit Code",
                            TimetableEntry."Group No",
                            OldRoom,
                            ChangeRule."New Room",
                            ChangeRule."Change Reason",
                            TimetableEntry."Academic Year",
                            TimetableEntry.Semester,
                            TimetableEntry."Entry No."
                        );
                    end;
                end;
                
            ChangeRule."Rule Type"::"Time Change":
                begin
                    OldDay := TimetableEntry."Day of Week";
                    OldTimeSlot := TimetableEntry."Time Slot Code";
                    OldStartTime := TimetableEntry."Start Time";
                    OldEndTime := TimetableEntry."End Time";
                    
                    if ChangeRule."New Day" <> 0 then
                        TimetableEntry."Day of Week" := ChangeRule."New Day" - 1;
                        
                    if ChangeRule."New Time Slot" <> '' then begin
                        TimetableEntry."Time Slot Code" := ChangeRule."New Time Slot";
                        if TimeSlot.Get(ChangeRule."New Time Slot") then begin
                            TimetableEntry."Start Time" := TimeSlot."Start Time";
                            TimetableEntry."End Time" := TimeSlot."End Time";
                        end;
                    end;
                    
                    TimetableEntry.Modify();
                    
                    LogTimeChange(
                        TimetableEntry."Document No.",
                        ChangeRule."Timetable Document No.",
                        TimetableEntry."Programme Code",
                        TimetableEntry."Stage Code",
                        TimetableEntry."Unit Code",
                        TimetableEntry."Group No",
                        OldTimeSlot,
                        ChangeRule."New Time Slot",
                        OldDay,
                        TimetableEntry."Day of Week",
                        OldStartTime,
                        TimetableEntry."Start Time",
                        OldEndTime,
                        TimetableEntry."End Time",
                        ChangeRule."Change Reason",
                        TimetableEntry."Academic Year",
                        TimetableEntry.Semester,
                        TimetableEntry."Entry No."
                    );
                end;
                
            ChangeRule."Rule Type"::"Unit Cancellation":
                begin
                    if ChangeRule."Cancel Unit" then begin
                        LogTimetableChange(
                            TimetableEntry."Document No.",
                            ChangeRule."Timetable Document No.",
                            ChangeRule."Rule Type",
                            TimetableEntry."Programme Code",
                            TimetableEntry."Stage Code",
                            TimetableEntry."Unit Code",
                            TimetableEntry."Group No",
                            'Unit cancelled: ' + ChangeRule."Change Reason",
                            '',
                            '',
                            TimetableEntry."Academic Year",
                            TimetableEntry.Semester,
                            TimetableEntry."Entry No."
                        );
                        
                        TimetableEntry.Delete();
                    end;
                end;
                
            ChangeRule."Rule Type"::"Stream Reassignment":
                begin
                    if ChangeRule."New Stream" <> '' then begin
                        TimetableEntry."Group No" := ChangeRule."New Stream";
                        TimetableEntry.Modify();
                        
                        LogTimetableChange(
                            TimetableEntry."Document No.",
                            ChangeRule."Timetable Document No.",
                            ChangeRule."Rule Type",
                            TimetableEntry."Programme Code",
                            TimetableEntry."Stage Code",
                            TimetableEntry."Unit Code",
                            TimetableEntry."Group No",
                            'Stream reassigned: ' + ChangeRule."Change Reason",
                            ChangeRule."Filter Stream",
                            ChangeRule."New Stream",
                            TimetableEntry."Academic Year",
                            TimetableEntry.Semester,
                            TimetableEntry."Entry No."
                        );
                    end;
                end;
        end;
        
        MarkTimetableAsChanged(TimetableEntry."Document No.");
    end;

    procedure ValidateChangeRule(var ChangeRule: Record "Timetable Change Rule"): Boolean
    var
        ErrorText: Text;
    begin
        // Validate that rule has necessary information
        case ChangeRule."Rule Type" of
            ChangeRule."Rule Type"::"Lecturer Change":
                begin
                    if ChangeRule."New Lecturer" = '' then
                        ErrorText += 'New Lecturer must be specified for Lecturer Change rule.\';
                    if ChangeRule."Filter Lecturer" = '' then
                        ErrorText += 'Filter Lecturer must be specified to identify which lecturer to replace.\';
                end;
                
            ChangeRule."Rule Type"::"Room Change":
                begin
                    if ChangeRule."New Room" = '' then
                        ErrorText += 'New Room must be specified for Room Change rule.\';
                    if ChangeRule."Filter Room" = '' then
                        ErrorText += 'Filter Room must be specified to identify which room to replace.\';
                end;
                
            ChangeRule."Rule Type"::"Time Change":
                begin
                    if (ChangeRule."New Day" = 0) and (ChangeRule."New Time Slot" = '') then
                        ErrorText += 'Either New Day or New Time Slot must be specified for Time Change rule.\';
                end;
                
            ChangeRule."Rule Type"::"Unit Cancellation":
                begin
                    if not ChangeRule."Cancel Unit" then
                        ErrorText += 'Cancel Unit must be checked for Unit Cancellation rule.\';
                    if ChangeRule."Filter Unit" = '' then
                        ErrorText += 'Filter Unit must be specified to identify which unit to cancel.\';
                end;
                
            ChangeRule."Rule Type"::"Stream Reassignment":
                begin
                    if ChangeRule."New Stream" = '' then
                        ErrorText += 'New Stream must be specified for Stream Reassignment rule.\';
                end;
        end;
        
        if ErrorText <> '' then begin
            Error(ErrorText);
            exit(false);
        end;
        
        exit(true);
    end;

    procedure GetAffectedEntriesCount(var ChangeRule: Record "Timetable Change Rule"): Integer
    var
        TimetableEntry: Record "Timetable Entry";
        Count: Integer;
    begin
        // Build same filter as ProcessSingleRule but just count
        TimetableEntry.SetRange("Document No.", ChangeRule."Timetable Document No.");
        
        if ChangeRule."Filter Programme" <> '' then
            TimetableEntry.SetRange("Programme Code", ChangeRule."Filter Programme");
        if ChangeRule."Filter Stage" <> '' then
            TimetableEntry.SetRange("Stage Code", ChangeRule."Filter Stage");
        if ChangeRule."Filter Unit" <> '' then
            TimetableEntry.SetRange("Unit Code", ChangeRule."Filter Unit");
        if ChangeRule."Filter Stream" <> '' then
            TimetableEntry.SetRange("Group No", ChangeRule."Filter Stream");
        if ChangeRule."Filter Lecturer" <> '' then
            TimetableEntry.SetRange("Lecturer Code", ChangeRule."Filter Lecturer");
        if ChangeRule."Filter Room" <> '' then
            TimetableEntry.SetRange("Lecture Hall Code", ChangeRule."Filter Room");
        if ChangeRule."Filter Day" <> 0 then
            TimetableEntry.SetRange("Day of Week", ChangeRule."Filter Day" - 1);
        if ChangeRule."Filter Time Slot" <> '' then
            TimetableEntry.SetRange("Time Slot Code", ChangeRule."Filter Time Slot");
            
        exit(TimetableEntry.Count());
    end;
}