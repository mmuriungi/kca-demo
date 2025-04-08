page 50462 "Risk Evaluation Score"
{
    ApplicationArea = All;
    Caption = 'Risk Evaluation Score';
    PageType = List;
    SourceTable = "Risk Evaluation Score";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Score field.';
                }
                field("Risk Rating"; "Risk Rating")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    trigger OnValidate()
                    begin
                        StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(Rec);
                    end;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        StyleExprTxt := RiskRatingColourCodes.RiskRatingColours(Rec);
    end;

    var
        StyleExprTxt: Text;
        RiskRatingColourCodes: Codeunit "Risk Ratings Colour Codes";
}

