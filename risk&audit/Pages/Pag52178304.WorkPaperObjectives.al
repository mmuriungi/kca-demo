page 50201 "WorkPaper Objectives"
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
                field(Objectives; Rec.Description)
                {
                    Caption = 'Objectives';

                    trigger OnValidate()
                    begin
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

