page 52108 "Gen Ledger Cust"
{
    ApplicationArea = All;
    Caption = 'Gen Ledger Cust';
    PageType = List;
    SourceTable = "Custom Gen Ledgers";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
            }

        }

    }
    actions
    {
        area(Processing)
        {
            action(New)
            {
                ApplicationArea = All;
                runobject = XmlPort "Gen Journal Import";

            }
        }

    }
}
