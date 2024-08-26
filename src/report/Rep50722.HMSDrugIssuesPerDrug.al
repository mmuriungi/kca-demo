report 50722 "HMS Drug Issues Per Drug"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSDrugIssuesPerDrug.rdl';

    dataset
    {
        dataitem(DataItem8129; 27)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Date_Printed______FORMAT_TODAY_0_4_; 'Date Printed: ' + FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            column(Printed_By______USERID; 'Printed By: ' + USERID)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item_Inventory; Inventory)
            {
            }
            column(TotalFor___FIELDCAPTION__No___; TotalFor + FIELDCAPTION("No."))
            {
            }
            column(Item_Inventory_Control1102760020; Inventory)
            {
            }
            column(University_HEALTH_SERVICESCaption; University_HEALTH_SERVICESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(DRUG_ISSUES_PER_GROUPCaption; DRUG_ISSUES_PER_GROUPCaptionLbl)
            {
            }
            column(U_O_MCaption; U_O_MCaptionLbl)
            {
            }
            /* column(HMS_Pharmacy_Line_DateCaption; "HMS-Pharmacy Line".FIELDCAPTION(Date))
            {
            }
            column(HMS_Pharmacy_Line__Actual_Qty_Caption; "HMS-Pharmacy Line".FIELDCAPTION("Actual Qty"))
            {
            }
            column(HMS_Pharmacy_Line_QuantityCaption; "HMS-Pharmacy Line".FIELDCAPTION(Quantity))
            {
            } */
            column(Iss_d_QtyCaption; Iss_d_QtyCaptionLbl)
            {
            }
            column(Iss_d_UnitsCaption; Iss_d_UnitsCaptionLbl)
            {
            }
            column(RemainingCaption; RemainingCaptionLbl)
            {
            }
            /* column(HMS_Pharmacy_Line_PharmacyCaption; "HMS-Pharmacy Line".FIELDCAPTION(Pharmacy))
            {
            } */
            column(Item_InventoryCaption; FIELDCAPTION(Inventory))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            dataitem(DataItem1251; "HMS-Pharmacy Line")
            {
                DataItemLink = "Drug No." = FIELD("No.");
                column(HMS_Pharmacy_Line_Date; Date)
                {
                }
                column(HMS_Pharmacy_Line__Measuring_Unit_; "Measuring Unit")
                {
                }
                column(HMS_Pharmacy_Line__Actual_Qty_; "Actual Qty")
                {
                }
                column(HMS_Pharmacy_Line_Quantity; Quantity)
                {
                }
                column(HMS_Pharmacy_Line__Issued_Quantity_; "Issued Quantity")
                {
                }
                column(HMS_Pharmacy_Line__Issued_Units_; "Issued Units")
                {
                }
                column(HMS_Pharmacy_Line_Remaining; Remaining)
                {
                }
                column(HMS_Pharmacy_Line_Pharmacy; Pharmacy)
                {
                }
                column(HMS_Pharmacy_Line_Pharmacy_No_; "Pharmacy No.")
                {
                }
                column(HMS_Pharmacy_Line_Drug_No_; "Drug No.")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        University_HEALTH_SERVICESCaptionLbl: Label 'University HEALTH SERVICES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DRUG_ISSUES_PER_GROUPCaptionLbl: Label 'DRUG ISSUES PER GROUP';
        U_O_MCaptionLbl: Label 'U.O.M';
        Iss_d_QtyCaptionLbl: Label 'Iss''d Qty';
        Iss_d_UnitsCaptionLbl: Label 'Iss''d Units';
        RemainingCaptionLbl: Label 'Remaining';
}

