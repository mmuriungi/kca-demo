page 50083 "Online Preferences"
{
    ApplicationArea = All;
    Caption = 'Online Preferences';
    PageType = List;
    SourceTable = "Online Class Preference";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Unit Code"; Rec."Unit Code")
                {
                    ToolTip = 'Specifies the value of the Unit Code field.', Comment = '%';
                }
                field("Year of Study"; Rec."Year of Study")
                {
                    ToolTip = 'Specifies the value of the Year of Study field.', Comment = '%';
                }
                field("Schedule Priority"; Rec."Schedule Priority")
                {
                    ToolTip = 'Specifies the value of the Schedule Priority field.', Comment = '%';
                }
            }
        }
    }
}
