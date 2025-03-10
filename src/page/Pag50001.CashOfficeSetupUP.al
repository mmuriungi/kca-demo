page 50001 "Cash Office Setup UP"
{
    PageType = Card;
    SourceTable = "Cash Office Setup";

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Normal Payments No"; Rec."Normal Payments No")
                {
                    ApplicationArea = All;
                    //Caption = 'Pv';
                }
                field("Cheque Reject Period"; Rec."Cheque Reject Period")
                {
                    ApplicationArea = All;
                }
                field("Petty Cash Payments No"; Rec."Petty Cash Payments No")
                {
                    ApplicationArea = All;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    ApplicationArea = All;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = All;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = All;
                }
                field("Bank Deposit No."; Rec."Bank Deposit No.")
                {
                    ApplicationArea = All;
                }
                field("Staff Claim No"; Rec."Staff Claim No")
                {
                    ApplicationArea = All;
                }
                field("InterBank Transfer No."; Rec."InterBank Transfer No.")
                {
                    ApplicationArea = All;
                }
                field("Surrender Template"; Rec."Surrender Template")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Surrender  Batch"; Rec."Surrender  Batch")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Receipts No"; Rec."Receipts No")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Cashier Transfer Nos"; Rec."Cashier Transfer Nos")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Default Bank Deposit Slip A/C"; Rec."Default Bank Deposit Slip A/C")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Imprest Req No"; Rec."Imprest Req No")
                {
                    ApplicationArea = All;
                    Visible = true;
                    Caption = 'Imprest Req No.';
                }
                field("Imprest Surrender No"; Rec."Imprest Surrender No")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("PV Template"; Rec."PV Template")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Surrender Dates"; Rec."Surrender Dates")
                {
                    ApplicationArea = all;

                }
                field("PV  Batch"; Rec."PV  Batch")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Payment Schedule No."; Rec."Payment Schedule No.")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Memo Nos."; Rec."Memo Nos.")
                {
                    ApplicationArea = All;
                    // ToolTip = 'Specifies the value of the Parttime payee code field.';
                }
                field("Interest G/l Acc"; Rec."Interest G/l Acc")
                {
                    ApplicationArea = all;

                }
                field("Interest %"; Rec."Interest %")
                {
                    ApplicationArea = all;
                }
                field("Cheque Buffer No"; Rec."Cheque Buffer No")
                {
                    ApplicationArea = all;
                }
                field("Virement Nos"; Rec."Virement Nos")
                {
                    ApplicationArea = all;

                }
                field("FA Movement Nos"; Rec."FA Movement Nos")
                {
                    ApplicationArea = all;
                }
                group("Part Timers Setup")
                {
                    field("Parttime Claim Nos"; Rec."Parttime Claim Nos")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Parttime Claim Nos field.';
                    }
                    field("Parttimers Expense Account"; Rec."Parttimers Expense Account")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Parttimers Expense Account field.';
                    }
                    field("Parttime payee code"; Rec."Parttime payee code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Parttime payee code field.';
                    }
                    field("Budget Nos"; Rec."Budget Nos")
                    {
                        ApplicationArea = all;

                    }

                }
                group("Finance Controls")
                {
                    field("Max Unsurrendered Imprest"; Rec."Max Unsurrendered Imprest")
                    {
                        ApplicationArea = all;
                    }

                }

            }
        }
    }

    actions
    {
    }
}
