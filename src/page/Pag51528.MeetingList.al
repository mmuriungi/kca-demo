page 51528 "Meeting List"
{
    Caption = 'Meeting List';
    CardPageId = "Meeting Card";
    PageType = List;
    SourceTable = MeetingsInfo;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Meeting Code"; Rec."Meeting Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Code field.';
                }
                field("Meeting End Time"; Rec."Meeting End Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting End Time field.';
                }
                field("Meeting Start Time"; Rec."Meeting Start Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Start Time field.';
                }
                field("Meeting Title"; Rec."Meeting Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Title field.';
                }
                field("Meeting Type"; Rec."Meeting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Type field.';
                }
                field("Meeting Venue"; Rec."Meeting Venue")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Meeting Venue field.';
                }
            }
        }
    }
}
