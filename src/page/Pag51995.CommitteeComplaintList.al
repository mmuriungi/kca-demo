page 51995 "Committee Complaint List"
{
    Caption = 'Complaint committee List';
    PageType = List;
    CardPageId = "Complaint Card";
    SourceTable = "CA-Complaints";
    SourceTableView = WHERE(Status = FILTER('InCommittee'));

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
                field("Complain Type"; Rec."Complain Type")
                {
                    ToolTip = 'Specifies the value of the Complain Type field.';
                    ApplicationArea = All;
                }
                field("Cost Center Name"; Rec."Department Name")
                {
                    ToolTip = 'Specifies the value of the Department Name field.';
                    ApplicationArea = All;
                }
                field(Region; Rec."Region Code")
                {
                    ToolTip = 'Specifies the value of the Region field.';
                    ApplicationArea = All;
                }
                field("Region Name"; Rec."Region Name")
                {
                    ToolTip = 'Specifies the value of the Region Name field.';
                    ApplicationArea = All;
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}

