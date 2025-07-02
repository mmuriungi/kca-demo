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
                field("Test Description 2"; rec."Description 2 Blob")
                {
                    Caption = 'Test Description';
                    //
                    trigger OnValidate()
                    begin

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

    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        DNotesD2: BigText;
        InstrD2: InStream;
        DNotesTextD2: Text;
        OutStrD2: OutStream;
}

