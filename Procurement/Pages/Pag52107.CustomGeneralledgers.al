page 52107 "Custom General ledgers"
{
    ApplicationArea = All;
    Caption = 'Custom General ledgers';
    PageType = List;
    SourceTable = "Custom Gen Ledgers";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.', Comment = '%';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("External Doc No"; Rec."External Doc No")
                {
                    ToolTip = 'Specifies the value of the External Doc No field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Shortcut dim 1"; Rec."Shortcut dim 1")
                {
                    ToolTip = 'Specifies the value of the Shortcut dim 1 field.', Comment = '%';
                }
                field("Shortcut dim 2"; Rec."Shortcut dim 2")
                {
                    ToolTip = 'Specifies the value of the Shortcut dim 2 field.', Comment = '%';
                }
                field(posted; Rec.posted)
                {
                    ToolTip = 'Specifies the value of the posted field.', Comment = '%';
                }
            }
        }
    }
}
