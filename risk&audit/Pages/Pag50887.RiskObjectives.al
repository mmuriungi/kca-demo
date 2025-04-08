page 50236 "Risk Objectives"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Risk Objectives";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Objective Code"; Rec."Objective Code")
                {
                    ApplicationArea = All;

                }
                field("Objective Description"; Rec."Objective Description")
                {

                }
                field(Status; Rec.Status)
                {

                }
                field("Function Code"; Rec."Function Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Function Code field.';
                }
                field("Function Description"; Rec."Function Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Function Description field.';
                }
                field("Objective Average"; Rec."Objective Average")
                {
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Total := 0;
        CountNo := 0;
        ObjRiskDetails.reset();
        ObjRiskDetails.SetRange(ObjRiskDetails.Objective, Rec."Objective Code");
        if ObjRiskDetails.FindSet() then begin
            repeat
                ObjRiskDetails.CalcFields("Risk (L * I)");
                Total += ObjRiskDetails."Risk (L * I)";
                CountNo += 1;
            until ObjRiskDetails.Next = 0;
        end;
        if CountNo <> 0 then begin
            Rec."Objective Average" := Total / CountNo;
            Rec.Modify();
        end;
    end;

    var
        Total: Decimal;
        CountNo: Integer;
        ObjRiskH: Record "Risk Header";
        ObjRiskDetails: Record "Risk Details";
}