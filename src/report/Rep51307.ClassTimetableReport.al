report 51307 "Class Timetable Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ClassTimetableLayout;

    dataset
    {
        dataitem("Timetable Header"; "Timetable Header")
        {
            RequestFilterFields = Semester, "Programme Filter", "Stage Filter", "Lecturer Filter";
            column(logo; CompInfo.picture)
            {

            }
            column(CompanyName; CompInfo.Name)
            {

            }
            column(Semester; "Timetable Header".Semester)
            {

            }
            dataitem("ACA-Lecturer Halls Setup"; "ACA-Lecturer Halls Setup")
            {
                column(LectureRoomCode; "Lecture Room Code")
                {

                }
                dataitem(Integer; Integer)
                {
                    DataItemTableView = sorting(Number);
                    column(Number; Number)
                    {

                    }
                    column(SlotArray; SlotArray[Number])
                    {

                    }
                    column(TimeArray; TimeArray[Number])
                    {

                    }
                    column(MondayArray; MondayArray[Number])
                    {

                    }
                    column(TuesdayArray; TuesdayArray[Number])
                    {

                    }
                    column(WednesdayArray; WednesdayArray[Number])
                    {

                    }
                    column(ThursdayArray; ThursdayArray[Number])
                    {

                    }
                    column(FridayArray; FridayArray[Number])
                    {

                    }
                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, i);
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    TEntry: Record "Timetable Entry";
                    PreviousSlot: Text;
                    CurrentSlot: Text;
                begin
                    Clear(i);
                    Clear(PreviousSlot);
                    Clear(CurrentSlot);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Monday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if ProgFilter <> '' then
                        TEntry.SetRange("Programme Code", ProgFilter);
                    if StageFilter <> '' then
                        TEntry.SetRange("Stage Code", StageFilter);
                    if LecFilter <> '' then
                        TEntry.SetFilter("Lecturer Code", LecFilter);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            MondayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)");
                            PreviousSlot := CurrentSlot;
                            CurrentSlot := TEntry."Time Slot Code";
                            if PreviousSlot = CurrentSlot then begin
                                i -= 1;
                                MondayArray[i] += TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)") + ' \ ';
                            end;
                        end until TEntry.Next() = 0;

                    Clear(i);
                    Clear(PreviousSlot);
                    Clear(CurrentSlot);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Tuesday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if ProgFilter <> '' then
                        TEntry.SetRange("Programme Code", ProgFilter);
                    if StageFilter <> '' then
                        TEntry.SetRange("Stage Code", StageFilter);
                    if LecFilter <> '' then
                        TEntry.SetFilter("Lecturer Code", LecFilter);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            TuesdayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)");
                            PreviousSlot := CurrentSlot;
                            CurrentSlot := TEntry."Time Slot Code";
                            if PreviousSlot = CurrentSlot then begin
                                i -= 1;
                                TuesdayArray[i] += TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)") + ' \ ';
                            end;
                        end until TEntry.Next() = 0;
                    Clear(i);
                    Clear(PreviousSlot);
                    Clear(CurrentSlot);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Wednesday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if ProgFilter <> '' then
                        TEntry.SetRange("Programme Code", ProgFilter);
                    if StageFilter <> '' then
                        TEntry.SetRange("Stage Code", StageFilter);
                    if LecFilter <> '' then
                        TEntry.SetFilter("Lecturer Code", LecFilter);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            WednesdayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)");
                            PreviousSlot := CurrentSlot;
                            CurrentSlot := TEntry."Time Slot Code";
                            if PreviousSlot = CurrentSlot then begin
                                i -= 1;
                                WednesdayArray[i] += TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)") + ' \ ';
                            end;
                        end until TEntry.Next() = 0;
                    Clear(i);
                    Clear(PreviousSlot);
                    Clear(CurrentSlot);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Thursday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if ProgFilter <> '' then
                        TEntry.SetRange("Programme Code", ProgFilter);
                    if StageFilter <> '' then
                        TEntry.SetRange("Stage Code", StageFilter);
                    if LecFilter <> '' then
                        TEntry.SetFilter("Lecturer Code", LecFilter);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            ThursdayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)");
                            PreviousSlot := CurrentSlot;
                            CurrentSlot := TEntry."Time Slot Code";
                            if PreviousSlot = CurrentSlot then begin
                                i -= 1;
                                ThursdayArray[i] += TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)") + ' \ ';
                            end;
                        end until TEntry.Next() = 0;
                    Clear(i);
                    Clear(PreviousSlot);
                    Clear(CurrentSlot);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Friday);
                    if ProgFilter <> '' then
                        TEntry.SetRange("Programme Code", ProgFilter);
                    if StageFilter <> '' then
                        TEntry.SetRange("Stage Code", StageFilter);
                    if LecFilter <> '' then
                        TEntry.SetFilter("Lecturer Code", LecFilter);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            FridayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)");
                            PreviousSlot := CurrentSlot;
                            CurrentSlot := TEntry."Time Slot Code";
                            if PreviousSlot = CurrentSlot then begin
                                i -= 1;
                                FridayArray[i] += TEntry."Programme Code" + ' - ' + TEntry."Unit Code" + ' - ' + TEntry."Lecturer Code" + ' - ' + Format(TEntry."Group No") + ' - ' + Format(TEntry."Duration (Hours)") + ' \ ';
                            end;
                        end until TEntry.Next() = 0;
                end;
            }
            trigger OnPreDataItem()
            begin
                ProgFilter := "Timetable Header".GetFilter("Programme Filter");
                StageFilter := "Timetable Header".GetFilter("Stage Filter");
                LecFilter := "Timetable Header".GetFilter("Lecturer Filter");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {


                }
            }
        }

        trigger OnOpenPage()
        var
            AcademicYear: Record "ACA-Academic Year";
        begin
        end;
    }

    rendering
    {
        layout(ClassTimetableLayout)
        {
            Type = RDLC;
            LayoutFile = './Layouts/ClassTimetableReport.rdlc';
        }
    }



    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Time Slot";
        VenueName: Text[100];
        TimeSlotLabel: Text[30];
        CompInfo: Record "Company Information";
        TimeArray: array[20] of Text;
        MondayArray: array[2000] of Text;
        TuesdayArray: array[2000] of Text;
        WednesdayArray: array[2000] of Text;
        ThursdayArray: array[2000] of Text;
        FridayArray: array[2000] of Text;
        i: Integer;
        ProgFilter: Text;
        StageFilter: Text;
        LecFilter: Text;
        SlotArray: array[20] of Integer;


    trigger OnPreReport()
    begin
        Clear(i);
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);
        TimeSlot.Reset();
        TimeSlot.SetCurrentKey("Start Time");
        TimeSlot.setrange("Day of Week", TimeSlot."Day of Week"::Monday);
        if TimeSlot.FindSet() then begin
            repeat
                i := i + 1;
                SlotArray[i] := i;
                TimeArray[i] := Format(TimeSlot."Start Time") + ' - ' + Format(TimeSlot."End Time");
            until TimeSlot.Next() = 0;
        end
    end;
}
