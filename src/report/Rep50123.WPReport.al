report 50123 "W/P Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/WP Report.rdl';

    dataset
    {
        dataitem(DataItem1000000000; Workplan)
        {
            RequestFilterFields = "Global Dimension 1 Code", "Workplan Code";
            column(compinfo_Name; compinfo.Name)
            {
            }
            column(compinfo_Address; compinfo.Address)
            {
            }
            column(compinfo_Picture; compinfo.Picture)
            {
            }
            column(WorkplanCode_Workplan; "Workplan Code")
            {
            }
            column(WorkplanGlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(WorkplanGlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(WorkplanDescription_Workplan; "Workplan Description")
            {
            }
            dataitem(DataItem1000000001; "Workplan Activities")
            {
                DataItemTableView = SORTING("Activity Code")
                                    ORDER(Ascending);
                column(ActivityCode_WorkplanActivities; "Activity Code")
                {
                }
                column(ActivityDescription_WorkplanActivities; "Activity Description")
                {
                }
                column(AccountType_WorkplanActivities; "Account Type")
                {
                }
                column(AmounttoTransfer_WorkplanActivities; "Amount to Transfer")
                {
                }
                column(UploadedtoProcurementWorkpl_WorkplanActivities; "Uploaded to Procurement Workpl")
                {
                }
                column(DatetoTransfer_WorkplanActivities; "Date to Transfer")
                {
                }
                column(Description_WorkplanActivities; Description)
                {
                }
                column(ConvertedtoBudget_WorkplanActivities; "Converted to Budget")
                {
                }
                column(ExpenseCode_WorkplanActivities; "Expense Code")
                {
                }
                column(No_WorkplanActivities; "No.")
                {
                }
                column(Type_WorkplanActivities; "Type")
                {
                }
                column(WorkplanActivitiesUnit; "Unit of Measure")
                {
                }
                column(ProcMethodNo; "Proc. Method No.")
                {
                }
                column(WorkplanActivitiesSourceOfFunds; "Source Of Funds")
                {
                }
                column(WorkplanActivitiescategory; "category Sub Plan")
                {
                }
                column(WorkplanActivitiesQuantity; Quantity)
                {
                }
                column(UnitofCost; "Unit of Cost")
                {
                }
                column(WorkplanActivitiesAmounttoTransfer; "Amount to Transfer")
                {
                }
                column(WorkplanActivitiesGlobalDimension1Code; "Global Dimension 1 Code")
                {
                }
                column(WorkplanActivitiesShortcutDimension2Code; "Shortcut Dimension 2 Code")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //TotalAmount:=0;
                    TotalAmount := TotalAmount + "Amount to Transfer";
                end;
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
        compinfo: Record "Company Information";
        TotalAmount: Decimal;
}

