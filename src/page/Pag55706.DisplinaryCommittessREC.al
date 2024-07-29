page 55706 "Displinary Committess REC"
{
    PageType = List;
    SourceTable = "Displinary Committess REC";

    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Case No."; Rec."Case No.")
                {
                    ToolTip = 'Specifies the value of the Case No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Committe; Rec.Committe)
                {
                    ToolTip = 'Specifies the value of the Committe field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reccomendation Code"; Rec."Reccomendation Code")
                {
                    ToolTip = 'Specifies the value of the Reccomendation Code field.';
                    ApplicationArea = All;
                }
                field("Recommendation Description"; Rec."Recommendation Description")
                {
                    ToolTip = 'Specifies the value of the Recommendation Description field.';
                    ApplicationArea = All;
                }
                field("Recommendation Description2"; Rec."Recommendation Description2")
                {
                    ToolTip = 'Specifies the value of the Recommendation Description2 field.';
                    ApplicationArea = All;
                }
                field("Recommendation Date"; Rec."Recommendation Date")
                {
                    ToolTip = 'Specifies the value of the Recommendation Date field.';
                    ApplicationArea = All;
                }
                field("Recommendation Effective Date"; Rec."Recommendation Effective Date")
                {
                    ToolTip = 'Specifies the value of the Recommendation Effective Date field.';
                    ApplicationArea = All;
                }
                field("Reccomendation Effected"; Rec."Reccomendation Effected")
                {
                    ToolTip = 'Specifies the value of the Reccomendation Effected field.';
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}