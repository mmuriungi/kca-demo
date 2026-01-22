page 52178814 "Tender Demonstration Req"
{
    PageType = List;
    SourceTable = "Tender Demonstration Req";
    layout
    {
        area(Content)
        {
            repeater(General)
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
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ToolTip = 'Specifies the value of the Maximum Score field.';
                    ApplicationArea = All;
                }

                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
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