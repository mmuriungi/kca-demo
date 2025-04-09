report 50808 "Exam Timetable"
{
    Caption = 'Exam Timetable';
    DefaultRenderingLayout = ExamTimetableLayout;
    dataset
    {
        dataitem("Timetable Header"; "Timetable Header")
        {
            RequestFilterFields = Semester, "Programme Filter", "Stage Filter", "Lecturer Filter";
            DataItemTableView = where(Type = const(Exam));
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
                    column(DayArray; DayArray[Number] + InvigilatorArray[Number])
                    {

                    }
                    column(InvigilatorArray; InvigilatorArray[Number])
                    {

                    }
                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, i);
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    TEntry: Record "Exam Timetable Entry";
                    PreviousSlot: Text;
                    CurrentSlot: Text;
                    Separator: Text;
                    Thelper: Codeunit "Type Helper";
                    InvigilatorSetup: Record "Exam Invigilators";
                    InvigilatorsTxt: Text;
                begin
                    if "ACA-Lecturer Halls Setup"."Hall Category" in [/* "ACA-Lecturer Halls Setup"."Hall Category"::Lab,  */"ACA-Lecturer Halls Setup"."Hall Category"::Online] then
                        CurrReport.Skip();
                    Separator := Thelper.CRLFSeparator();
                    Clear(i);
                    Clear(PreviousSlot);
                    Clear(CurrentSlot);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if ProgFilter <> '' then
                        TEntry.SetRange("Programme Code", ProgFilter);
                    if StageFilter <> '' then
                        TEntry.SetRange("Stage Code", StageFilter);

                    // Sort by date and time to group related entries
                    TEntry.SetCurrentKey("Exam Date", "Start Time");

                    // Track the current lecture hall and time slot
                    PreviousSlot := '';

                    if TEntry.FindSet() then
                        repeat
                            CurrentSlot := Format(TEntry."Exam Date") + Format(TEntry."Start Time") + TEntry."Lecture Hall";
                            InvigilatorsTxt := '';
                            InvigilatorSetup.Reset();
                            InvigilatorSetup.SetRange("Hall", TEntry."Lecture Hall");
                            InvigilatorSetup.SetRange(Semester, TEntry.Semester);
                            InvigilatorSetup.SetRange("Date", TEntry."Exam Date");
                            InvigilatorSetup.SetRange("Start Time", TEntry."Start Time");
                            if InvigilatorSetup.FindSet() then begin
                                InvigilatorsTxt := Separator;
                                InvigilatorsTxt += Separator + 'Invigilators: ';
                                repeat
                                    InvigilatorsTxt += Separator + InvigilatorSetup.Name;
                                until InvigilatorSetup.Next() = 0;
                            end;
                            // If this is a new slot or lecture hall, increment the index
                            if PreviousSlot <> CurrentSlot then begin
                                i += 1;
                                DayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                                InvigilatorArray[i] := InvigilatorsTxt;
                            end else begin
                                DayArray[i] += Separator + TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                            end;

                            // Update previous slot for next iteration
                            PreviousSlot := CurrentSlot;
                        until TEntry.Next() = 0;
                end;
            }
            trigger OnPreDataItem()
            begin
                ProgFilter := "Timetable Header".GetFilter("Programme Filter");
                StageFilter := "Timetable Header".GetFilter("Stage Filter");
                LecFilter := "Timetable Header".GetFilter("Lecturer Filter");
                TimeSlot.Reset();
                TimeSlot.SetCurrentKey("Valid From Date");
                if TimeSlot.FindSet() then begin
                    repeat
                        i := i + 1;
                        SlotArray[i] := i;
                        TimeArray[i] := Format(TimeSlot."Valid From Date") + ' - ' + Format(TimeSlot."Start Time") + ' - ' + Format(TimeSlot."End Time");
                    until TimeSlot.Next() = 0;
                end;
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
        layout(ExamTimetableLayout)
        {
            Type = RDLC;
            LayoutFile = './Layouts/ExamTimetableReport.rdlc';
        }
    }



    var
        LectureHall: Record "ACA-Lecturer Halls Setup";
        TimeSlot: Record "Exam Time Slot";
        VenueName: Text[100];
        TimeSlotLabel: Text[30];
        CompInfo: Record "Company Information";
        TimeArray: array[2000] of Text;
        MondayArray: array[2000] of Text;
        TuesdayArray: array[2000] of Text;
        WednesdayArray: array[2000] of Text;
        ThursdayArray: array[2000] of Text;
        FridayArray: array[2000] of Text;
        DayArray: array[2000] of Text;
        InvigilatorArray: array[2000] of Text;
        i: Integer;
        ProgFilter: Text;
        StageFilter: Text;
        LecFilter: Text;
        SlotArray: array[2000] of Integer;


    trigger OnPreReport()
    begin
        Clear(i);
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);

    end;
}
