report 54824 "Stock Summary Clinic"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StockSummaryClinic.rdl';

    dataset
    {
        dataitem(DataItem8129; 27)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Inventory Posting Group" = FILTER('MEDICAL'));
            //RequestFilterFields = "No.",Field50102;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(USERID; USERID)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Base_Unit_of_Measure_; "Base Unit of Measure")
            {
            }
            column(Item_Inventory; Inventory)
            {
            }
            column(Item__Unit_Cost_; "Unit Cost")
            {
            }
            column(TAmount; TAmount)
            {
            }
            column(TAmount_Control1102755010; TAmount)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(STOCK_SUMMARY_REPORTCaption; STOCK_SUMMARY_REPORTCaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; FIELDCAPTION("Base Unit of Measure"))
            {
            }
            column(Item_InventoryCaption; FIELDCAPTION(Inventory))
            {
            }
            column(Item__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
            {
            }
            column(Total_ValueCaption; Total_ValueCaptionLbl)
            {
            }
            column(TOTAL_VALUECaption_Control1102755013; TOTAL_VALUECaption_Control1102755013Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TAmount := Item.Inventory * Item."Unit Cost";
#pragma warning disable AL0667
                CurrReport.CREATETOTALS(TAmount);
#pragma warning restore AL0667
            end;
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
        TAmount: Decimal;
        ItemCaptionLbl: Label 'Item';
        Item: Record Item;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        STOCK_SUMMARY_REPORTCaptionLbl: Label 'STOCK SUMMARY REPORT';
        Total_ValueCaptionLbl: Label 'Total Value';
        TOTAL_VALUECaption_Control1102755013Lbl: Label 'TOTAL VALUE';
}

