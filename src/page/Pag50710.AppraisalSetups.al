/// <summary>
/// Page Appraisal Setups (ID 50011).
/// </summary>
page 50710 "Appraisal Setups"
{
    Caption = 'Appraisal Setups';
    PageType = List;
    SourceTable = "Appraisal Setups";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No field.';
                }

                field("Max Score"; Rec."Max Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Max Score field.';
                }
                field(Pk; Rec.Pk)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pk field.';
                }
            }
        }
    }
}
