report 51169 "HR Job Applications"
{
    DefaultLayout = RDLC;
    RDLCLayout = './HR/Reports/SSR/HR Job Applications.rdl';

    dataset
    {
        dataitem("HRM-Job Applications (B)";"HRM-Job Applications (B)")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Application No";
            column(ApplicationNo_HRJobApplications;"HRM-Job Applications (B)"."Application No")
            {
                IncludeCaption = true;
            }
            column(FirstName_HRJobApplications;"HRM-Job Applications (B)"."First Name")
            {
                IncludeCaption = true;
            }
            column(MiddleName_HRJobApplications;"HRM-Job Applications (B)"."Middle Name")
            {
                IncludeCaption = true;
            }
            column(LastName_HRJobApplications;"HRM-Job Applications (B)"."Last Name")
            {
                IncludeCaption = true;
            }
            column(JobAppliedFor_HRJobApplications;"HRM-Job Applications (B)"."Job Applied For")
            {
                IncludeCaption = true;
            }
            column(JobAppliedforDescription_HRJobApplications;"HRM-Job Applications (B)"."Job Applied for Description")
            {
            }
            column(City_HRJobApplications;"HRM-Job Applications (B)".City)
            {
                IncludeCaption = true;
            }
            column(PostCode_HRJobApplications;"HRM-Job Applications (B)"."Post Code")
            {
                IncludeCaption = true;
            }
            column(IDNumber_HRJobApplications;"HRM-Job Applications (B)"."ID Number")
            {
                IncludeCaption = true;
            }
            column(Gender_HRJobApplications;"HRM-Job Applications (B)".Gender)
            {
                IncludeCaption = true;
            }
            column(CountryCode_HRJobApplications;"HRM-Job Applications (B)"."Country Code")
            {
                IncludeCaption = true;
            }
            column(HomePhoneNumber_HRJobApplications;"HRM-Job Applications (B)"."Home Phone Number")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRJobApplications;"HRM-Job Applications (B)"."Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(WorkPhoneNumber_HRJobApplications;"HRM-Job Applications (B)"."Work Phone Number")
            {
                IncludeCaption = true;
            }
            column(EMail_HRJobApplications;"HRM-Job Applications (B)"."E-Mail")
            {
                IncludeCaption = true;
            }
            column(PostalAddress_HRJobApplications;"HRM-Job Applications (B)"."Postal Address")
            {
                IncludeCaption = true;
            }
            column(CI_Name;CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address;CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2;CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City;CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_EMail;CI."E-Mail")
            {
                IncludeCaption = true;
            }
            column(CI_HomePage;CI."Home Page")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo;CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture;CI.Picture)
            {
                IncludeCaption = true;
            }
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
                    CI.Get();
                    CI.CalcFields(CI.Picture);

                    //GET FILTER
                    JobApplicationNo:="HRM-Job Applications (B)".GetFilter("HRM-Job Applications (B)"."Employee Requisition No");
                    if JobApplicationNo='' then
                    begin
                    //    MESSAGE('Please select a Job Requisition No  Number before printing a report');
                    //    CurrReport.QUIT;
                    end;
    end;

    var
        CI: Record "Company Information";
        SectionA: Label 'Section A :: Personal Details';
        SectionB: Label 'Section B :: Contact Details';
        SectionC: Label 'Section C :: Academic and Qualification Information';
        SectionD: Label 'Section D :: Applicant''s Refferees';
        JobApplicationNo: Text;
}

