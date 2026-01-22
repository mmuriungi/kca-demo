/// <summary>
/// Page Employee Core Values (ID 50036).
/// </summary>
page 50720 "Employee Core Values"
{
    Caption = 'Employee Core Values';
    PageType = ListPart;
    SourceTable = "Employee Core Values";

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No field.';
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
