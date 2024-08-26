report 50559 "ACA-Class List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/classList.rdl';

    dataset
    {
        dataitem(StudFin; "ACA-Student Units")
        {
            DataItemTableView = SORTING("Student No.");
            RequestFilterFields = Semester, Unit;
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Unit; Unit)
            {
            }
            column(Unit_Description; "Unit Description")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Campus_Code; "Campus Code")
            {

            }
            column(Programme; Programme)
            {

            }
            column(pic; info.Picture)
            {

            }
            column(name; info.Name)
            {

            }

            column(Lecturer; Lecturer)
            {

            }

            column(lecName; lecName)
            {

            }
            trigger OnAfterGetRecord()
            begin
                hrmEmployee.Reset();
                hrmEmployee.SetRange("No.", Lecturer);
                if hrmEmployee.Find('-') then begin
                    lecName := hrmEmployee."Full Name";
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

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    trigger OnInitReport()
    begin
        info.get();
        info.CalcFields(Picture);
    end;

    var

        info: Record "Company Information";
        hrmEmployee: Record "HRM-Employee C";
        lecName: text[200];
}