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
                field("Review Scope No."; "Review Scope No.")
                {
                }
                field("Review Scope"; DNotesText)
                {

                    trigger OnValidate()
                    begin

                        CALCFIELDS(Description);
                        Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);

                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Description);
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
                        CALCFIELDS("Review Procedure Blob");
                        "Review Procedure Blob".CREATEINSTREAM(Instr2);
                        DNotes2.READ(Instr2);

                        IF DNotesText2 <> FORMAT(DNotes2) THEN BEGIN
                            CLEAR("Review Procedure Blob");
                            CLEAR(DNotes2);
                            DNotes2.ADDTEXT(DNotesText2);
                            "Review Procedure Blob".CREATEOUTSTREAM(OutStr2);
                            DNotes2.WRITE(OutStr2);
                        END;
                    end;
                }
                field(Review; Review)
                {
                    Caption = 'Review ProcedureOld';
                    Enabled = false;
                    Visible = false;
                }
                field("Procedure Prepared By."; "Procedure Prepared By.")
                {
                }
                field("WorkPlan Ref"; "WorkPlan Ref")
                {
                    Caption = 'Working Paper  Ref';
                }
                field("Done By"; "Done By")
                {
                }
                field(Date; Date)
                {
                }
                field(Completed; Completed)
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
                    GetReviewScope(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);


        CALCFIELDS("Review Procedure Blob");
        "Review Procedure Blob".CREATEINSTREAM(Instr2);
        DNotes2.READ(Instr2);
        DNotesText2 := FORMAT(DNotes2);
    end;

    trigger OnAfterGetRecord()
    begin

        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);

        CALCFIELDS("Review Procedure Blob");
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

