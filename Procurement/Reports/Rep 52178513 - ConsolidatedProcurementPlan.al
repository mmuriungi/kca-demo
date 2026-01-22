report 52178513 "Consolidated Procurement Plan"
{
    RDLCLayout = './Procurement/Reports/Ssr/Consolidated Proc Plan.rdl';
    DefaultLayout = RDLC;
    Caption = 'Consolidated Procurement Plan';
    dataset
    {
        dataitem(ProcConsolidatedHeader; "Proc Consolidated Header")
        {
            column(ProcConsolidatedHeaderFy; Fy)
            {
            }
            column(ProcConsolidatedHeaderDescription; Description)
            {
            }
            column(ProcConsolidatedHeaderDate; "Date")
            {
            }
            column(ProcConsolidatedHeaderAmount; Amount)
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(address; CompInf.Address)
            {

            }
            column(Address2; CompInf."Address 2")
            {

            }
            column(mail; CompInf."E-Mail")
            {

            }
            column(Url; CompInf."Home Page")
            {

            }
            column(CompFax; CompInf."Fax No.")
            {

            }
            column(Comppostalcode; CompInf."Post Code")
            {

            }
            column(Compphone; CompInf."Phone No.")
            {

            }
            column(compphone2; CompInf."Phone No. 2")
            {

            }
            column(CompanyInfowebpage; CompInf."Home Page")
            {

            }
            dataitem(ProcConsolidatedLines; "Proc Consolidated Lines")
            {
                DataItemLink = Fy = field(Fy);
                column(Type_ProcConsolidatedLines; "Type")
                {
                }
                column(No_ProcConsolidatedLines; No)
                {
                }
                column(Quantity_ProcConsolidatedLines; Quantity)
                {
                }
                column(UnitOfMeasure_ProcConsolidatedLines; "Unit Of Measure")
                {
                }
                column(VotebookAccount_ProcConsolidatedLines; "Votebook Account")
                {
                }
                column(ProcurementMethod_ProcConsolidatedLines; "Procurement Method")
                {
                }
                column(Description_ProcConsolidatedLines; Description)
                {
                }
                column(firstQuater_ProcConsolidatedLines; "1st Quater")
                {
                }
                column(firstQuaterAmended_ProcConsolidatedLines; "1st Quater Amended")
                {
                }
                column(secndQuater_ProcConsolidatedLines; "2nd Quater")
                {
                }
                column(secndQuaterAmended_ProcConsolidatedLines; "2nd Quater Amended")
                {
                }
                column(thrdQuater_ProcConsolidatedLines; "3rd Quater")
                {
                }
                column(thrdQuaterAmended_ProcConsolidatedLines; "3rd Quater Amended")
                {
                }
                column(frthQuater_ProcConsolidatedLines; "4th Quater")
                {
                }
                column(frthQuaterAmended_ProcConsolidatedLines; "4th Quater Amended")
                {
                }
                column(AmendedQuantity_ProcConsolidatedLines; "Amended Quantity")
                {
                }
                column(Amount_ProcConsolidatedLines; Amount)
                {
                }
                column(UnitCost_ProcConsolidatedLines; "Unit Cost")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CalcFields(Quantity);
                    //CalcFields("Amended Quantity");
                end;
            }
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
    trigger OnInitReport()
    begin
        CompInf.get();
        CompInf.CalcFields(Picture);
    end;

    var
        CompInf: Record "Company Information";
        seq: Integer;
}
