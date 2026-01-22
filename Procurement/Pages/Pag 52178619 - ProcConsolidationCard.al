page 52178619 "Proc Consolidation Card"
{
    Caption = 'Proc Consolidation Card';
    PageType = Card;
    SourceTable = "Proc Consolidated Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(Fy; Rec.Fy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fy field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
            part("ProcConsolidationLines"; "Proc Consolidation Lines")
            {
                ApplicationArea = all;
                SubPageLink = Fy = field(fy);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Consolidate")
            {
                ApplicationArea = all;
                Image = CopyDimensions;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    rec.ConsolidatePlan();
                end;
            }
            action("Plan")
            {
                ApplicationArea = all;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    rec.Reset();
                    rec.SetRange(Fy, rec.Fy);
                    if rec.Find('-') then
                        report.run(report::"Consolidated Procurement Plan", true, true, rec)
                end;
            }




        }
    }
}
