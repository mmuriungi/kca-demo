report 50039 "Procurement Plan1"
{
    Caption = 'Procurement Plan';
    RDLCLayout = './Layouts/Procurement plan.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem("PROC-Procurement Plan Header"; "PROC-Procurement Plan Header1")
        {

            column(BudgetName_PROCProcurementPlanHeader; "Budget Name")
            {
            }
            column(BudgetedAmount_PROCProcurementPlanHeader; "Budgeted Amount")
            {
            }
            column(Name_PROCProcurementPlanHeader; Name)
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
            dataitem(Lines; "PROC-Procurement Plan Lines1")
            {
                DataItemLink = "Budget Name" = field("Budget Name");
                column(BudgetName_PROCProcurementPlanLines; "Budget Name")
                {
                }
                column(Category_PROCProcurementPlanLines; Category)
                {
                }
                column(No_PROCProcurementPlanLines; "No.")
                {
                }
                column(Description_PROCProcurementPlanLines; Description)
                {
                }
                column(ProcurementMethod_PROCProcurementPlanLines; "Procurement Method")
                {
                }
                column(Quantity_PROCProcurementPlanLines; Quantity)
                {
                }
                column(GlobalDimension1Code_PROCProcurementPlanLines; "Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_PROCProcurementPlanLines; "Global Dimension 2 Code")
                {
                }
                column(StartDate_PROCProcurementPlanLines; "Start Date")
                {
                }
                column(Type_PROCProcurementPlanLines; "Type")
                {
                }
                column(UnitCost_PROCProcurementPlanLines; "Unit Cost")
                {
                }
                column(UnitOfMeasure_PROCProcurementPlanLines; "Unit Of Measure")
                {
                }
                column(Amount_PROCProcurementPlanLines; Amount)
                {
                }
                column(RemainingQty_PROCProcurementPlanLines; "Remaining Qty")
                {
                }
                column(Reservation_PROCProcurementPlanLines; Reservation)
                {
                }
                column(EntryNo_PROCProcurementPlanLines; "Entry No.")
                {
                }
                column(VotebookAccount_PROCProcurementPlanLines; "Votebook Account")
                {
                }
                column(SpecialGroup_PROCProcurementPlanLines; "Special Group")
                {
                }
                column(fquater; "1st Quater")
                {
                }
                column(sQuater_Lines; "2nd Quater")
                {
                }
                column(TQuater_Lines; "3rd Quater")
                {
                }
                column(F4Quater_Lines; "4th Quater")
                {
                }

                column(seq; seq)
                {

                }


                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
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
    trigger OnInitReport()
    begin

    end;

    var
        CompInf: Record "Company Information";
        seq: Integer;

}
