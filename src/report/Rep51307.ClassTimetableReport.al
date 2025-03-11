report 51307 "Class Timetable Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ClassTimetableLayout;

    dataset
    {
        dataitem("ACA-Lecturer Halls Setup";"ACA-Lecturer Halls Setup")
        {
           
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

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(CompInfo.Picture);
    end;
}
