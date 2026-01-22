report 50695 "Clinic Update Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ClinicUpdateReport.rdl';
    dataset
    {

        dataitem(patient; "HMS-Patient")
        {

            column(PatientNo_patient; "Patient No.")
            {
            }
            column(PatientType_patient; "Patient Type")
            {
            }
            column(StudentNo_patient; "Student No.")
            {
            }
            column(EmployeeNo_patient; "Employee No.")
            {
            }
            column(RelativeNo_patient; "Relative No.")
            {
            }
            column(Title_patient; Title)
            {
            }
            column(Surname_patient; Surname)
            {
            }
            column(MiddleName_patient; "Middle Name")
            {
            }
            column(LastName_patient; "Last Name")
            {
            }
            column(Gender_patient; Gender)
            {
            }
            column(DateOfBirth_patient; "Date Of Birth")
            {
            }
            column(DateRegistered_patient; "Date Registered")
            {
            }
            column(MaritalStatus_patient; "Marital Status")
            {
            }
            column(IDNumber_patient; "ID Number")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Observ.Reset();
                Observ.SetRange("Patient No.", "Patient No.");
                if Observ.Find('-') then begin
                    repeat
                        if Observ."Patient Name" = '' then begin
                            Observ."Patient Name" := "Full Name";
                            Observ.Modify(true);
                        end;

                        Treat.Reset();
                        Treat.SetRange("Patient No.", Observ."Patient No.");
                        Treat.SetRange("Observation No.", Observ."Observation No.");
                        if Treat.Find('-') then begin
                            if Treat."Treatment Remarks" = '' then begin
                                Treat."Treatment Remarks" := Observ."Observation Remarks";
                                Treat.Modify(true);
                            end;

                        end;

                    until Observ.Next() = 0;
                end;

                Treat.Reset();
                Treat.SetRange("Patient No.", "Patient No.");
                if Treat.Find('-') then begin
                    repeat
                        if Treat."Patient Name" = '' then begin
                            Treat."Patient Name" := "Full Name";
                            Treat.Modify(true);
                        end;
                    until Treat.Next() = 0;
                end;

            end;

        }

    }
    trigger OnPostReport()
    begin
        MESSAGE('Update successsifull');
    end;


    var
        Observ: Record "HMS-Observation Form Header";
        Treat: Record "HMS-Treatment Form Header";
}