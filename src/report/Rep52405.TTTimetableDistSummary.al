report 52405 "TT-Timetable Dist. Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TT-Timetable Dist. Summary.rdl';

    dataset
    {
        dataitem("TT-Units"; "TT-Units")
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
            column(AcademicYearz; "TT-Units"."Academic Year")
            {
            }
            column(Semes; "TT-Units".Semester)
            {
            }
            column(UnCode; "TT-Units"."Unit Code")
            {
            }
            column(ProgCode; "TT-Units"."Programme Code")
            {
            }
            column(UName; "TT-Units"."Unit Name")
            {
            }
            column(Singles; "TT-Units"."No. of Singles")
            {
            }
            column(Doubles; "TT-Units"."No. of Doubles")
            {
            }
            column(Tripples; "TT-Units"."No. of Tripples")
            {
            }
            column(IsTimetrabled; IsTimetrabled)
            {
            }
            column(LFiltersApplied; LFiltersApplied)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "TT-Units"."Programme Code");
                IF ACAProgramme.FIND('-') THEN;

                ACAUnitsSubjects.RESET;
                ACAUnitsSubjects.SETRANGE(Code, "TT-Units"."Unit Code");
                ACAUnitsSubjects.SETRANGE("Programme Code", "TT-Units"."Programme Code");
                IF ACAUnitsSubjects.FIND('-') THEN;

                ACAProgramme.RESET;
                ACAProgramme.SETRANGE(Code, "TT-Units"."Programme Code");
                IF ACAProgramme.FIND('-') THEN BEGIN

                END;


                ACAUnitsSubjects2.RESET;
                ACAUnitsSubjects2.SETRANGE("Programme Code", "TT-Units"."Programme Code");
                ACAUnitsSubjects2.SETRANGE(Code, "TT-Units"."Unit Code");
                IF ACAUnitsSubjects2.FIND('-') THEN BEGIN

                END;

                "TT-Units".CALCFIELDS("TT-Units"."Unit Name", "TT-Units"."No. of Singles", "TT-Units"."No. of Doubles", "TT-Units"."No. of Tripples");
                IF (("TT-Units"."No. of Singles" + "TT-Units"."No. of Doubles" + "TT-Units"."No. of Tripples") > 0) THEN
                    IsTimetrabled := TRUE
                ELSE
                    IsTimetrabled := FALSE;
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
        CompanyInformation: Record 79;
        ACAProgramme: Record "ACA-Programme";
        ACAUnitsSubjects: Record "ACA-Units/Subjects";
        OutputLayout: Option Potrait,Landscape;
        IncludeProgSummary: Boolean;
        IncludeLectSummary: Boolean;
        IncludeUnitSummary: Boolean;

        LFiltersApplied: Text[1024];
        HRMEmployeeC: Record "HRM-Employee C";

        ACAUnitsSubjects2: Record "ACA-Units/Subjects";
        CountedColumnsProgs: Integer;
        CountedColumnsLects: Integer;
        CountedColumnsUnits: Integer;
        LessonTypeRep: Integer;
        IsTimetrabled: Boolean;
}

