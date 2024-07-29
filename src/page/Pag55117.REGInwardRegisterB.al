page 55117 "REG-Inward Register B"
{
    Caption = 'Inward Register';
    PageType = List;
    SourceTable = "Inward Register B";
    CardPageId = "REG-Inward Register Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("File Date"; Rec."File Date")
                {
                    ToolTip = 'Specifies the value of the File Date field.';
                    ApplicationArea = All;
                }
                field("From Whom"; Rec."From Whom")
                {
                    ToolTip = 'Specifies the value of the From Whom field.';
                    ApplicationArea = All;
                }
                field("Ref No."; Rec."Ref No.")
                {
                    ToolTip = 'Specifies the value of the Ref No. field.';
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ToolTip = 'Specifies the value of the Subject field.';
                    ApplicationArea = All;
                }
                field("File Index"; Rec."File Index")
                {
                    ToolTip = 'Specifies the value of the File Index field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
