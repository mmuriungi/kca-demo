/// <summary>
/// Page Targets/Krs (ID 50014).
/// </summary>
page 50713 "Targets/Krs"
{
    Caption = 'Targets/Krs';
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
                    ToolTip = 'Specifies the value of the Appraisal No field.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field("Kra Sn"; Rec."Kra Sn")
                {
                    Caption = 'S/N';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Kra Sn field.';
                }


                field(KRA; Rec.KRA)
                {
                    caption = 'Key Result Areas';
                    ApplicationArea = All;

                    ToolTip = 'Specifies the value of the KRA field.';
                }
                field("Strategic Objectives"; Rec."Strategic Objectives")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Strategic Objectives field.';
                }
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field(KPIs; Rec.KPIs)
                {
                    caption = 'Key Perfomance Indicators';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KPIs field.';
                }
                field(Timelines; Rec.Timelines)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Timelines field.';
                }
                field("Target Score"; Rec."Target Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Score field.';

                }
                field("Achieved Outcome"; Rec."Achieved Outcome")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Achieved Outcome field.';
                }
                field("Self Access"; Rec."Self Access")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Self Access field.';
                }
                field("Supervisor Access"; Rec."Supervisor Access")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supervisor Access field.';
                }
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action("Get Targets")
            {
                ApplicationArea = all;
                Image = GetLines;
                trigger OnAction()
                begin
                    rec.Reset();
                    rec.SetRange("Employee No", rec."Employee No");
                    rec.SetRange("Appraisal No", rec."Appraisal No");
                    rec.GenerateTargets();
                end;
            }
        }
    }






}
