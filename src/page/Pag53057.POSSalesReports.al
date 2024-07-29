page 53057 "POS Sales Reports"
{
    Caption = 'Receivables Reports';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(wet)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer''s name. This name will appear on all sales documents for the customer. You can enter a maximum of 50 characters, both numbers and letters.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies the code for the responsibility center that will administer this customer by default.';
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ToolTip = 'Specifies from which location sales to this customer will be processed by default.';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ZIP code.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Reports)
            {
                Caption = 'Reports';
                group(SalesRep)
                {
                    Caption = 'Sales Reports';
                    Image = "Report";
                    action(CustStatement)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Inv./Item';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Summary Cust. Invoices/Item";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action(GraphicalCustInv)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Graphical Customer Invoices';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Graphical Cust. Invoices";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action("Graphical Cust. In. 2")
                    {
                        Caption = 'Graphical Cust. In. 2';
                        Image = "Report";
                        RunObject = Report "Graphical Cust. Invoices 2";
                        ToolTip = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    }
                    action("Sales By Sales Person/Date")
                    {
                        Caption = 'Sales By Sales Person/Date';
                        Image = "Report";
                        RunObject = Report "Sales By Sales Person/Date";
                        ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action("Sales by Salesp./Month")
                    {
                        Caption = 'Sales by Salesp./Month';
                        Image = "Report";
                        RunObject = Report "Sales By Sales Person/Month";
                        ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    }
                    action("Sales By Salesp./Item")
                    {
                        Caption = 'Sales By Salesp./Item';
                        Image = "Report";
                        RunObject = Report "Sales By SalesPerson/Item";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action("Sales Person and Item Class")
                    {
                        Caption = 'Sales Person and Item Class';
                        Image = "Report";
                        RunObject = Report "Sales By SalesP./Item/Class";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action("Meal Booking Reports")
                    {
                        Caption = 'Meal Booking Reports';
                        Image = Agreement;
                        RunObject = Report "Meal Booking Lists";
                    }
                }
                group("PosSalesRep.")
                {
                    Caption = 'POS Sales';
                    Image = "Report";
                    action(DirectSalesReg)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Sales Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Direct Sales Register";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action(DetailedDirectSales)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales/User (Summary)';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Det. Direct Sales Register";
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    }
                    action("Direct Sales Reg./User")
                    {
                        Caption = 'Direct Sales Reg./User';
                        Image = "Report";
                        RunObject = Report "Direct Sales Register/User";
                        ToolTip = 'View, print, or save a customer''s balance on a certain date. You can use the report to extract your total sales income at the close of an accounting period or fiscal year.';
                    }
                    action("Direct Sales by User/Date")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Direct Sales by User/Date';
                        Image = "Report";
                        RunObject = Report "Direct Sales User/Date";
                        ToolTip = 'View the beginning and ending balance for customers with entries within a specified period. The report can be used to verify that the balance for a customer posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                    }
                    action("Sales By User/Trans. Type/Month")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales By User/Trans. Type/Month';
                        Image = "Report";
                        RunObject = Report "Sales Person/Month/Trans T.";
                        ToolTip = 'View the balance for customers with balances on a specified date. The report can be used at the close of an accounting period, for example, or for an audit.';
                    }
                    action("Sales Register By Trans. type")
                    {
                        Caption = 'Sales Register By Trans. type';
                        Image = "Report";
                        RunObject = Report "Direct Sales Register T. Type";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                }
                group(FinanceReports)
                {
                    Caption = 'Finance Reports';
                    Image = "Report";
                    action(CustStatement2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Statement';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';

                        trigger OnAction()
                        begin
                            Customer1.RESET;
                            Customer1.SETRANGE(Customer1."No.", Rec."No.");
                            IF Customer1.FIND('-') THEN BEGIN
                                REPORT.RUN(65212, TRUE, FALSE, Customer1);
                            END;
                        end;
                    }
                    action(CustListSumm)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Balance Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';

                        trigger OnAction()
                        begin
                            Customer1.RESET;
                            Customer1.SETFILTER(Customer1."Customer Type", '=%1', Customer1."Customer Type");
                            IF Customer1.FIND('-') THEN BEGIN
                                REPORT.RUN(65213, TRUE, FALSE, Customer1);
                            END;
                        end;
                    }
                    action(Top10)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Top 10 List';
                        Image = "Report";
                        RunObject = Report 111;
                        ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    }
                    action(CustSales)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Sales List';
                        Image = "Report";
                        RunObject = Report 119;
                        ToolTip = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                    }
                    // action(CustSalesStats)
                    // {
                    //     ApplicationArea = Basic,Suite;
                    //     Caption = 'Sales Statistics';
                    //     Image = "Report";
                    //     RunObject = Report "Customer Sales Statistics";
                    //     ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                    // }
                    action("Customer - Summary Aging")
                    {
                        Caption = 'Customer - Summary Aging';
                        Image = "Report";
                        RunObject = Report "Customer - Summary Aging Simp.";
                        ToolTip = 'View, print, or save a summary of each customer''s total payments due, divided into three time periods. The report can be used to decide when to issue reminders, to evaluate a customer''s creditworthiness, or to prepare liquidity analyses.';
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Report "Aged Accounts Receivable";
                        ToolTip = 'View an overview of when customer payments are due or overdue, divided into four periods. You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                    }
                    action("Customer - Payment Receipt")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Payment Receipt';
                        Image = "Report";
                        RunObject = Report "Customer - Payment Receipt";
                        ToolTip = 'View a document showing which customer ledger entries that a payment has been applied to. This report can be used as a payment receipt that you send to the customer.';
                    }
                    // action(CustListWithBalances)
                    // {
                    //     Caption = 'Customer Listing With Balances';
                    //     Image = "Report";
                    //     Promoted = true;
                    //     PromotedIsBig = true;
                    //     RunObject = Report "Customer Listing";
                    //     ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    // }
                    // action(CustItemStats)
                    // {
                    //     Caption = 'Customer/Item Statistics';
                    //     Image = "Report";
                    //     Promoted = true;
                    //     PromotedIsBig = true;
                    //     RunObject = Report "Customer/Item Statistics";
                    //     ToolTip = 'View a list of a customer''s transactions for a selected period, for example, to send to the customer at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';
                    // }
                    // action(CustItemStatsSalesP)
                    // {
                    //     ApplicationArea = Basic,Suite;
                    //     Caption = 'Cust. Item. Stat. by Salesp.';
                    //     Image = "Report";
                    //     RunObject = Report 10049;
                    //     ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
                    // }
                    // action(DailyInvRep)
                    // {
                    //     ApplicationArea = Basic,Suite;
                    //     Caption = 'Daily Invoicing Report';
                    //     Image = "Report";
                    //     RunObject = Report 10050;
                    //     ToolTip = 'View customer sales in a period, for example, to report sales activity to customs and tax authorities.';
                    // }
                    // action(ItemStatusBySalesp)
                    // {
                    //     ApplicationArea = Basic,Suite;
                    //     Caption = 'Item Status By salesp.';
                    //     Image = "Report";
                    //     RunObject = Report 10052;
                    //     ToolTip = 'View customers'' total costs, sales, and profits over time, for example, to analyze earnings trends. The report shows amounts for original and adjusted costs, sales, profits, invoice discounts, payment discounts, and profit percentage in three adjustable periods.';
                    // }
                    // action("Customer Register")
                    // {
                    //     Caption = 'Customer Register';
                    //     Image = "Report";
                    //     RunObject = Report 10046;
                    // }
                    // action("Customer - Top 10 List")
                    // {
                    //     Caption = 'Customer - Top 10 List';
                    //     Image = "Report";
                    //     RunObject = Report 111;
                    // }
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        SetSocialListeningFactboxVisibility;

        CRMIsCoupledToRecord :=
          CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RECORDID) AND CRMIntegrationEnabled;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetSocialListeningFactboxVisibility;
    end;

    trigger OnInit()
    begin
        SetCustomerNoVisibilityOnFactBoxes;
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    begin
        // CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

        SetWorkflowManagementEnabledState;
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SocialListeningSetupVisible: Boolean;
        SocialListeningVisible: Boolean;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EventFilter: Text;
        Customer1: Record "Customer";

    procedure GetSelectionFilter(): Text
    var
        Cust: Record "Customer";
        SelectionFilterManagement: Codeunit "SelectionFilterManagement";
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
        // EXIT(SelectionFilterManagement.GetSelectionFilterForCustomer(Cust));
    end;

    procedure SetSelection(var Cust: Record "Customer")
    begin
        CurrPage.SETSELECTIONFILTER(Cust);
    end;

    local procedure SetSocialListeningFactboxVisibility()
    var
        //SocialListeningMgt: Codeunit "Social Listening Management";
    begin
        //SocialListeningMgt.GetCustFactboxVisibility(Rec,SocialListeningSetupVisible,SocialListeningVisible);
    end;

    local procedure SetCustomerNoVisibilityOnFactBoxes()
    begin
        //CurrPage.SalesHistSelltoFactBox.PAGE.SetCustomerNoVisibility(FALSE);
        //CurrPage.SalesHistBilltoFactBox.PAGE.SetCustomerNoVisibility(FALSE);
        //CurrPage.CustomerDetailsFactBox.PAGE.SetCustomerNoVisibility(FALSE);
        //CurrPage.CustomerStatisticsFactBox.PAGE.SetCustomerNoVisibility(FALSE);
    end;

    local procedure SetWorkflowManagementEnabledState()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        EventFilter := WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode + '|' +
          WorkflowEventHandling.RunWorkflowOnCustomerChangedCode;

        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer, EventFilter);
    end;
}

