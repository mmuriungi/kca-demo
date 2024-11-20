page 52083 "Medical Facilities"
{
    ApplicationArea = All;
    Caption = 'Medical Facilities';
    PageType = List;
    SourceTable = "HRM-Medical Facility";
    
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
                field("Facility Type"; Rec."Facility Type")
                {
                    ToolTip = 'Specifies the value of the Facility Type field.', Comment = '%';
                }
                field("Facility Name"; Rec."Facility Name")
                {
                    ToolTip = 'Specifies the value of the Facility Name field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field(Contacts; Rec.Contacts)
                {
                    ToolTip = 'Specifies the value of the Contacts field.', Comment = '%';
                }
            }
        }
    }
}
