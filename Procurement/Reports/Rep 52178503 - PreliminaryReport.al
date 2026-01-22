report 52178503 "Preliminary Evaluation Report"
{
    RDLCLayout = './Procurement/Reports/ssr/Preliminary Evaluation Report.rdl';
    DefaultLayout = RDLC;
    Caption = 'Preliminary Evaluation Report';
    dataset
    {
        dataitem(ProcPreliminaryQualifQuote; "Proc-Preliminary Qualif.Quote")
        {
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(StaffName; "Staff Name")
            {
            }
            column(Scored; Scored)
            {
            }
            column(Reason; Reason)
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(Description; Description)
            {
            }
            column(Evaluated; Evaluated)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(CompName; info.Name)
            {

            }
            column(CompAddress; info.Address)
            {

            }
            column(CompMail; info."E-Mail")
            {

            }
            column(CompPhone; info."Phone No.")
            {

            }
            column(logo; info.Picture)
            {

            }
            trigger OnPreDataItem()
            begin
                info.get;
                info.CalcFields(Picture);

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        info: Record "Company Information";
        sno: Integer;
}
