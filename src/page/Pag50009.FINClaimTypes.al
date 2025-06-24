page 50009 "FIN-Claim Types"
{
    PageType = Worksheet;
    SourceTable = "FIN-Receipts and Payment Types";
    SourceTableView = WHERE(Type = CONST(Claim));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("VAT Chargeable"; Rec."VAT Chargeable")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Chargeable"; Rec."Withholding Tax Chargeable")
                {
                    ApplicationArea = All;
                }
                field("PAYE Tax Chargeable"; Rec."PAYE Tax Chargeable")
                {
                    ApplicationArea = All;
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Withheld Code"; Rec."VAT Withheld Code")
                {
                    ApplicationArea = All;
                }
                field("PAYE Tax Code"; Rec."PAYE Tax Code")
                {
                    ApplicationArea = All;
                }
                field("Use PAYE Table"; Rec."Use PAYE Table")
                {
                    ApplicationArea = All;
                }
                field("Default Grouping"; Rec."Default Grouping")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Pending Voucher"; Rec."Pending Voucher")
                {
                    ApplicationArea = All;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                }
                field("Transation Remarks"; Rec."Transation Remarks")
                {
                    ApplicationArea = All;
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = All;
                }
                field("Customer Payment On Account"; Rec."Customer Payment On Account")
                {
                    ApplicationArea = All;
                }
                field("Direct Expense"; Rec."Direct Expense")
                {
                    ApplicationArea = All;
                }
                field("Calculate Retention"; Rec."Calculate Retention")
                {
                    ApplicationArea = All;
                }
                field("Retention Code"; Rec."Retention Code")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Retention Fee Code"; Rec."Retention Fee Code")
                {
                    ApplicationArea = All;
                }
                field("Retention Fee Applicable"; Rec."Retention Fee Applicable")
                {
                    ApplicationArea = All;
                }
                field("Subsistence?"; Rec."Subsistence?")
                {
                    ApplicationArea = All;
                }
                field("Council Claim?"; Rec."Council Claim?")
                {
                    ApplicationArea = All;
                }
                field("Telephone Allowance?"; Rec."Telephone Allowance?")
                {
                    ApplicationArea = All;
                }
                field("Pays Levy"; Rec."Pays Levy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pays Levy field.', Comment = '%';
                }
                field("Levy Code"; Rec."Levy Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Levy Code field.', Comment = '%';
                }
                field("Medical Claim?"; Rec."Medical Claim?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medical Claim? field.', Comment = '%';
                }
                field("Lecturer Claim?"; Rec."Lecturer Claim?")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lecturer Claim? field.', Comment = '%';
                }
                field("Claim PAYE Percentage"; Rec."Claim PAYE Percentage")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Claim PAYE Percentage field.', Comment = '%';
                }
                field(Fuel; Rec.Fuel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fuel field.', Comment = '%';
                }
                field("WHT 2 Code"; Rec."WHT 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the WHT 2 Code field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}