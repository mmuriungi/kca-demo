report 55402 "Audit Planner Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Audit/Report/SSR/AuditPlannerReport.rdl';
    EnableExternalImages = true;

    dataset
    {
        dataitem(DataItem1; "Audit-Activity")
        {
            RequestFilterFields = "Depart Code";
            column(No_AuditActivity; "No.")
            {
            }
            column(DepartCode_AuditActivity; "Depart Code")
            {
            }
            column(Department_AuditActivity; Department)
            {
            }
            column(Activities_AuditActivity; Activities)
            {
            }
            column(Description_AuditActivity; Description)
            {
            }
            column(Timeline_AuditActivity; Timeline)
            {
            }
            column(StartDate_AuditActivity; FORMAT("Start Date"))
            {
            }
            column(EndDate_AuditActivity; FORMAT("End Date"))
            {
            }
            column(Duration_AuditActivity; Duration)
            {
            }
            column(Budget_AuditActivity; Budget)
            {
            }
            column(CreatedBy_AuditActivity; "Created By")
            {
            }
            column(companyName; CompanyInformation.Name)
            {
            }
            column(companyAddress; CompanyInformation."Address 2")
            {
            }
            column(pic; CompanyInformation.Picture)
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

    trigger OnPreReport()
    begin
        IF CompanyInformation.GET THEN
            CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record 79;
}

