page 50281 "WorkPlan Favorable"
{
    AutoSplitKey = true;
    Caption = 'WorkPlan Favorable';
    PageType = ListPart;
    SourceTable = "WorkPlan Favorable";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Favorable Condition"; Rec."Favorable Condition")
                {
                    ApplicationArea = All;
                    Caption = 'Favorable Condition';
                    MultiLine = true;
                }
                field("Done By"; Rec."Done By")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Date := WorkDate();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.Date = 0D then
            Rec.Date := WorkDate();
    end;
}
