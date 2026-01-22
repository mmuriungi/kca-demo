page 51035 "Std-Charge  Reversal Line"
{
    Caption = 'Std-Charge  Reversal Line';
    PageType = ListPart;
    SourceTable = "Std-Charger Reversal Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Code field.', Comment = '%';
                }
                field("Charge Description"; Rec."Charge Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge Description field.', Comment = '%';
                }
                field("Charge G/l Account"; Rec."Charge G/l Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Charge G/l Account field.', Comment = '%';
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester Code field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field(amount; Rec.amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the amount field.', Comment = '%';
                }
            }
        }
    }
}
