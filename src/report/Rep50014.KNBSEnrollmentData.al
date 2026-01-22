report 50014 "KNBS Enrollment Data"
{
    ApplicationArea = All;
    Caption = 'KNBS Enrollment Data';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/KNBS Enrollment Data.rdlc';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(ACAProgramme; "ACA-Programme")
        {
            RequestFilterFields = Code, "School Code", "Academic Year Filter";
            column(CompInfo_Name; CompInfo.Name)
            {

            }
            column(Code_ACAProgramme; "Code")
            {
            }
            column(CampusCode_ACAProgramme; "Campus Code")
            {
            }
            column(Description_ACAProgramme; Description)
            {
            }
            column(Faculty_ACAProgramme; Faculty)
            {
            }
            column(FacultyName_ACAProgramme; "Faculty Name")
            {
            }
            column(SchoolCode_ACAProgramme; "School Code")
            {
            }
            column(SchoolName_ACAProgramme; GetSchoolName("School Code"))
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(YearArray; YearArray[Number])
                {
                }
                column(MaleCountArray; MaleCountArray[Number])
                {
                }
                column(FemaleCountArray; FemaleCountArray[Number])
                {
                }
                column(Integer_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    Integer.SetRange(Number, 1, i);
                end;

            }
            trigger OnAfterGetRecord()
            var
            begin
                Clear(i);
                AcadYear.Reset();
                AcadYear.SetFilter(Code, "Academic Year Filter");
                AcadYear.Find('-');
                Clear(MaleCountArray);
                Clear(FemaleCountArray);
                //male count
                for i := 1 to 6 do begin
                    CourseReg.Reset();
                    CourseReg.SetRange("Academic Year", AcadYear.Code);
                    CourseReg.SetRange("Year Of Study", i);
                    CourseReg.SetRange(Reversed, false);
                    CourseReg.SetRange(Programmes, Code);
                    CourseReg.SetAutoCalcFields(Gender);
                    CourseReg.SetRange(Gender, CourseReg.Gender::Male);
                    CourseReg.SetFilter(Stage, '%1', '*S1*');
                    MaleCountArray[i] := CourseReg.Count;

                    Clear(CourseReg);
                    CourseReg.Reset();
                    CourseReg.SetRange("Academic Year", AcadYear.Code);
                    CourseReg.SetRange("Year Of Study", i);
                    CourseReg.SetRange(Reversed, false);
                    CourseReg.SetRange(Programmes, Code);
                    CourseReg.SetAutoCalcFields(Gender);
                    CourseReg.SetRange(Gender, CourseReg.Gender::Female);
                    CourseReg.SetFilter(Stage, '%1', '*S1*');
                    FemaleCountArray[i] := CourseReg.Count;
                end;
                i += 1;
                //Sub-Total
                MaleCountArray[i] := MaleCountArray[1] + MaleCountArray[2] + MaleCountArray[3] + MaleCountArray[4] + MaleCountArray[5] + MaleCountArray[6];
                FemaleCountArray[i] := FemaleCountArray[1] + FemaleCountArray[2] + FemaleCountArray[3] + FemaleCountArray[4] + FemaleCountArray[5] + FemaleCountArray[6];
                //Grand Total
                i += 1;
                MaleCountArray[i] := MaleCountArray[7] + FemaleCountArray[7];
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    trigger OnInitReport()
    var
    begin
        for i := 1 to 6 do begin
            YearArray[i] := Format(i) + 'TH YEAR';
        end;
        i += 1;
        YearArray[7] := 'SUB-TOTAL';
        i += 1;
        YearArray[8] := 'GRAND TOTAL';
        CompInfo.get;
        CompInfo.CalcFields(Picture);
    end;

    var
        YearArray: array[8] of Code[25];
        MaleCountArray: array[8] of Integer;
        FemaleCountArray: array[8] of Integer;
        CourseReg: Record "ACA-Course Registration";
        AcadYear: Record "ACA-Academic Year";
        CompInfo: Record "Company Information";
        i: Integer;
        DimValues: Record "Dimension Value";

    procedure GetSchoolName(code: Code[25]): Text[50]
    begin
        DimValues.Reset;
        DimValues.SetRange("Dimension Code", 'SCHOOL');
        DimValues.SetRange("Code", code);
        if DimValues.Find() then
            exit(DimValues.Name)
        else
            exit('');
    end;

}
