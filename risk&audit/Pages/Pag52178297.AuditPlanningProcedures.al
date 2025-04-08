page 50194 "Audit Planning Procedures"
{
    AutoSplitKey = true;
    Caption = 'Procedures';
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Procedure"; DNotesText)
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
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin

        Rec.CALCFIELDS(Description);
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

