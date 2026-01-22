codeunit 50097 "Timetable setup"
{
    //Subtype = Install;

    trigger OnRun()
    begin
        InitializeTimeSlots();
    end;

    // trigger OnInstallAppPerCompany()
    // begin
    //     InitializeTimeSlots();
    // end;

    local procedure InitializeTimeSlots()
    var
        TimeSlot: Record "Time Slot";
        DayOfWeek: Integer;
        StartTime: Time;
        EndTime: Time;
        SlotCode: Integer;
        GenSetup: Record "ACA-General Set-Up";
        AllEndTime: Time;
    begin
        if not TimeSlot.IsEmpty then
            exit;  // Time slots already initialized
        GenSetup.Get();
        StartTime := GenSetup."TImetable Start Time";
        AllEndTime := GenSetup."Timetable End Time";
        SlotCode := 1000;
        for DayOfWeek := 0 to 4 do  // Monday to Friday 
        begin
            StartTime := 070000T;  // 8:00 AM
            repeat
                Clear(TimeSlot);
                TimeSlot.Code := Format(SlotCode);
                TimeSlot."Day of Week" := DayOfWeek;
                TimeSlot."Start Time" := StartTime;
                EndTime := StartTime + 10800000;  // Add 1 hour (in milliseconds)
                TimeSlot."End Time" := EndTime;
                TimeSlot.Insert(true);

                StartTime := EndTime;
                SlotCode += 1;
            until StartTime >= AllEndTime;  // Until 6:00 PM
        end;
    end;
}
