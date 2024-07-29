page 54273 "FLT-Officers Going on Safari"
{
    PageType = Listpart;
    SourceTable = "FLT-Safari Accompanying Off.";
    Caption = 'FLT-Officers Going on Safari';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Emp. Pin No."; Rec."Emp. Pin No.")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

