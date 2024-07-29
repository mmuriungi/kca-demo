report 52411 "Time table2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Time table2.rdl';

    dataset
    {
        dataitem("ACA-Time Table"; "ACA-Time Table")
        {
            column(Department; "ACA-Time Table".DPTNM)
            {
            }
            column(Programme; "ACA-Time Table".progname)
            {
            }
            column(Stage; "ACA-Time Table".Stage)
            {
            }
            column(Day; "ACA-Time Table"."Day of Week")
            {
            }
            column(Time; "ACA-Time Table".Period)
            {
            }
            column(UnitCode; "ACA-Time Table".Unit)
            {
            }
            column(Description; "ACA-Time Table".unitNm)
            {
            }
            column(Venue; "ACA-Time Table"."Lecture Room")
            {
            }
            column(Lecturer; "ACA-Time Table".LecturerNM)
            {
            }
            column(Daycode; "ACA-Time Table"."Day of Week")
            {
            }
            column(pic; info.Picture)
            {
            }
            column(Companyname; info.Name)
            {
            }
            column(college; info."Name 2")
            {
            }
            column(campus; "ACA-Time Table"."Campus Code")
            {
            }
            column(Session; "ACA-Time Table".semNM)
            {
            }
            column(dep; dpt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                info.RESET;
                IF info.FIND('-') THEN
                    info.CALCFIELDS(Picture);

                dpt := UPPERCASE("ACA-Time Table".DPTNM);
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

    var
        info: Record "Company Information";
        dpt: Text[200];
        UnitRec: Record "ACA-Units/Subjects";
        Un: Code[100];
}

