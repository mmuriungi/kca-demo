/// <summary>
/// Page Core Values (ID 50030).
/// </summary>
page 51331 "Core Values"
{
    Caption = 'Core Values';
    PageType = ListPart;
    SourceTable = Appraisal;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field.';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No field.';
                }
                
                field("Self Assement"; Rec."Self Assement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Self Assement field.';
                }
                field("Supervisors Comment"; Rec."Supervisors Comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisors Comment field.';
                }
                field("Response Scale"; Rec."Response Scale")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Response Scale field.';
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rating field.';
                }
            }
        }
    }
}
