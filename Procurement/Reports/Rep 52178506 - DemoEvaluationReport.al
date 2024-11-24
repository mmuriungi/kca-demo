report 52178506 "Demo Evaluation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Procurement/Reports/ssr/Demo Evaluation Report.rdl';
    Caption = 'Demo Evaluation Report';
    dataset
    {
        dataitem(ProcDemoQualifQuote; "Proc-Demo Qualif.Quote")
        {
            column(AverageScore; "Average Score")
            {
            }
            column(Description; Description)
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(MaximumScore; "Maximum Score")
            {
            }
            column(No; "No.")
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(SatisfactoryScore; "Satisfactory Score")
            {
            }
            column(Scored; Scored)
            {
            }
            column(StaffName; "Staff Name")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(TechEvaluationScored; "Tech Evaluation Scored")
            {
            }
            column(Evaluated; Evaluated)
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
