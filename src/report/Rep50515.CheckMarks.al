report 50515 "Check Marks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check Marks.rdl';

    dataset
    {
        dataitem("ACA-Student Units"; "ACA-Student Units")
        {
            RequestFilterFields = Programme, Stage, Semester, Unit, "Student No.";
            column(No; "ACA-Student Units"."Student No.")
            {
            }
            column(Prog; "ACA-Student Units".Programme)
            {
            }
            column(Stage; "ACA-Student Units".Stage)
            {
            }
            column(Unit; "ACA-Student Units".Unit)
            {
            }
            column(Sem; "ACA-Student Units".Semester)
            {
            }
            column(Year; "ACA-Student Units"."Academic Year")
            {
            }
            column(Grade; "ACA-Student Units".Grade)
            {
            }
            column(Fin_Score; "ACA-Student Units"."Final Score")
            {
            }
            column(Total_Score; "ACA-Student Units"."Total Marks")
            {
            }
            column(TotScore; "ACA-Student Units"."Total Score")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("ACA-Student Units"."Total Score");
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
}

