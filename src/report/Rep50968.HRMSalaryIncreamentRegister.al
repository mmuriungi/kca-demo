report 50968 "HRM-Salary Increament Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HRM-Salary Increament Register.rdl';

    dataset
    {
        dataitem("HRM-Salary Increament Register"; "HRM-Salary Increament Register")
        {
            column(Schedule; 'Salary Increament Schedule')
            {
            }
            column(EmployeeNo; "HRM-Salary Increament Register"."Employee No.")
            {
            }
            column(IncreamentMonth; "HRM-Salary Increament Register"."Increament Month")
            {
            }
            column(IncreamentYear; "HRM-Salary Increament Register"."Increament Year")
            {
            }
            column(PreviousBasic; "HRM-Salary Increament Register"."Prev. Salary")
            {
            }
            column(ExpectedBasic; "HRM-Salary Increament Register"."Current Salary")
            {
            }
            column(JobCategory; "HRM-Salary Increament Register"."Job Category")
            {
            }
            column(JobGrade; "HRM-Salary Increament Register"."Job Grade")
            {
            }
            column(Posted; "HRM-Salary Increament Register".Posted)
            {
            }
            column(Reversed; "HRM-Salary Increament Register".Reversed)
            {
            }
            column(Names; names)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(names);
                if emps.Get("HRM-Salary Increament Register"."Employee No.") then begin
                    names := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
                end;
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
        names: Text;
        emps: Record "HRM-Employee C";
}

