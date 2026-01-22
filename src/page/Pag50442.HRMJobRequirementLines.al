page 50442 "HRM-Job Requirement Lines"
{
    CardPageID = "HRM-Job Requirements";
    PageType = Card;
    SourceTable = "HRM-Job Requirements";
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = true;
                field("Qualification Category"; Rec."Qualification Category")
                {
                }
                field("Qualification Type"; Rec."Qualification Type")
                {

                }
                field("Qualification Code"; Rec."Qualification Code")
                {

                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    Editable = false;

                }
                field("Grade Attained"; Rec."Grade Attained")
                {
                }
                field(Priority; Rec.Priority)
                {
                }
                field(Mandatory; Rec.Mandatory)
                {
                }
            }
        }
    }

    actions
    {
    }
}

