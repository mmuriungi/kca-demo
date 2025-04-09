page 50218 "Risk Mitigation Proposal"
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
                field("Mitigation / Proposal"; Rec.Description)
                {
                    Caption = 'Mitigation / Proposal';

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

