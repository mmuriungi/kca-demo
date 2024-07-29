page 52808 BufferPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = TestBuffer;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = All;

                }
                field(oldAcc; Rec.oldAcc)
                {
                    ApplicationArea = All;
                }
                field(newAcc; Rec.newAcc)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Merge Trans")
            {
                ApplicationArea = All;
                RunObject = report updates;
            }
        }
    }

    var
        myInt: Integer;



}