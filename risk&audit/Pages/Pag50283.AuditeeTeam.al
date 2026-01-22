page 50283 "Auditee Team"
{
    AutoSplitKey = true;
    Caption = 'Auditee Team';
    PageType = ListPart;
    SourceTable = "Auditee Team";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member ID"; Rec."Member ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the team member.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the team member.';
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the position of the team member.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department of the team member.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the email address of the team member.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the phone number of the team member.';
                }
            }
        }
    }
}
