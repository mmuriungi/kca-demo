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
                field("Procedure"; Rec.Description)
                {

                    trigger OnValidate()
                    begin

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
    end;

    trigger OnAfterGetRecord()
    begin
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

