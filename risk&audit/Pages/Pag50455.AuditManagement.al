page 50102 "Audit Management"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            group(General)
            {
                part("Audit Cues"; "Audit Cues")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    //
    actions
    {
        area(Sections)
        {
            group("Risk Register")
            {
                action("Risks Champion List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Risks Champion List';
                    RunObject = page "Risks List";
                }
                action("Risk Manager Listt")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Risk Manager List';
                    RunObject = page "Risk Champion List";
                }
                action("Approved Risk From Champions")
                {
                    Caption = 'Approved Risk From Champions';
                    ApplicationArea = All;
                    RunObject = page "Approved Risk From Champions";
                }
                action("Consolidated Risk List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Consolidated Risk List';
                    RunObject = page "Consolidated Risk List";
                }
                action("Approved Risk List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Risk List';
                    RunObject = page "Approved Risk List";
                }
            }
            group("Audit Plans")
            {
                action("Audit Plan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Plan';
                    RunObject = page "Audit Plan List";
                }
                // action("CEO Audit Plan List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'CEO Audit Plan List';
                //     RunObject = page "Council Audit Plan List";
                // }
                // action("Approved Audit Plans")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Approved Audit Plans';
                //     RunObject = page "Approved Audit Plans";
                // }
                action("Audit Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Period';
                    RunObject = page "Audit Period";
                }
                //
            }
            group("Audit Process")
            {
                action("Audit Programs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Program';
                    RunObject = page "Audit Program List";
                }
                action("Audit Work Papers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Work Papers';
                    RunObject = page "Audit Work Papers";
                }
                action("Audit Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Reports';
                    RunObject = page "Audit Reports";
                }
            }
            group("Audit Reports")
            {

                action("Audit Program")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Program';
                    RunObject = report "Audit Program";
                }
                action("Audit Working Paper")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Working Paper';
                    RunObject = report "Audit Working Paper";
                }


            }
            group("Internal Audit Champions")
            {
                Visible = false;
                action("Audit Champions")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Champions';
                    RunObject = page "Internal Audit Champions";
                }
            }
            group("Reviewed Audit Work Papers")
            {
                action("Audit Working Papers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Working Papers';
                    RunObject = page "Reviewed Audit Work Papers";
                }
                action("Auditee Review")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Auditee Review';
                    RunObject = page "Auditee Review";
                }
                action("Closed Audit Reports")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Audit Reports';
                    RunObject = page "Closed Audit Reports";
                }
                action("Auditee Reports")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Auditee Reports';
                    RunObject = page "Auditee Reports";
                }
            }
            group("Audit Recommendations")
            {
                action("Audit Recommendation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Recommendation';
                    RunObject = page "Audit Recommendations List";
                }
            }
            group(Audit)
            {
                Visible = false;
                action("Audit List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit List';
                    RunObject = page "Audit List";
                }

            }
            group("Audit Communications")
            {
                action("Audit Communication")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Communications';
                    RunObject = page "Audit Communications";
                }
                action("Sent Communications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Audit Communications';
                    RunObject = page "Sent Audit Communications";
                }
                action("Audit Notifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Notifications';
                    RunObject = page "Audit Notifications";
                }
                action("Sent Audit Notifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Audit Notifications';
                    RunObject = page "Sent Audit Notifications";
                }
                // action("Audit Program List")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Audit Program List';
                //     RunObject = page "Audit Program List";
                // }
                // action("Audit Work Papers")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Audit Work Papers';
                //     RunObject = page "Audit Work Papers";
                // }


            }
            group("Audit Workplans")
            {
                action("Audit Workplan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Workplan';
                    RunObject = page "Audit Workplans";
                }
            }

            group("Audit Set-Ups")
            {
                action("Audit Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Types';
                    RunObject = page "Audit Types";
                }
                action("Audit Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Setup';
                    RunObject = page "Audit SetUp List";
                }
                action("Audit Ratings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Audit Ratings';
                    RunObject = page "Audit Ratings";
                }
                action("Risk KRI")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Risk KRI';
                    RunObject = page "Risk KRI";
                }
                action("ICT SetUp")
                {
                    Visible = false;
                    ApplicationArea = Basic, Suite;
                    Caption = 'ICT Setup';
                    RunObject = page "ICT Setup";
                }

                action("Risk Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Risk Categories';
                    RunObject = page "Risk Categories";
                }
                action("Risk Evaluation Score")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Risk Evaluation Score';
                    RunObject = page "Risk Evaluation Score";
                }
                action("Risk Score Colours")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Risk Evaluation colours';
                    RunObject = page "Risk Score Colours";
                }


            }
            group("Posted Document List")
            {
                Image = FiledPosted;
                action("Posted PVs")
                {
                    RunObject = page "Posted Payment Vouchers1";
                }
                action("Posted Receipts")
                {
                    RunObject = Page "Posted Receipts";
                }

                action("Posted Petty Cash")
                {
                    RunObject = Page "Posted Petty cash";
                }
                action("Posted Petty Cash Surrenders")
                {
                    RunObject = Page "Posted Petty Cash Surrenders";
                }
                action("Posted Credit Memos1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = page "Posted Purchase Credit Memos";
                }
                action("Posted Purchase Invoices12")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = Suite;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = page "Posted Purchase Receipts";
                }
                action("Posted Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoices";
                }
                action("Posted Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = page "Posted Sales Credit Memos";
                }
                action("Posted Return Receipts")
                {
                    ApplicationArea = SalesReturnOrder;
                    Caption = 'Posted Return Receipts';
                    RunObject = page "Posted Return Receipts";
                }
                action("Posted Imprests")
                {
                    ApplicationArea = SalesReturnOrder;
                    RunObject = page "Posted Imprests";
                }
                action("Posted Imprest Surrenders")
                {
                    ApplicationArea = SalesReturnOrder;
                    RunObject = page "Posted Imprest Surrenders";
                }
                action("Posted Staff Claims")
                {
                    ApplicationArea = SalesReturnOrder;
                    RunObject = page "Posted Staff Claim";
                }

            }
            // group(Reports)
            // {
            //     action("Posted Payment Voucher List")
            //     {
            //         Image = Payment;
            //         RunObject = report "Payment Voucher List";
            //     }
            //     action("Petty Cash List")
            //     {
            //         RunObject = report "Petty Cash List";
            //     }
            //     action("Imprest List")
            //     {
            //         RunObject = report "Imprest List";
            //     }
            //     action("Imprest Surrender List")
            //     {
            //         RunObject = report "Imprest Surrender List";
            //     }
            //     action("Petty Cash Surrender List")
            //     {
            //         RunObject = report "Petty Cash Surrender List";
            //     }
            //     action("Staff Claim List")
            //     {
            //         RunObject = report "Staff Claim List";
            //     }
            //     action("Receipt List")
            //     {
            //         RunObject = report "Receipt List";
            //     }
            // }
            // group("Reversed")
            // {
            //     Image = ReverseLines;
            //     action("Reversed Receipts")
            //     {
            //         RunObject = Page "Reversed Receipts";
            //     }
            // }
        }
    }
}


