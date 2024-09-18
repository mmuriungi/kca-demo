pageextension 50006 "Purchasing Agent Role Center" extends "Purchasing Agent Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group("Approval Requests")
            {
                action(approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approval Requests';
                    Image = Approve;
                    RunObject = page "Requests to Approve";
                }
            }
        }
        addbefore("Purchase &Quote")
        {
            action("Purchase Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Requisitions';
                RunObject = Page "FIN-Purchase Requisition";
                ToolTip = 'Create purchase requisition from departments.';
            }

            action("Approved Purchase Requisitions")
            {
                ApplicationArea = Suite;
                Caption = 'Approved Purchase Requisitions';
                RunObject = Page "Approved Purchase Requisition";
                ToolTip = 'Stores Approved purchase requisition from departments.';
            }
        }

        addafter("Purchase Requisitions")
        {
            action(FRQs)
            {
                Image = Purchase;
                ApplicationArea = Suite;
                Caption = 'RFQs';
                RunObject = Page "PROC-Purchase Quote List";
                ToolTip = 'Create purchase requisition from departments.';
            }
        }
        addafter(FRQs)
        {
            action(Quotes)
            {
                Image = Purchase;
                ApplicationArea = Suite;
                Caption = 'Quotes';
                RunObject = Page "Proc-Purchase Quotes List";
                ToolTip = 'Create a Quote';
            }
        }
        addbefore("Posted Documents")
        {
            group("Supplier Prequalification")
            {
                action("Prequalification Years")
                {
                    ApplicationArea = all;
                    RunObject = page "Proc-Prequalification Years";
                }
                action("Prequalification categories")
                {
                    ApplicationArea = all;
                    RunObject = page "Prequalification Categories";
                }
                action("Prequalification Suppliers/Categories")
                {
                    ApplicationArea = all;
                    RunObject = page "Prequalified Cat/Years List";
                }
            }
            group(ProcPlan)
            {
                Caption = 'Procurement Planing';

                action("Procurement Period")
                {
                    caption = 'Procurement Period';
                    RunObject = page "Proc-Procure. Plan Period1";
                    ApplicationArea = all;
                }
                action("Procurement Plan")
                {
                    Caption = 'Departmental Poscurement Plant';
                    Image = Worksheet;
                    ApplicationArea = All;
                    RunObject = Page "Departmental  Procurement List";
                }
                action("Consolidated Plan")
                {
                    Caption = 'Consolidated Plan';
                    ApplicationArea = all;
                    RunObject = Page "Consolidated Plan List";
                }
            }
            Group("Internal Purchase Requisitions")
            {
                action("Purchase Requisition1")
                {
                    ApplicationArea = All;
                    Image = History;
                    RunObject = page "Purchase Requisition Header1";
                }
            }
            group(Tender)
            {
                Caption = 'Tendering Process';
                Image = LotInfo;

                action("Tendering")
                {
                    Caption = 'Tender Applicants';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Applicants List";
                }
                action(Tenders)
                {
                    Caption = 'Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender List";
                }
                action(SubmittedTenders)
                {
                    Caption = 'Submitted Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Submission List View";
                }
                action(PreliminaryQualifiers)
                {
                    Caption = 'Preliminary Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Prelim QualifyiedL";
                }
                action(TechnicalQualifiers)
                {
                    Caption = 'Technical Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Technical QualifyiedL";
                }
                action(DemoQualifiers)
                {
                    Caption = 'Demonstration Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Demo QualifyiedL";
                }
                action(FinancialQualifiers)
                {
                    Caption = 'Financial Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Fin QualifyiedL";
                }
                action(Award)
                {
                    Caption = 'Awarded';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Awarded List";
                }
                group(TenderSetup)
                {
                    Caption = 'Setups';
                    action("No.series")
                    {
                        Caption = 'Tendering Series';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Tender Series Setup";
                    }
                    action(PreliminarySetup)
                    {
                        Caption = 'Preliminary Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Preliminary Reqs Setup";
                    }
                    action(TechnicalSetup)
                    {
                        Caption = 'Technical Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Technical Eval Setup";
                    }
                    action(DemoSetup)
                    {
                        Caption = 'Demonstration Setups';
                        ApplicationArea = basic, suite;
                        RunObject = Page "Tender Demo Setup";
                    }
                    action(financialSetup)
                    {
                        Caption = 'Financial Setups';
                        ApplicationArea = All;
                        RunObject = Page "Tender Financial Setups";
                    }
                }
            }
            group(TenderD)
            {
                Caption = 'Failed Bids';
                action(PQTenders)
                {
                    Caption = 'Preliminary Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Preliminary List";
                }
                action(TQTenders)
                {
                    Caption = 'Technical Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Technical List";
                }
                action(DQTenders)
                {
                    Caption = 'Demo Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Demo List";
                }
                action(FQTenders)
                {
                    Caption = 'Financial Disqualified';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Disq Financial List";
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = all;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "PROC-Store Requisition";
                }
                action(Action1000000003)
                {
                    ApplicationArea = all;
                    Caption = 'Leave Applications';
                    RunObject = Page "HRM-Leave Requisition List";
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    Visible = false;
                    RunObject = Page "HRM-My Approved Leaves List";
                }
                action("Claim  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Claim Requisitions';
                    RunObject = Page "FIN-Staff Claim List";
                    ToolTip = 'Create Claim requisition from Users.';
                }
                action("Purchase  Requisitions")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Requisitions';
                    RunObject = Page "FIN-Purchase Requisition";
                    ToolTip = 'Create purchase requisition from departments.';
                }
                action("Imprest Requisitions")
                {
                    Caption = 'Imprest Requisitions';
                    ApplicationArea = All;
                    RunObject = Page "FIN-Imprests List";
                }
            }
            group("Store Requisition")
            {
                Caption = 'Store Requisitions';
                action("Store Requests")
                {
                    ApplicationArea = All;
                    Image = Document;
                    RunObject = Page "PROC-Store Requisition";
                }
                action("All SRNS")
                {
                    ApplicationArea = All;
                    Image = AboutNav;
                    RunObject = page "All Store Requisition";
                }
                action("Approved SRNS")
                {
                    ApplicationArea = All;
                    Image = SettleOpenTransactions;
                    RunObject = Page "PROC-Approved Store Reqs";
                }
                action("Posted Store Requisitions")
                {
                    Caption = 'Posted SRNS';
                    ApplicationArea = All;
                    Image = PostedOrder;
                    RunObject = Page "PROC-Posted Store Reqs";
                }
            }
            group("Reports")
            {
                action("PO Report")
                {
                    ApplicationArea = All;
                    Image = OrderList;
                    RunObject = Report "Order Status Report";
                }
            }
            group(ProcurementProcesses)
            {
                Caption = 'Procurement Processes V1';
                Image = Purchasing;
                action("Proc-Prequalification Years")
                {
                    Caption = 'Prequalification Years';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Proc-Prequalification Years";
                }
                action("Prequalification Application")
                {
                    Caption = 'Prequalification Application';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Prequalification Application";
                }
                action("Proc-Prequalification Categories")
                {
                    Caption = 'Prequalification Categories/Years';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Proc-Preq. Categories/Year";
                }
                action("PROC Open.Tender Header")
                {
                    Caption = 'Open Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "PROC Open.Tender List";
                }
                action("PROC-Purchase Restricted List")
                {
                    Caption = 'Restricted Tenders';
                    ApplicationArea = basic, suite;
                    RunObject = Page "PROC-Purchase Restricted List";
                }
                action("PROC-Purchase Direct List")
                {
                    Caption = 'Direct Procurement';
                    ApplicationArea = basic, suite;
                    RunObject = Page "PROC-Purchase Direct List";
                }
                action("PROC-Two Stage.Tender List")
                {
                    Caption = 'Two Stage Tender';
                    ApplicationArea = basic, suite;
                    RunObject = Page "PROC-Two Stage.Tender List";
                }
            }
        }
        modify("Purchase &Order")
        {
            Visible = false;
        }
        modify("Purchase &Quote")
        {
            Visible = false;
        }
        addafter(Quotes)
        {
            action("Procurement &Order")
            {
                ApplicationArea = Suite;
                Caption = 'Procurement &Order';
                Image = Document;
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create a new purchase order.';
            }
        }
    }
}
