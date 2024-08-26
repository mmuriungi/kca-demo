pageextension 50030 "Dimension Value PageExt" extends "Dimension Values"
{
    layout
    {
        addafter("Dimension Value Type")
        {
            field("G/L Account No."; Rec."G/L Account No.")
            {
                Caption = 'Budget Account';
                ApplicationArea = All;
            }
            field("G/L Name"; Rec."G/L Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(Blocked)
        {
            field(Category; Rec.Category)
            {
                ApplicationArea = All;

            }
        }
        addlast(Control1)
        {

            field("Senate Classification Based on"; Rec."Senate Classification Based on")
            {
                ToolTip = 'Specifies the value of the Senate Classification Based on field.';
                ApplicationArea = All;
            }
            field("HOD Names"; Rec."HOD Names")
            {
                ToolTip = 'Specifies the value of the HOD Names field.';
                ApplicationArea = All;
            }
        }
    }
}