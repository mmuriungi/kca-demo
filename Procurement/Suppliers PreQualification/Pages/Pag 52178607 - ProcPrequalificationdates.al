page 52178607 "Proc-Prequalification dates"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Proc-Prequalification dates";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Preq. Year"; Rec."Preq. Year")
                {
                    ApplicationArea = All;
                }
                field("Reference Date"; Rec."Reference Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

