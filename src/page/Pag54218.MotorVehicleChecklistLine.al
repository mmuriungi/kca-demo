page 54218 "Motor Vehicle Checklist Line"
{
    PageType = Listpart;
    SourceTable = "Motor Vehicle Checklists";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vehicle Reg No."; Rec."Vehicle Reg No.")
                {
                    ApplicationArea = All;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Contition; Rec.Contition)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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

