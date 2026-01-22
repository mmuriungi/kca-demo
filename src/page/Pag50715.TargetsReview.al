/// <summary>
/// Page Targets Review (ID 50016).
/// </summary>
page 50715 "Targets Review"
{
    Caption = 'Targets Review';
    PageType = ListPart;
    SourceTable = "Targets kra kpi";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(KRA; Rec.KRA)
                {
                    Caption = 'Key Result Area';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the KRA field.';
                }
                field("Strategic Objectives"; Rec."Strategic Objectives")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Strategic Objectives field.';
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(KPIs; Rec.KPIs)
                {
                    Caption = 'Key Perfomance Indicator';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the KPIs field.';
                }
                field(Timelines; Rec.Timelines)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Timelines field.';
                }
                field("Target Score"; Rec."Target Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Target Score field.';
                }
                field("Achieved Outcome"; Rec."Achieved Outcome")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Achieved Outcome field.';
                }
                field("Self Access"; Rec."Self Access")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Self Access field.';
                }
                field("Supervisor Access"; Rec."Supervisor Access")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Access field.';
                }

            }
        }
    }
}
