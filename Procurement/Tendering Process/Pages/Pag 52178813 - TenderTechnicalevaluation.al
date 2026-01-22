page 52178813 "Tender Technical evaluation"
{
    PageType = List;
    SourceTable = "Tender Technical evaluation";
    layout
    {
        area(content)
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
                field(score; Rec.score)
                {
                    ToolTip = 'Specifies the value of the score field.';
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