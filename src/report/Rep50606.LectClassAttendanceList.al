report 50606 "Lect Class Attendance List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lect Class Attendance List.rdl';

    dataset
    {
        dataitem("ACA-Lecturers Units"; "ACA-Lecturers Units")
        {
            DataItemTableView = SORTING(Programme, Stage, Unit, Semester, Lecturer) ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = Semester, Lecturer, Programme, Stage, Unit;
            column(progName; progName)
            {
            }
            column(faculty; ACAProgramme.Faculty)
            {
            }
            column(LectName; LectName)
            {
            }
            column(Programme; "ACA-Lecturers Units".Programme)
            {
            }
            column(UnitsStage; "ACA-Lecturers Units".Stage)
            {
            }
            column(UnitCode; "ACA-Lecturers Units".Unit)
            {
            }
            column(UnitDesc; "ACA-Lecturers Units".Description)
            {
            }
            column(Semester; "ACA-Lecturers Units".Semester)
            {
            }
            column(LectCode; "ACA-Lecturers Units".Lecturer)
            {
            }
            column(MarksSubmitted; "ACA-Lecturers Units"."Marks Submitted")
            {
            }
            column(RegStudents; "ACA-Lecturers Units"."Registered Students")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompAddress; CompanyInformation.Address)
            {
            }
            column(CompPhone1; CompanyInformation."Phone No.")
            {
            }
            column(CompPhone2; CompanyInformation."Phone No. 2")
            {
            }
            column(CompEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompPage; CompanyInformation."Home Page")
            {
            }
            column(CompPin; CompanyInformation."Company P.I.N")
            {
            }
            column(Pic; CompanyInformation.Picture)
            {
            }
            column(CompRegNo; CompanyInformation."Registration No.")
            {
            }
            column(GroupingConcortion; "ACA-Lecturers Units".Programme + "ACA-Lecturers Units".Lecturer + "ACA-Lecturers Units".Semester + "ACA-Lecturers Units".Unit)
            {
            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = Semester = FIELD(Semester), Unit = FIELD(Unit);
                DataItemTableView = SORTING("Student No.", Unit) ORDER(Ascending);
                column(studNo; "ACA-Student Units"."Student No.")
                {
                }
                column(StudName; StudName)
                {
                }
                column(seq; seq)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(StudName);
                    if Customer.Get("ACA-Student Units"."Student No.") then
                        StudName := Customer.Name;

                    seq := seq + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(seq);
                Clear(LectName);
                if HRMEmployeeC.Get("ACA-Lecturers Units".Lecturer) then
                    LectName := HRMEmployeeC.Initials + ' ' + HRMEmployeeC."Last Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."First Name";

                Clear(progName);
                if ACAProgramme.Get("ACA-Lecturers Units".Programme) then progName := ACAProgramme.Description;
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

    trigger OnInitReport()
    begin
        if CompanyInformation.Get() then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        Clear(Gtoto);
        Clear(seq);
    end;

    var
        CompanyInformation: Record "Company Information";
        Gtoto: Decimal;
        seq: Integer;
        StudName: Code[150];
        Customer: Record Customer;
        HRMEmployeeC: Record "HRM-Employee C";
        LectName: Text[220];
        progName: Code[150];
        ACAProgramme: Record "ACA-Programme";
}

