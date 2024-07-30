report 50962 Jobs
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/jobs.rdl';

    dataset
    {
        dataitem("HRM-Company Jobs"; "HRM-Company Jobs")
        {
            DataItemTableView = SORTING("Job ID");
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }

            column(USERID; UserId)
            {
            }
            column(Company_Jobs__Job_ID_; "Job ID")
            {
            }
            column(Company_Jobs__Job_Description_; "Job Description")
            {
            }
            column(Company_Jobs__No_of_Posts_; "No of Posts")
            {
            }
            column(Company_Jobs__Occupied_Position_; "Occupied Position")
            {
            }
            column(Company_Jobs__Vacant_Posistions_; "Vacant Posistions")
            {
            }
            column(Company_Jobs__Key_Position_; "Key Position")
            {
            }
            column(Company_JobsCaption; Company_JobsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Company_Jobs__Job_ID_Caption; FieldCaption("Job ID"))
            {
            }
            column(Company_Jobs__Job_Description_Caption; FieldCaption("Job Description"))
            {
            }
            column(Company_Jobs__No_of_Posts_Caption; FieldCaption("No of Posts"))
            {
            }
            column(Company_Jobs__Occupied_Position_Caption; FieldCaption("Occupied Position"))
            {
            }
            column(Company_Jobs__Vacant_Posistions_Caption; FieldCaption("Vacant Posistions"))
            {
            }
            column(Company_Jobs__Key_Position_Caption; FieldCaption("Key Position"))
            {
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

    var
        Company_JobsCaptionLbl: Label 'Company Jobs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

