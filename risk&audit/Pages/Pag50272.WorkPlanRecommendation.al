page 50282 "WorkPlan Recommendation "
{
    AutoSplitKey = true;
    Caption = 'WorkPlan Recommendation';
    PageType = ListPart;
    SourceTable = "WorkPlan Recommendation";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                    Caption = 'Recommendation';
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
