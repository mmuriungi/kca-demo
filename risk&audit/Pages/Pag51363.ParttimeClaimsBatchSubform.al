page 52099 "Parttime Claims Batch Subform"
{
    Caption = 'Parttime Claims';
    PageType = ListPart;
    SourceTable = "Parttime Claim Header";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the parttime claim number.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account number.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payee name.';
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the payment amount.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the claim.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the academic year for the claim.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the claim.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
}
