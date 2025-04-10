page 50206 "WorkPaper Conclusion"
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
                field(Conclusion; Rec.Description)
                {
                    Caption = 'Conclusion';

                    trigger OnValidate()
                    begin

                    end;
                }
                field(Favourable; Rec.Favourable)
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

