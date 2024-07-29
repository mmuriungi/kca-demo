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

                //"Proc-Target Groups
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
                // action(planning)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Procurement Plan';
                //     RunObject = Page "Departmental  Procurement List";
                //     ToolTip = 'Create purchase requisition from departments.';
                // }

                action("Consolidated Plan")
                {
                    Caption = 'Consolidated Plan';
                    ApplicationArea = all;
                    RunObject = Page "Consolidated Plan List";
                }
                // action("Budget Workplan Names")
                // {
                //     Caption = 'Budget Workplan Names';
                //     RunObject = Page 50163;
                // }
                // action("Procurement Method")
                // {
                //     Caption = 'Procurement Methods';
                //     RunObject = Page 50169;
                // }
                // action("Workplan Activities")
                // {
                //     Caption = 'Workplan Activities';
                //     RunObject = Page 50157;
                // }
                // action("Budget")
                // {
                //     Caption = 'Budget Workplan';
                //     RunObject = Page 50161;
                // }
                // action(WorkPlan_Creation)
                // {
                //     Caption = 'WorkPlan Creation';
                //     RunObject = Page 50165;
                // }
            }
            Group("Internal Purchase Requisitions")
            {
                action("Purchase Requisition1")
                {
                    ApplicationArea = All;
                    // Caption = 'Caption', comment = 'NLB="YourLanguageCaption"';
                    Image = History;

                    RunObject = page "Purchase Requisition Header1";
                }

            }


        }
        addbefore("Posted Documents")
        {
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
                    //RunObject = Page "Tender Preliminary QualfyList";
                    RunObject = Page "Tender Prelim QualifyiedL";
                }
                action(TechnicalQualifiers)
                {
                    Caption = 'Technical Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Technical QualifyiedL";
                    //RunObject = Page "Tender Technical QualifiedList";

                }
                action(DemoQualifiers)
                {
                    Caption = 'Demonstration Qualifiers';
                    ApplicationArea = basic, suite;
                    RunObject = Page "Tender Demo QualifyiedL";
                    //RunObject = Page "Tender Demo QualifiedList";
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
                // action("Page FLT Transport Requisition2")
                // {
                //     Caption = 'Transport Requisition';
                //     ApplicationArea = All;
                //     RunObject = Page "FLT-Transport Req. List";
                // }

                // action("Meal Booking")
                // {
                //     Caption = 'Meal Booking';
                //     ApplicationArea = All;
                //     RunObject = Page "CAT-Meal Booking List";
                // }
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
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create a new purchase order.';
            }
        }
        addbefore("Posted Documents")
        {
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
        }

    }






}
