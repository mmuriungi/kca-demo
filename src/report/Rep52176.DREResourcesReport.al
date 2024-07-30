report 52176 "DRE-Resources Report"
{
    Caption = 'DRE-Resources Report';
    RDLCLayout = './Layouts/dreResources.rdl';
    dataset
    {
        dataitem(DREResources; "DRE-Resources")
        {
            column(ResourceNo; "Resource No")
            {
            }
            column(ResourceCost; "Resource Cost")
            {
            }
            column(ResourceType; "Resource Type")
            {
            }
            column(Specialization; Specialization)
            {
            }
            column(Status; Status)
            {
            }
            column(Description; Description)
            {
            }
            column(DateofIntallation; "Date of Intallation")
            {
            }
            column(ActiveProjects; "Active Projects")
            {
            }
            column(CompNames; CompanyInformation.Name)
            {
            }
            column(Pic; CompanyInformation.Picture)
            {

            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CompanyInformation: Record "Company Information";
}
