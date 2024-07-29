page 54340 "Pos Unit of measure"
{
    PageType = List;
    SourceTable = "Pos Unit of Measure";

    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Code field.';
                    Editable = false;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Student Price"; Rec."Student Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the International Standard Code field.';
                }
                field("Staff Price"; Rec."Staff Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Price field.';
                }
            }
        }
    }

}