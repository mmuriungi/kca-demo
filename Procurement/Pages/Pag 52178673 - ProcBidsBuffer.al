page 52178673 "Proc Bids Buffer"
{
    Caption = 'Proc Bids Buffer';
    PageType = List;
    SourceTable = "Proc Bids Buffer";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No field.', Comment = '%';
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No field.', Comment = '%';
                }
                field(Supplier; Rec.Supplier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("External Doc No"; Rec."External Doc No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Doc No field.', Comment = '%';
                }
            }
        }
    }
}
