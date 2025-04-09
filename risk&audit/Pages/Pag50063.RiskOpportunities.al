page 50733 "Risk Opportunities"
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
                field(Opportunities; Rec.Description)
                {
                    Caption = 'Opportunities';

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

