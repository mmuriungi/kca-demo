page 50280 "WorkPlan Objectives"
{
    AutoSplitKey = true;
    Caption = 'WorkPlan Objectives';
    PageType = ListPart;
    SourceTable = "WorkPlan Objectives";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                    Caption = 'Objective';
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
