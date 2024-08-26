report 50567 "EXT-Timetable Dist. Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EXT-Timetable Dist. Summary.rdl';

    dataset
    {
        dataitem("TT-Units"; "EXT-Timetable FInal Collector")
        {
            column(ProgName; ACAProgramme.Description)
            {
            }
            column(UnitName; ACAUnitsSubjects.Desription)
            {
            }
            column(LectName; HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress1; CompanyInformation.Address)
            {
            }
            column(CompAddress2; CompanyInformation."Address 2")
            {
            }
            column(CompCity; CompanyInformation.City)
            {
            }
            column(Phone1; CompanyInformation."Phone No.")
            {
            }
            column(Phone2; CompanyInformation."Phone No. 2")
            {
            }
            column(Email; CompanyInformation."E-Mail")
            {
            }
            column(HomepAge; CompanyInformation."Home Page")
            {
            }
            column(AcademicYearz; '')
            {
            }
            column(Semes; "TT-Units".Semester)
            {
            }
            column(UnCode; "TT-Units".Unit)
            {
            }
            column(ProgCode; "TT-Units".Programme)
            {
            }
            column(UName; '')
            {
            }
            column(IsTimetrabled; true)
            {
            }
            column(LFiltersApplied; LFiltersApplied)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "TT-Units".Programme);
                IF ACAProgramme.FIND('-') THEN;

                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, "TT-Units".Unit);
                ACAUnitsSubjects.SETRANGE("Programme Code", "TT-Units".Programme);
                IF ACAUnitsSubjects.FIND('-') THEN;

                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "TT-Units".Programme);
                IF ACAProgramme.FIND('-') THEN BEGIN

                END;


                ACAUnitsSubjects2.RESET;
                ACAUnitsSubjects2.SETRANGE("Programme Code", "TT-Units".Programme);
                ACAUnitsSubjects2.SETRANGE(Code, "TT-Units".Unit);
                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN

                END;

                // "TT-Units".CALCFIELDS("TT-Units"."Unit Name", "TT-Units".Timetabled);
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(LFiltersApplied);
                LFiltersApplied := "TT-Units".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN;
    end;

    var
        CompanyInformation: Record "Company Information";
        ACAProgramme: Record "ACA-Programme";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        OutputLayout: Option Potrait,Landscape;
        IncludeProgSummary: Boolean;
        IncludeLectSummary: Boolean;
        IncludeUnitSummary: Boolean;
        TTDailyLessons: Record "TT-Daily Lessons";
        LFiltersApplied: Text[1024];
        HRMEmployeeC: Record "HRM-Employee C";

        ACAUnitsSubjects2: Record "ACA-Units/Subjects";
        CountedColumnsProgs: Integer;
        CountedColumnsLects: Integer;
        CountedColumnsUnits: Integer;
        LessonTypeRep: Integer;
        IsTimetrabled: Boolean;
}

