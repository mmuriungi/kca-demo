page 50195 "Audit Review"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Review Scope No."; Rec."Review Scope No.")
                {
                }
                field("Review Scope"; Rec.Description)
                {

                    trigger OnValidate()
                    begin


                    end;
                }
                field("Review Procedure"; DNotesText2)
                {

                    trigger OnValidate()
                    begin

                    end;
                }
                field(Review; Rec.Review)
                {
                    Caption = 'Review ProcedureOld';
                    Enabled = false;
                    Visible = false;
                }
                field("Procedure Prepared By."; Rec."Procedure Prepared By.")
                {
                }
                field("WorkPlan Ref"; Rec."WorkPlan Ref")
                {
                    Caption = 'Working Paper  Ref';
                }
                field("Done By"; Rec."Done By")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field(Completed; Rec.Completed)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Select Scope")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.GetReviewScope(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin


    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
        DNotes2: BigText;
        Instr2: InStream;
        DNotesText2: Text;
        OutStr2: OutStream;
}

