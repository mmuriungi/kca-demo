page 51823 "ACA-Students Transfer"
{
    CardPageID = "ACA-Students Transfer Card";
    PageType = List;
    SourceTable = "ACA-Students Transfer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Current Programme"; Rec."Current Programme")
                {
                    ApplicationArea = All;
                }
                field("New Student No"; Rec."New Student No")
                {
                    ApplicationArea = All;
                }
                field("New Programme"; Rec."New Programme")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(UserId; Rec.UserId)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Transfer Report")
            {
                Image = Print;
                RunObject = Report "Transfer Report";
                ApplicationArea = All;
            }
        }
    }
}

