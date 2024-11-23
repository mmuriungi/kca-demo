page 52178617 "Proc Plan Periods"
{
    // DeleteAllowed = false;
    Caption = 'Proc Plan Periods';
    PageType = List;
    SourceTable = "Proc Plan Periods";

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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Current; Rec.Current)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Current field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Close Period")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = ClosePeriod;
                trigger OnAction()
                begin
                    rec.ClosedPeriod();
                end;

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.CheckCurrentPeriod;
        rec.Current := true;
    end;
}
