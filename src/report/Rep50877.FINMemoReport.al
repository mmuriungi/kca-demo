report 50877 "FIN-Memo Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MEMO/Reports/SSR/FINMemoReport.rdl';

    dataset
    {
        dataitem(MemoHeader; "FIN-Memo Header")
        {
            column(No; MemoHeader."No.")
            {
            }
            column(DateTime; MemoHeader."Date/Time")
            {
            }
            column(MemoFrom; MemoHeader.From)
            {
            }
            column(MemoThrough; MemoHeader.Through)
            {
            }
            column(MemoTo; MemoHeader."To")
            {
            }
            column(CreatedBy; MemoHeader."Created by")
            {
            }
            column(Title; MemoHeader."Title/Ref.")
            {
            }
            column(Graph1; MemoHeader."Paragraph 1")
            {
            }
            column(Graph2; MemoHeader."Paragraph 2")
            {
            }
            column(Graph3; MemoHeader."Paragraph 3")
            {
            }
            column(PAYERate; MemoHeader."P.A.Y.E. Rate")
            {
            }
            column(PayPeriod; MemoHeader."Payroll Period")
            {
            }
            column(PeriodMonth; MemoHeader."Period Month")
            {
            }
            column(PeriodYear; MemoHeader."Period Year")
            {
            }
            column(Status; MemoHeader."Memo Status")
            {
            }
            column(PAYEValue; MemoHeader."PAYE Amount")
            {
            }
            column(budgetname; budgetname)
            {

            }
            column(budgetbal; budgetbal)
            {

            }
            column(BudgetAccount_MemoHeader; "Budget Account")
            {
            }
            column(MemoValue; MemoHeader."Memo Value")
            {
            }
            column(ssign; userSet."User Signature")
            {

            }
            column(utitle; userSet."Approval Title")
            {

            }


            dataitem(MemoDet; "FIN-Memo Details")
            {
                DataItemLink = "Memo No." = FIELD("No.");
                column(MemoNos; MemoDet."Memo No.")
                {
                }
                column(StaffNos; MemoDet."Staff no.")
                {
                }
                column(ExpenseCode; MemoDet."Expense Code")
                {
                }
                column(StaffNames; MemoDet."Staff Name")
                {
                }
                column(Rates; MemoDet.Rate)
                {
                }
                column(Days; MemoDet.Days)
                {
                }
                column(Amounts; MemoDet.Amount)
                {
                }
                column(ComputePAYE; MemoDet."Compute P.A.Y.E.")
                {
                }
                column(PAYERate2; MemoDet."P.A.Y.E. Rate")
                {
                }
                column(PayPeriod2; MemoDet."Payroll Period")
                {
                }
                column(PeriodYear2; MemoDet."Period Year")
                {
                }
                column(PAYEAmount; MemoDet."PAYE Amount")
                {
                }
                column(TransactinType; MemoDet.Type)
                {
                }


            }
            column(logo; info.Picture)
            {

            }
            column(name; info.Name)
            {

            }
            column(name2; info."Name 2")
            {

            }
            column(address; info.Address)
            {

            }
            column(address2; info."Address 2")
            {

            }
            column(email; info."E-Mail")
            {

            }
            column(url; info."Home Page")
            {

            }
            column(BudgetName_MemoHeader; "Budget Name")
            {
            }
            column(BudgetedAmount2_MemoHeader; "Budgeted Amount2")
            {
            }
            column(CommittedAmount2_MemoHeader; "Committed Amount2")
            {
            }
            column(ExpensedAmount2_MemoHeader; "Expensed Amount2")
            {
            }


            dataitem(DataItem2; "Memo PRN Details")
            {
                DataItemLink = "Document No." = FIELD("No.");

                DataItemLinkReference = MemoHeader;
                MaxIteration = 0;
                column(No_MemoPRNDetails; DataItem2."No.")
                {
                }
                column(Description_MemoPRNDetails; DataItem2.Description)
                {
                }
                column(UnitofMeasure_MemoPRNDetails; DataItem2."Unit of Measure")
                {
                }
                column(Quantity_MemoPRNDetails; DataItem2.Quantity)
                {
                }
                column(Amount_MemoPRNDetails; DataItem2.Amount)
                {
                }
                column(UnitCost_MemoPRNDetails; DataItem2."Unit Cost")
                {
                }
                column(LineAmount_MemoPRNDetails; DataItem2."Line Amount")
                {
                }
                column(memodetailscount; memodetailscount)
                {
                }
                column(PRNDetailsExistText; PRNDetailsExistText)
                {
                }
                column(PRNDetailsExists; PRNDetailsExists)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    memodetailscount := memodetailscount + 1;
                end;

                trigger OnPreDataItem()
                begin
                    memodetailscount := 0;
                    PRNDetailsExists := FALSE;
                    PRNDetailsExistText := 'This Memo Has No PRN Lines';
                    IF DataItem2."No." = '' THEN BEGIN
                        PRNDetailsExists := TRUE;
                        PRNDetailsExistText := 'This Memo Has No Lines';
                    END;

                end;
            }
            dataitem(ApprovalEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                column(ApproverID_ApprovalEntry; ApprovalEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; ApprovalEntry."Last Date-Time Modified")
                {
                }
                column(Sender_ID; "Sender ID") { }

                dataitem(UserSetUp; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    column(Signature_UserSetup; UserSetUp."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; UserSetUp."Approval Title")
                    {
                    }
                    trigger OnPreDataItem()
                    begin
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                        ApprovalEntry.SetFilter(ApprovalEntry."Approver ID", '<>%1', MemoHeader."Created by");
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                info.GET();
                info.CalcFields(Picture);

                userSet.get("Created by");
                userSet.CalcFields("User Signature");

                GLAccount.Reset();
                GLAccount.SetRange("No.", MemoHeader."Budget Account");
                if GLAccount.Find('-') then
                    budgetname := GLAccount.Name;

                budgetbal := MemoHeader."Budgeted Amount" - (MemoHeader."Committed Amount2" + MemoHeader."Expensed Amount2")

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
        budgetbal: Decimal;
        GLAccount: Record "G/L Account";
        budgetname: Text[100];
        userSet: Record "User Setup";
        memodetailscount: Integer;
        PRNDetailsExists: Boolean;
        PRNDetailsExistText: Text;
        info: Record "Company Information";
}