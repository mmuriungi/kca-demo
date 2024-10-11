page 52072 "Time Slots"
{
    ApplicationArea = All;
    Caption = 'Time Slots';
    PageType = List;
    SourceTable = "Time Slot";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Day of Week"; Rec."Day of Week")
                {
                    ToolTip = 'Specifies the value of the Day of Week field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Duration"; Rec."Duration (Hours)")
                {
                    ToolTip = 'Specifies the value of the Duration field.', Comment = '%';
                }
            }
        }
    }
}
