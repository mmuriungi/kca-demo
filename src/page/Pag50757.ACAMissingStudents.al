page 50757 "ACA-Missing Students"
{
    Editable = false;
    PageType = List;
    SourceTable = "ACA-Missing Students";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
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

