#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 68790 "ACA-Posted Receipts Buffer1"
{
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Imp. Receipts Buffer";
    SourceTableView = where(Posted=const(true));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Student No.";Rec."Student No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Receipt No";Rec."Receipt No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Receipting)
            {
                Caption = 'Receipting';
            }
        }
    }

    var
        StudPayments: Record "ACA-Std Payments";
        RcptBuffer: Integer;
}

