/// <summary>
/// Page ELECT-Polling Booths LKP (ID 60017).
/// </summary>
page 53613 "ELECT-Polling Booths LKP"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ELECT-Polling Booths";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Polling Center Code"; Rec."Polling Center Code")
                {
                    ApplicationArea = All;
                }
                field("Electral District"; Rec."Electral District")
                {
                    ApplicationArea = All;
                }
                field("Booth Code"; Rec."Booth Code")
                {
                    ApplicationArea = All;
                }
                field("Login Acc. Name"; Rec."Login Acc. Name")
                {
                    ApplicationArea = All;
                }
                field("Login Password"; Rec."Login Password")
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

