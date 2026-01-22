page 51627 "Stud Reg Form Line"
{
    Caption = 'Stud Reg Form Line';
    PageType = ListPart;
    SourceTable = "Stud Reg Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Process field.', Comment = '%';
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field.', Comment = '%';
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remark field.', Comment = '%';
                }
            }
        }
    }
}
