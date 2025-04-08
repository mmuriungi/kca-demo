page 50202 "Workpaper Result"
{
    PageType = CardPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            group(Control4)
            {
                ShowCaption = false;
                field("Test Description 2"; DNotesTextD2)
                {
                    Caption = 'Test Description';
                    //
                    trigger OnValidate()
                    begin
                        Rec.CALCFIELDS("Description 2 Blob");
                        "Description 2 Blob".CREATEINSTREAM(InstrD2);
                        DNotesD2.READ(InstrD2);

                        IF DNotesTextD2 <> FORMAT(DNotesD2) THEN BEGIN
                            CLEAR(Rec."Description 2 Blob");
                            CLEAR(DNotesD2);
                            DNotesD2.ADDTEXT(DNotesTextD2);
                            "Description 2 Blob".CREATEOUTSTREAM(OutStrD2);
                            DNotesD2.WRITE(OutStrD2);
                        END;
                    end;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Description 2';
                    MultiLine = true;
                    Visible = false;
                }
                field(Image; Rec.Image)
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
        Rec.CALCFIELDS("Description 2 Blob");
        "Description 2 Blob".CREATEINSTREAM(InstrD2);
        DNotesD2.READ(InstrD2);
        DNotesTextD2 := FORMAT(DNotesD2);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Description 2 Blob");
        "Description 2 Blob".CREATEINSTREAM(InstrD2);
        DNotesD2.READ(InstrD2);
        DNotesTextD2 := FORMAT(DNotesD2);
    end;

    var
        DNotesD2: BigText;
        InstrD2: InStream;
        DNotesTextD2: Text;
        OutStrD2: OutStream;
}

