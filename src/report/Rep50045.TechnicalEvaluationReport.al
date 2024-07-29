report 50045 "Technical Evaluation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Technical Evaluation Report.rdl';
    Caption = 'Technical Evaluation Report';
    dataset
    {
        dataitem(ProcTechnicalQualifQuote; "Proc-Technical Qualif.Quote")
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
            column(Scored; Scored)
            {
            }
            column(StaffName; "Staff Name")
            {
            }
            column(StaffNo; "Staff No")
            {
            }
            column(Evaluated; Evaluated)
            {
            }
            column(SatisfactoryScore; "Satisfactory Score")
            {
            }
            column(TechEvaluationMax; "Tech Evaluation Max")
            {
            }
            column(TechEvaluationScored; "Tech Evaluation Scored")
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
