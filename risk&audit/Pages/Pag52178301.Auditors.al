page 50198 "Auditor(s)"
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
                field(Auditor; Rec.Auditor)
                {

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Auditor Name"; Rec."Auditor Name")
                {
                    Editable = false;
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

