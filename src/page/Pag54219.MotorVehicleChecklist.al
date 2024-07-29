page 54219 "Motor Vehicle Checklist"
{
    CardPageID = "Motor Vehicle CheckList Card";
    PageType = List;
    SourceTable = "Motor Vehicle Checklists";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Reg No."; Rec."Vehicle Reg No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Type Of Vehicle"; Rec."Type Of Vehicle")
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
                field("Mileage Reading"; Rec."Mileage Reading")
                {
                    ApplicationArea = All;
                }
                field("Name Of Receiving Driver"; Rec."Name Of Receiving Driver")
                {
                    ApplicationArea = All;
                }
                field("Name Of Handing Over Driver"; Rec."Name Of Handing Over Driver")
                {
                    ApplicationArea = All;
                }
                field("Admin officer"; Rec."Admin officer")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Name"; Rec."Vehicle Name")
                {
                    ApplicationArea = All;
                }
                field(Departments; Rec.Departments)
                {
                    ApplicationArea = All;
                }
                field(Directorate; Rec.Directorate)
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
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

