page 52178309 "Audit Report Objectives"
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
                field(Objectives; DNotesText)
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
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin

        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

