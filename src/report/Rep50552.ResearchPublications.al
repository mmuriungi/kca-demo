report 50552 "Research Publications"
{
    Caption = 'Research Publications';
    RDLCLayout = './Layouts/researchPublication.rdl';
    dataset
    {
        dataitem(ResearchPublications; "Research Publications")
        {
            column(No; No)
            {
            }
            column(Authors; Authors)
            {
            }
            column(JournalPublished; "Journal Published")
            {
            }
            column(TitleofPublication; "Title of Publication")
            {
            }
            column(Status; Status)
            {
            }
            column(CompNames; CompanyInformation.Name)
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
