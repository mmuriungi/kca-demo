report 50543 "Student Applications(Program)"
{
    Caption = 'Student Applications(Program)';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Student ApplicationsProg Report.rdl';
    dataset
    {
        dataitem(ACAApplicFormHeader; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "Settlement Type", "First Choice Semester", "First Degree Choice", "Admitted Department", "Programme Faculty";
            column(no; "Application No.")
            {
            }
            column(firstName; firstName)
            {

            }
            column(Other_Names; "Other Names")
            {

            }
            column(Surname; Surname)
            {

            }
            column(Settlement_Type; "Settlement Type")
            {

            }
            column(Date; Date)
            {
            }
            column(regno; "Admission No")
            {
            }
            column(Name; Surname + ' ' + "Other Names")
            {
            }
            column(sur; "Other Names")
            {
            }
            column(dob; "Date Of Birth")
            {
            }
            column(gender; Gender)
            {
            }
            column(address; "Address for Correspondence1" + ' ' + "Address for Correspondence2")
            {
            }
            column(n; "Address for Correspondence2")
            {
            }
            column(phone; "Telephone No. 1")
            {
            }
            column(degree; "First Degree Choice")
            {
            }
            column(picture; CI.Picture)
            {
            }
            column(Campus; Campus)
            {
            }
            column(Semester; "First Choice Semester")
            {
            }
            column(ProgName; ProgName)
            {
            }
            column(Status; Status)
            {
            }
            column(Programme_Faculty; "Programme Faculty")
            {

            }
            column(compName; CI.Name)
            {

            }
            column(Admitted_Department; "Admitted Department")
            {

            }
            column(Mode_of_Study; "Mode of Study")
            {

            }

            trigger OnAfterGetRecord()
            begin
                ProgName := '';
                IF prog.GET("First Degree Choice") THEN BEGIN
                    ProgName := prog.Description;
                END;
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
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        prog: Record "ACA-Programme";
        ProgName: Text[100];
}
