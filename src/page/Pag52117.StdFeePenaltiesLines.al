page 52117 "Std-Fee Penalties Lines"
{
    Caption = 'Std-Fee Penalties Lines';
    PageType = ListPart;
    SourceTable = "std Fee penalties Line";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.', Comment = '%';
                }
                field(Penalty; Rec.Penalty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Penalty field.', Comment = '%';
                }
            }
        }
    }
}
