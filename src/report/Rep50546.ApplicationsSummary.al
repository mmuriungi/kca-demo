report 50546 "Applications Summary"
{
    Caption = 'Applications Summary';
    RDLCLayout = './Layouts/applicationsSummary.rdl';
    dataset
    {
        dataitem(applics; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "Intake Code", "First Degree Choice", "First Choice Semester";
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(name; CompanyInformation.Name)
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
            column(Gender; Gender)
            {

            }
            column(Address_for_Correspondence1; "Address for Correspondence1")
            {

            }
            column(Telephone_No__1; "Telephone No. 1")
            {

            }
            column(Mean_Grade_Acquired; "Mean Grade Acquired")
            {

            }
            column(Year_of_Examination; "Year of Examination")
            {

            }
            column(Mode_of_Study; "Mode of Study")
            {

            }
            column(Intake_Code; "Intake Code")
            {

            }
            column(progName; progName)
            {

            }
            column(school; school)
            {

            }
            column(depart; depart)
            {

            }
            column(req; req)
            {

            }
            column(First_Degree_Choice; "First Degree Choice")
            {

            }
            trigger OnAfterGetRecord()
            begin
                prog.Reset();
                prog.SetRange(Code, applics."First Degree Choice");
                if prog.Find('-') then begin
                    prog.CalcFields("Faculty Name");
                    prog.CalcFields("Department Name");
                    progName := prog.Description;
                    school := prog."Faculty Name";
                    depart := prog."Department Name";
                    req := prog."Program Requirement";

                end;
            end;

        }
    }
    trigger OnInitReport()
    begin

        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;


    end;

    var
        CompanyInformation: Record "Company Information";
        prog: Record "ACA-Programme";
        progName, school, depart, req : Text;
}
