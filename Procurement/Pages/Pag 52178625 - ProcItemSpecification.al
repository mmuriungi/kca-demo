page 52178625 "Proc Item Specification"
{
    Caption = 'Proc Item Specification';
    PageType = List;
    SourceTable = "Proc Item Specifications";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("S/No"; Rec."S/No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the S/No field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
