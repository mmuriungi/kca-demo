page 51438 "FLT-Setup Card"
{
    PageType = Card;
    SourceTable = "FLT-Fleet Mgt Setup";
    Caption = 'FLT-Setup Card';

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Transport Req No"; Rec."Transport Req No")
                {
                    ApplicationArea = All;
                }
                field("Daily Work Ticket"; Rec."Daily Work Ticket")
                {
                    ApplicationArea = All;
                }
                field("Fuel Register"; Rec."Fuel Register")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Request"; Rec."Maintenance Request")
                {
                    ApplicationArea = All;
                }
                field("Rotation Interval"; Rec."Rotation Interval")
                {
                    ApplicationArea = All;
                }
                field("Fuel Payment Batch No"; Rec."Fuel Payment Batch No")
                {
                    ApplicationArea = All;
                }
                field("Fuel Expense Account"; Rec."Fuel Expense Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L Account to use for fuel expenses when creating purchase invoices from fuel payment batches.';
                }
                field("Mileage Claim Nos."; Rec."Mileage Claim Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mileage Claim Nos. field.', Comment = '%';
                }
                field("Asset Incident Nos"; Rec."Asset Incident Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Asset Incident Nos field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}

