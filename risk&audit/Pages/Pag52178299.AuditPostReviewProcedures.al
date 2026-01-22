page 50196 "Audit Post-Review Procedures"
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
                field("Post - Review"; Rec.Description)
                {

                    trigger OnValidate()
                    begin

                    end;
                }
                field(Date; Rec.Date)
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

