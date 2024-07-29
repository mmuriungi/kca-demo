page 54231 "Confirmation of Work"
{
    PageType = List;
    SourceTable = "Confirmation of Work";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Gate Pass No."; Rec."Gate Pass No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Confirmation"; Rec."Date Of Confirmation")
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Name of Asset"; Rec."Name of Asset")
                {
                    ApplicationArea = All;
                }
                field("Type of Work Done"; Rec."Type of Work Done")
                {
                    ApplicationArea = All;
                }
                field("Service Provider"; Rec."Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Service Provider Comments"; Rec."Service Provider Comments")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Admin Comment"; Rec."Admin Comment")
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

