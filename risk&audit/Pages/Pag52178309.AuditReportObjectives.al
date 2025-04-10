page 50209 "Audit Report Objectives"
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

