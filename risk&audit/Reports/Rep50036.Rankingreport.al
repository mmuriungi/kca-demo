report 50811 "Ranking report"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Ranking report.rdl';
    //
    dataset
    {
        dataitem(RiskObjectives; "Risk Objectives")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }
            column(FunctionCode; "Function Code")
            {
            }
            column(FunctionDescription; "Function Description")
            {
            }
            column(Objective_Average; "Objective Average")
            {
            }
            column(ObjectiveCode; "Objective Code")
            {
            }
            column(ObjectiveDescription; "Objective Description")
            {
            }
            column(Status; Status)
            {
            }
            column(ObjectiveAverage; ObjectiveAverage)
            { }
            trigger OnAfterGetRecord()
            begin
                ObjectiveAverage := 0;
                ObjectiveAverage := Round("Objective Average", 0.01, '=');
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;


    var
        CompanyInfo: Record "Company Information";
        ObjectiveAverage: Decimal;
}
