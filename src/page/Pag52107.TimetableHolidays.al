page 52107 "Timetable Holidays"
{
    ApplicationArea = All;
    Caption = 'Timetable Holidays';
    PageType = List;
    SourceTable = "Timetable Holidays";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Day of The week"; Rec."Day of The week")
                {
                    ToolTip = 'Specifies the value of the Day of The week field.', Comment = '%';
                }
                field("Holiday Name"; Rec."Holiday Name")
                {
                    ToolTip = 'Specifies the value of the Holiday Name field.', Comment = '%';
                }
            }
        }
    }
}
