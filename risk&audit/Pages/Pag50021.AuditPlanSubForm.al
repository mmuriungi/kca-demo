page 50021 "Audit Plan SubForm"
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
                field("Item & Key Annual output"; "Item & Key Annual output")
                {
                    ApplicationArea = All;
                }
                field("Audit Objectives"; "Audit Objectives")
                {

                }
                field("Core Activities"; "Core Activities")
                {
                }
                field("Means of verification"; "Means of verification")
                {

                }
                field("Work Dates"; "Work Dates")
                {
                }
                field("Expected Report"; "Expected Report")
                {
                }
                field("Reporting Date"; "Reporting Date")
                { }
                field(Responsibility; Responsibility)
                { }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin


        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    trigger OnAfterGetRecord()
    begin

        Rec.CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
}

