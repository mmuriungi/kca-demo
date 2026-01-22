page 52178825 "Tender Financial Evaluation"
{
    PageType = List;
    SourceTable = "Tender Financial Evaluation";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Tender No."; Rec."Tender No.")
                {
                    ToolTip = 'Specifies the value of the Tender No. field.';
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ToolTip = 'Specifies the value of the Description 2 field.';
                    ApplicationArea = All;
                }
                field("Maximum Quote Value"; Rec."Budgeted Value")
                {
                    ToolTip = 'Specifies the value of the Maximum Quote Value field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quoted value"; Rec."Quoted value")
                {
                    ToolTip = 'Specifies the value of the Quoted value field.';
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
            }
        }
    }


}