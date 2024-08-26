report 50172 "Leave Types"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Types.rdl';

    dataset
    {
        dataitem("HRM-Leave Types"; "HRM-Leave Types")
        {
            DataItemTableView = SORTING(Code);
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }

            /* column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            } */
            column(USERID; UserId)
            {
            }
            column(Leave_Types_Code; Code)
            {
            }
            column(Leave_Types_Description; Description)
            {
            }
            column(Leave_Types_Days; Days)
            {
            }
            column(Leave_Types__Acrue_Days_; "Acrue Days")
            {
            }
            column(Leave_Types__Unlimited_Days_; "Unlimited Days")
            {
            }
            column(Leave_Types_Gender; Gender)
            {
            }
            column(Leave_Types_Balance; Balance)
            {
            }
            column(Leave_Types__Inclusive_of_Holidays_; "Inclusive of Holidays")
            {
            }
            column(Leave_Types__Inclusive_of_Saturday_; "Inclusive of Saturday")
            {
            }
            column(Leave_Types__Inclusive_of_Sunday_; "Inclusive of Sunday")
            {
            }
            column(Leave_TypesCaption; Leave_TypesCaptionLbl)
            {
            }
            column(Picture; compinfo.Picture)
            {

            }
            column(Compemail; compinfo."E-Mail")
            { }
            column(compaddress; compinfo.Address)
            { }
            column(compphone; compinfo."Phone No.")
            { }
            column(compname; compinfo.Name)
            { }

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
        if Compinfo.GET() THEN BEGIN
            compinfo.CALCFIELDS(compinfo.Picture);
        END;
    end;

    var
        Compinfo: Record "Company Information";
        Leave_TypesCaptionLbl: Label 'Leave Types';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Inc__HolidaysCaptionLbl: Label 'Inc. Holidays';
        Inc__Sat_CaptionLbl: Label 'Inc. Sat.';
        Inc__SundayCaptionLbl: Label 'Inc. Sunday';
        Off_Holidays_LeaveCaptionLbl: Label 'Off/Holidays Leave';
}

