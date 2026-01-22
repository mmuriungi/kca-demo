page 50006 "Cash Office User Template UP"
{
    DataCaptionFields = UserID;
    PageType = Card;
    SourceTable = "FIN-Cash Office User Template";

    layout
    {
        area(content)
        {
            repeater(____________)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Default Direct Sale Customer"; Rec."Default Direct Sale Customer")
                {
                    ToolTip = 'Specifies the value of the Default Direct Sale Customer field.';
                    ApplicationArea = All;
                }
                field("Default Direct Sales Location"; Rec."Default Direct Sales Location")
                {
                    ToolTip = 'Specifies the value of the Default Direct Sales Location field.';
                    ApplicationArea = All;
                }
                field("Direct  Cash Sale Paybill"; Rec."Direct  Cash Sale Paybill")
                {
                    ToolTip = 'Specifies the value of the Direct  Cash Sale Paybill field.';
                    ApplicationArea = All;
                }
                field("Max. Cash Collection"; Rec."Max. Cash Collection")
                {
                    ToolTip = 'Specifies the value of the Max. Cash Collection field.';
                    ApplicationArea = All;
                }
                field("Max. Cheque Collection"; Rec."Max. Cheque Collection")
                {
                    ToolTip = 'Specifies the value of the Max. Cheque Collection field.';
                    ApplicationArea = All;
                }
                field("Max. Deposit Slip Collection"; Rec."Max. Deposit Slip Collection")
                {
                    ToolTip = 'Specifies the value of the Max. Deposit Slip Collection field.';
                    ApplicationArea = All;
                }
                field("Direct Sales Item Category"; Rec."Direct Sales Item Category")
                {
                    ToolTip = 'Specifies the value of the Direct Sales Item Category field.';
                    ApplicationArea = All;
                }
                field("Direct Sales Inv. Nos."; Rec."Direct Sales Inv. Nos.")
                {
                    ToolTip = 'Specifies the value of the Direct Sales Inv. Nos. field.';
                    ApplicationArea = All;
                }
                field("Direct Sales External Doc. Nos"; Rec."Direct Sales External Doc. Nos")
                {
                    ToolTip = 'Specifies the value of the Direct Sales External Doc. Nos field.';
                    ApplicationArea = All;
                }
                field("Direct Cash Sale Deposit Nos."; Rec."Direct Cash Sale Deposit Nos.")
                {
                    ToolTip = 'Specifies the value of the Direct Cash Sale Deposit Nos. field.';
                    ApplicationArea = All;
                }
                field("Direct Cash Sale Bank"; Rec."Direct Cash Sale Bank")
                {
                    ToolTip = 'Specifies the value of the Direct Cash Sale Bank field.';
                    ApplicationArea = All;
                }
                field("Cash Receipt No. Series"; Rec."Cash Receipt No. Series")
                {
                    ToolTip = 'Specifies the value of the Cash Receipt No. Series field.';
                    ApplicationArea = All;
                }
                field("Advance  Batch"; Rec."Advance  Batch")
                {
                    ToolTip = 'Specifies the value of the Other Advance  Batch field.';
                    ApplicationArea = All;
                }
                field("Advance Surr Batch"; Rec."Advance Surr Batch")
                {
                    ToolTip = 'Specifies the value of the Other Advance Surr Batch field.';
                    ApplicationArea = All;
                }
                field("Advance Surr Template"; Rec."Advance Surr Template")
                {
                    ToolTip = 'Specifies the value of the Other Advance Surr Template field.';
                    ApplicationArea = All;
                }
                field("Advance Template"; Rec."Advance Template")
                {
                    ToolTip = 'Specifies the value of the Other Advance Template field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    ApplicationArea = All;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    ToolTip = 'Specifies the value of the Supervisor ID field.';
                    ApplicationArea = All;
                }

                field("Receipt Journal Template"; Rec."Receipt Journal Template")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Receipt Journal Batch"; Rec."Receipt Journal Batch")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Imprest  Batch"; Rec."Imprest  Batch")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Default Receipts Bank"; Rec."Default Receipts Bank")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Default Petty Cash Bank"; Rec."Default Petty Cash Bank")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Default Payment Bank"; Rec."Default Payment Bank")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Payment Journal Template"; Rec."Payment Journal Template")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Payment Journal Batch"; Rec."Payment Journal Batch")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Petty Cash Batch"; Rec."Petty Cash Batch")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Inter Bank Template Name"; Rec."Inter Bank Template Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Inter Bank Batch Name"; Rec."Inter Bank Batch Name")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Bank Pay In Journal Template"; Rec."Bank Pay In Journal Template")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Bank Pay In Journal Batch"; Rec."Bank Pay In Journal Batch")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Claim  Batch"; Rec."Claim  Batch")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Claim Template"; Rec."Claim Template")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}
