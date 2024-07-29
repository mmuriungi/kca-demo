report 54202 "HR Transport Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Transport/Report/SSR/HR Transport Requests.rdl';
    Caption = 'HR Transport Requests';

    dataset
    {
        dataitem("HRM-Transport Request"; "HRM-Transport Request")
        {
            RequestFilterFields = "Code";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }

            column(USERID; UserId)
            {
            }
            column(HR_Transport_Requests_Code; Code)
            {
            }
            column(HR_Transport_Requests__Requester_Code_; "Requester Code")
            {
            }
            column(HR_Transport_Requests_Requester; Requester)
            {
            }
            column(HR_Transport_Requests_From; From)
            {
            }
            column(HR_Transport_Requests__To_; "To")
            {
            }
            column(HR_Transport_Requests__Purpose_of_Request_; "Purpose of Request")
            {
            }
            column(HR_Transport_Requests__Requisition_Date_; "Requisition Date")
            {
            }
            column(HR_Transport_RequestsCaption; HR_Transport_RequestsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Transport_Requests_CodeCaption; FieldCaption(Code))
            {
            }
            column(HR_Transport_Requests__Requester_Code_Caption; FieldCaption("Requester Code"))
            {
            }
            column(HR_Transport_Requests_RequesterCaption; FieldCaption(Requester))
            {
            }
            column(HR_Transport_Requests_FromCaption; FieldCaption(From))
            {
            }
            column(HR_Transport_Requests__To_Caption; FieldCaption("To"))
            {
            }
            column(HR_Transport_Requests__Purpose_of_Request_Caption; FieldCaption("Purpose of Request"))
            {
            }
            column(HR_Transport_Requests__Requisition_Date_Caption; FieldCaption("Requisition Date"))
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
        HR_Transport_RequestsCaptionLbl: Label 'HR Transport Requests';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

