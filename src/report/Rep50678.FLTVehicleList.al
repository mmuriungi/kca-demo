report 50678 "FLT Vehicle List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/FLT Vehicle List.rdl';
    Caption = 'FLT Vehicle List';

    dataset
    {
        dataitem("FLT-Vehicle Header"; "FLT-Vehicle Header")
        {
            column(Asset_No; "FLT-Vehicle Header"."No.")
            {
            }
            column(Reg_No; "FLT-Vehicle Header"."Registration No.")
            {
            }
            column(Desc; "FLT-Vehicle Header".Description)
            {
            }
            column(Make; "FLT-Vehicle Header".Make)
            {
            }
            column(Model; "FLT-Vehicle Header".Model)
            {
            }
            column(ManYear; "FLT-Vehicle Header"."Year Of Manufacture")
            {
            }
            column(Chasis; "FLT-Vehicle Header"."Chassis Serial No.")
            {
            }
            column(engineNo; "FLT-Vehicle Header"."Engine Serial No.")
            {
            }
            column(compName; info.Name)
            {
            }
            column(pic; info.Picture)
            {
            }
            column(compAddress; info.Address)
            {
            }
            column(compPhone; info."Phone No.")
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
    trigger OnInitReport()
    begin

        if Info.Get() then
            Info.CalcFields(Info.Picture);

    end;

    var
        info: Record "Company Information";
}

