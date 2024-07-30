report 50028 "Quaterly Budget Report"
{
    DefaultLayout = rdlc;
    RDLCLayout = './Layouts/QuateryBudgetReport.rdl';

    dataset
    {
        dataitem(finbudget; "FIN-Budget Entries Summary")
        {

            column(BudgetName_finbudget; "Budget Name")
            {
            }
            column(GLAccountNo_finbudget; "G/L Account No.")
            {
            }
            column(GlobalDimension1Code_finbudget; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_finbudget; "Global Dimension 2 Code")
            {
            }
            column(AllocationFilter_finbudget; "Allocation Filter")
            {
            }
            column(BalanceFilter_finbudget; "Balance Filter")
            {
            }
            column(CommitmentsFilter_finbudget; "Commitments Filter")
            {
            }
            column(ExpensesFilter_finbudget; "Expenses Filter")
            {
            }
            column(Q1Allocation; Q1Allocation)
            {

            }
            column(Q2Allocation; Q2Allocation)
            { }
            column(Q3Allocation; Q3Allocation)
            { }
            column(Q4Allocation; Q4Allocation)
            { }
            column(Q1Commitment; -Q1Commitment)
            {

            }
            column(Q2Commitment; -Q2Commitment)
            { }
            column(Q3Commitment; -Q3Commitment)
            {

            }
            column(Q4Commitment; -Q4Commitment)
            { }
            column(Q1Expenses; Q1Expenses)
            { }
            column(Q2Expenses; Q2Expenses)
            { }
            column(Q3Expenses; Q3Expenses)
            { }
            column(Q4Expenses; Q4Expenses)
            { }
            column(Q1Balances; Q1Balances)
            { }
            column(Q2Balances; Q2Balances)
            { }
            column(Q3Balances; Q3Balances)
            { }
            column(Q4Balances; Q4Balances)
            {

            }
            column(logo; info.Picture)
            {

            }
            column(address; info.Address)
            {

            }
            column(email; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(compname; info.Name)
            {

            }
            column(AccountName; AccountName)
            {

            }
            column(accountType; accountType)
            {

            }

            trigger OnAfterGetRecord()
            begin
                GetBudgetDates(budgetperiod);

                //Q1
                budgetSummary.Reset();
                budgetSummary.SetRange("Budget Name", "Budget Name");
                budgetSummary.SetRange("G/L Account No.", "G/L Account No.");
                budgetSummary.SetFilter("Date Filter", '%1..%2', Q1startdate, Q1Enddate);
                if budgetSummary.Find('-') then begin
                    budgetSummary.CalcFields("Allocation Filter", "Commitments Filter", "Expenses Filter", "Balance Filter");
                    Q1Allocation := budgetSummary."Allocation Filter";
                    Q1Commitment := budgetSummary."Commitments Filter";
                    Q1Expenses := budgetSummary."Expenses Filter";
                    Q1Balances := budgetSummary."Balance Filter";
                end;

                //Q2
                budgetSummary.Reset();
                budgetSummary.SetRange("Budget Name", "Budget Name");
                budgetSummary.SetRange("G/L Account No.", "G/L Account No.");
                budgetSummary.SetFilter("Date Filter", '%1..%2', Q2startdate, Q2Enddate);
                if budgetSummary.Find('-') then begin
                    budgetSummary.CalcFields("Allocation Filter", "Commitments Filter", "Expenses Filter", "Balance Filter");
                    Q2Allocation := budgetSummary."Allocation Filter";
                    Q2Commitment := budgetSummary."Commitments Filter";
                    Q2Expenses := budgetSummary."Expenses Filter";
                    Q2Balances := budgetSummary."Balance Filter";
                end;
                //Q3
                budgetSummary.Reset();
                budgetSummary.SetRange("Budget Name", "Budget Name");
                budgetSummary.SetRange("G/L Account No.", "G/L Account No.");
                budgetSummary.SetFilter("Date Filter", '%1..%2', Q3startdate, Q3Enddate);
                if budgetSummary.Find('-') then begin
                    budgetSummary.CalcFields("Allocation Filter", "Commitments Filter", "Expenses Filter", "Balance Filter");
                    Q3Allocation := budgetSummary."Allocation Filter";
                    Q3Commitment := budgetSummary."Commitments Filter";
                    Q3Expenses := budgetSummary."Expenses Filter";
                    Q3Balances := budgetSummary."Balance Filter";
                end;
                //Q4
                budgetSummary.Reset();
                budgetSummary.SetRange("Budget Name", "Budget Name");
                budgetSummary.SetRange("G/L Account No.", "G/L Account No.");
                budgetSummary.SetFilter("Date Filter", '%1..%2', Q4startdate, Q4Enddate);
                if budgetSummary.Find('-') then begin
                    budgetSummary.CalcFields("Allocation Filter", "Commitments Filter", "Expenses Filter", "Balance Filter");
                    Q4Allocation := budgetSummary."Allocation Filter";
                    Q4Commitment := budgetSummary."Commitments Filter";
                    Q4Expenses := budgetSummary."Expenses Filter";
                    Q4Balances := budgetSummary."Balance Filter";
                    // Error('quater 4 end date ', Format(Q4Enddate));
                end;
                glaccount.Reset();
                glaccount.SetRange("No.", "G/L Account No.");
                if glaccount.Find('-') then begin
                    AccountName := glaccount.Name;
                    accountType := glaccount."Account Category";
                end;

            end;

            trigger OnPostDataItem()
            begin
                info.get();
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
                    field(budgetperiod; budgetperiod)
                    {
                        ApplicationArea = All;
                        TableRelation = "G/L Budget Name".Name;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            IntDec: Record "G/L Budget Name";
                        begin
                            IntDec.Reset();
                            if page.RunModal(page::"G/L Budget Names", IntDec) = Action::LookupOK then

                                //RefDate := IntDec."End Date";
                                budgetperiod := IntDec.Name;

                        end;
                    }
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
        glaccount: Record "G/L Account";
        AccountName: Text[100];
        accountType: Enum "G/L Account Category";
        info: Record "Company Information";
        budgetSummary: Record "FIN-Budget Entries Summary";
        budgetperiod: code[30];
        Q1startdate: date;
        Q2startdate: date;
        Q3startdate: date;
        Q4startdate: date;
        Q1Enddate: date;
        Q2Enddate: date;
        Q3Enddate: date;
        Q4Enddate: date;

        Q1Allocation: Decimal;
        Q2Allocation: Decimal;
        Q3Allocation: Decimal;
        Q4Allocation: Decimal;

        Q1Commitment: Decimal;
        Q2Commitment: Decimal;
        Q3Commitment: Decimal;
        Q4Commitment: Decimal;

        Q1Expenses: Decimal;
        Q2Expenses: Decimal;
        Q3Expenses: Decimal;
        Q4Expenses: Decimal;


        Q1Balances: Decimal;
        Q2Balances: Decimal;
        Q3Balances: Decimal;
        Q4Balances: Decimal;






    procedure GetBudgetDates(var Period: Code[20]): Date
    var
        budgetsetup: Record "FIN-Budget Quaterly Periods";
    begin
        if budgetsetup.Get(Period) then begin
            Q1startdate := budgetsetup."Q1 Budget Start Date";
            Q2startdate := budgetsetup."Q2 Budget Start Date";
            Q3startdate := budgetsetup."Q3 Budget Start Date";
            Q4startdate := budgetsetup."Q4 Budget Start Date";
            Q1Enddate := budgetsetup."Q1 Budget End Date";
            Q2Enddate := budgetsetup."Q2 Budget End Date";
            Q3Enddate := budgetsetup."Q3 Budget End Date";
            Q4Enddate := budgetsetup."Q4 Budget End Date";
        end;

    end;


}