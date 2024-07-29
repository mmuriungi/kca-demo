page 54401 "Meeting Atendees"
{
    Caption = 'Meeting Atendees';
    PageType = ListPart;
    SourceTable = MeetingAtendees;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Meeting Code"; Rec."Meeting Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Meeting Code field.';
                }
                field("Pf No"; Rec."Pf No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Pf No field.';
                }
                field(FullNames; Rec.FullNames)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FullNames field.';
                }
                field(email; Rec.email)
                {
                    ApplicationArea = All;
                }
                field("Attendance Status"; Rec."Attendance Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attendance Status field.';
                }
                field("Apology Reason"; Rec."Apology Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Apology Reason field.';
                }
            }
        }
    }
}
