/// <summary>
/// Page Appraisal  Card (ID 50012).
/// </summary>
page 51326 "Appraisal List"
{
    Caption = 'Appraisal  List';
    CardPageId = "Appraisal Card";
    PageType = List;
    Editable = false;
    SourceTable = Appraisal;

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
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }


            }
        }

    }
    actions
    {
        area(Processing)
        {
            action("Appraisal Report")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    Appraisal.Reset();
                    Appraisal.SetRange("Appraisal No", rec."Appraisal No");
                    if Appraisal.Find('-') then begin
                        report.Run(report::"Appraisal Report", true, true, Appraisal);
                    end;

                end;
            }

        }
    }
    /*  trigger OnOpenPage()
     begin
         rec.SetFilter(rec."Created By", UserId);
     end; */

    var
        Appraisal: Record Appraisal;
}
