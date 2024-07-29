page 54915 "HMS-Radiology Req. Hist. Lines"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS-Radiology Form Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Radiology Type Code"; Rec."Radiology Type Code")
                {
                    ApplicationArea = All;
                }
                field("Radiology Type Name"; Rec."Radiology Type Name")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Performed Date"; Rec."Performed Date")
                {
                    ApplicationArea = All;
                }
                field("Performed Time"; Rec."Performed Time")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Completed; Rec.Completed)
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

