Page 51998 "Complaints Committee"
{
    Caption = 'Complaint Committee';
    PageType = List;
    SourceTable = "Complaint Committee";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Staff No"; Rec."Staff No")
                {

                    ToolTip = 'Specifies the value of the Staff No field.';
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {

                    ToolTip = 'Specifies the value of the Staff Name field.';
                    ApplicationArea = All;
                }
                field("Cost Center"; Rec."Cost Center")
                {
                    ToolTip = 'Specifies the value of the Cost Center Code field.';
                    ApplicationArea = All;
                }
                field(Region; Rec."Region")
                {
                    ToolTip = 'Specifies the value of the Region code field.';
                    ApplicationArea = All;
                }

                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field("Cost Center Name"; Rec."Cost Center Name")
                {
                    ToolTip = 'Specifies the value of the Cost Center Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}