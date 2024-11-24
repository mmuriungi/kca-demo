page 52178579 "Consolidated Plan Card"
{
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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }


            }
            part(part; "Proc Consolidation Lines")
            {
                SubPageLink = Fy = FIELD(Fy);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(Print)
            {
                Caption = 'Print Plan';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    plan: Record "PROC-Procurement Plan Header";
                begin
                    plan.Reset();
                    plan.SetRange("Budget Name", Rec.Fy);
                    Report.Run(Report::"Procurement Plan", true, false, plan);
                end;


            }
        }
    }
}