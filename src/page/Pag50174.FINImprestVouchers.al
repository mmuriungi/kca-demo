page 50174 "FIN-Imprest Vouchers"
{
    ApplicationArea = All;
    Caption = 'FIN-Imprest Vouchers';
    PageType = List;
    CardPageId = "FIN-Imprest Voucher Card";
    SourceTable = "FIN-Payments Header";
    SourceTableView = WHERE(Posted = filter(false), Status = FILTER(<> Cancelled), "Imprest Voucher" = filter(true));
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
            }
        }
    }
}
