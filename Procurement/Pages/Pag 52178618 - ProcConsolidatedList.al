page 52178618 "Proc Consolidated List"
{
    CardPageId = "Proc Consolidation Card";
    Caption = 'Proc Consolidated List';
    PageType = List;
    SourceTable = "Proc Consolidated Header";
    Editable = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
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
        }
    }
    actions
    {
        area(Processing)
        {

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
