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
                field("Review Scope"; DNotesText)
                {

                    trigger OnValidate()
                    begin

                        Rec.CALCFIELDS(Description);
                        Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);

                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Rec.Description);
                            CLEAR(DNotes);
                            DNotes.ADDTEXT(DNotesText);
                            Description.CREATEOUTSTREAM(OutStr);
                            DNotes.WRITE(OutStr);
                        END;
                    end;
                }
                field("Review Procedure"; DNotesText2)
                {

                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Review Procedure Blob");
                        "Review Procedure Blob".CREATEINSTREAM(Instr2);
                        DNotes2.READ(Instr2);

                        IF DNotesText2 <> FORMAT(DNotes2) THEN BEGIN
                            CLEAR(Rec."Review Procedure Blob");
                            CLEAR(DNotes2);
                            DNotes2.ADDTEXT(DNotesText2);
                            "Review Procedure Blob".CREATEOUTSTREAM(OutStr2);
                            DNotes2.WRITE(OutStr2);
                        END;
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

        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);


        Rec.CALCFIELDS("Review Procedure Blob");
        "Review Procedure Blob".CREATEINSTREAM(Instr2);
        DNotes2.READ(Instr2);
        DNotesText2 := FORMAT(DNotes2);
    end;

    trigger OnAfterGetRecord()
    begin

        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);

        Rec.CALCFIELDS("Review Procedure Blob");
        "Review Procedure Blob".CREATEINSTREAM(Instr2);
        DNotes2.READ(Instr2);
        DNotesText2 := FORMAT(DNotes2);
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

