report 51307 "Class Timetable Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ClassTimetableLayout;

    dataset
    {
        dataitem("Timetable Header"; "Timetable Header")
        {
            RequestFilterFields = Semester;
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
                    column(Number; Number)
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
                begin
                    Clear(i);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Monday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if Programme <> '' then
                        TEntry.SetRange("Programme Code", Programme);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            MondayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                        end until TEntry.Next() = 0;

                    Clear(i);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Tuesday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if Programme <> '' then
                        TEntry.SetRange("Programme Code", Programme);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            TuesdayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                        end until TEntry.Next() = 0;
                    Clear(i);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Wednesday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if Programme <> '' then
                        TEntry.SetRange("Programme Code", Programme);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            WednesdayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                        end until TEntry.Next() = 0;
                    Clear(i);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Thursday);
                    TEntry.SetRange(Semester, "Timetable Header".Semester);
                    if Programme <> '' then
                        TEntry.SetRange("Programme Code", Programme);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            ThursdayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                        end until TEntry.Next() = 0;
                    Clear(i);
                    TEntry.Reset();
                    TEntry.SetRange("Lecture Hall Code", "ACA-Lecturer Halls Setup"."Lecture Room Code");
                    TEntry.SetRange("Day of Week", TEntry."Day of Week"::Friday);
                    if Programme <> '' then
                        TEntry.SetRange("Programme Code", Programme);
                    if TEntry.FindSet() then
                        repeat begin
                            i += 1;
                            FridayArray[i] := TEntry."Programme Code" + ' - ' + TEntry."Unit Code";
                        end until TEntry.Next() = 0;
                end;
            }
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
                    field(Programme; programme)
                    {
                        TableRelation = "ACA-Programme";
                    }

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
        MondayArray: array[20] of Text;
        TuesdayArray: array[20] of Text;
        WednesdayArray: array[20] of Text;
        ThursdayArray: array[20] of Text;
        FridayArray: array[20] of Text;
        i: Integer;
        Semester: Code[25];
        Programme: Code[25];


    trigger OnPreReport()
    begin
        Clear(i);
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);
        TimeSlot.Reset();
        if TimeSlot.FindSet() then begin
            repeat
                i := i + 1;
                TimeArray[i] := Format(TimeSlot."Start Time") + ' - ' + Format(TimeSlot."End Time");
            until TimeSlot.Next() = 0;
        end
    end;
}
