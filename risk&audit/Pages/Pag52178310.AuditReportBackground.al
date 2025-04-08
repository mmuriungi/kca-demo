page 52178310 "Audit Report Background"
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
                field(Introduction; DNotesText)
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

