report 50186 "Population Analy. (Gend/Type)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Population Analy. (GendType).rdl';

    dataset
    {
        dataitem(DV; "Dimension Value")
        {
            DataItemTableView = WHERE("Dimension Code" = FILTER('FACULTY'));
            PrintOnlyIfDetail = false;
            column(Dim_Name; DV.Code + ' ' + DV.Name)
            {
            }
            dataitem(AP; "ACA-Programme")
            {
                DataItemLink = "School Code" = FIELD(Code);
                column(Desc; AP.Description)
                {
                }
                column(JabMAle; AP."Total JAB Male")
                {
                }
                column(JabFemale; AP."Total JAB Female")
                {
                }
                column(sspMale; AP."Total SSP Male")
                {
                }
                column(sspFemale; AP."Total SSP Female")
                {
                }
                column(StudRegistered; AP."Student Registered")
                {
                }
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
}

