report 50037 "Disposal Plan Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Disposal Plan Reports.rdl';

    dataset
    {
        dataitem(DataItem1; "Disposal Plan Table Header")
        {
            RequestFilterFields = "No.", "Ref No";
            column(No_DisposalPlanTableHeader; "No.")
            {
            }
            column(Year_DisposalPlanTableHeader; Year)
            {
            }
            column(Description_DisposalPlanTableHeader; Description)
            {
            }
            column(Shortcutdimension1code_DisposalPlanTableHeader; "Shortcut dimension 1 code")
            {
            }
            column(Shortcutdimension2code_DisposalPlanTableHeader; "Shortcut dimension 2 code")
            {
            }
            column(NoSeries_DisposalPlanTableHeader; "No. Series")
            {
            }
            column(DisposalMethod_DisposalPlanTableHeader; "Disposal Methodc")
            {
            }
            column(Status_DisposalPlanTableHeader; Status)
            {
            }
            column(DisposalStatus_DisposalPlanTableHeader; "Disposal Status")
            {
            }
            column(Date_DisposalPlanTableHeader; Date)
            {
            }
            column(RefNo_DisposalPlanTableHeader; "Ref No")
            {
            }
            column(ResponsibilityCenter_DisposalPlanTableHeader; "Responsibility Center")
            {
            }
            column(PlannedDate_DisposalPlanTableHeader; "Planned Date")
            {
            }
            column(DisposalYear_DisposalPlanTableHeader; "Disposal Year")
            {
            }
            column(DisposalDescription_DisposalPlanTableHeader; "Disposal Description")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            dataitem(DataItem18; "Disposal plan table lines")
            {
                DataItemLink = "Ref. No." = FIELD("No.");
                DataItemTableView = SORTING("Ref. No.", "Line No.", "Disposal Period")
                                    ORDER(Ascending);
                column(RefNo_Disposalplantablelines; "Ref. No.")
                {
                }
                column(SubRefNo_Disposalplantablelines; "Sub. Ref. No.")
                {
                }
                column(No_Disposalplantablelines; "No.")
                {
                }
                column(Itemdescription_Disposalplantablelines; "Item description")
                {
                }
                column(UnitofIssue_Disposalplantablelines; "Unit of Issue")
                {
                }
                column(Quantity_Disposalplantablelines; Quantity)
                {
                }
                column(DisposalUnitprice_Disposalplantablelines; "Disposal Unit price")
                {
                }
                column(TotalPrice_Disposalplantablelines; "Total Price")
                {
                }
                column(PlannedDate_Disposalplantablelines; "Planned Date")
                {
                }
                column(Disposalmethod_Disposalplantablelines; "Disposal Method")
                {
                }
                column(Shortcutdimension1code_Disposalplantablelines; Department)
                {
                }
                column(Shortcutdimension2code_Disposalplantablelines; County)
                {
                }
                column(Approved_Disposalplantablelines; Approved)
                {
                }
                column(LineNo_Disposalplantablelines; "Line No.")
                {
                }
                column(ItemTagNo_Disposalplantablelines; "Item/Tag No")
                {
                }
                column(UnitofMeasure_Disposalplantablelines; "Unit of Measure")
                {
                }
                column(SerialNo_Disposalplantablelines; "Serial No")
                {
                }
                column(DisposalPeriod_Disposalplantablelines; "Disposal Period")
                {
                }
                column(Pic; CI.Picture)
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

    trigger OnPreReport()
    begin
        CI.GET();
        CI.CALCFIELDS(CI.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Disposalplan: Record "Disposal Plan Table Header";
        Desc: Text[30];
        CI: Record "Company Information";
}

