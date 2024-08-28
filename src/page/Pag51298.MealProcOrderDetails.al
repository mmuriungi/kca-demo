page 51298 "Meal-Proc. Order Details"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Meal-Proc. BOM Prod. Source";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parent Item"; Rec."Parent Item")
                {
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Production  Area"; Rec."Production  Area")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Item Quantity"; Rec."Item Quantity")
                {
                }
                field("Control Unit of Measure"; Rec."Control Unit of Measure")
                {
                }
                field("BOM Design Quantity"; Rec."BOM Design Quantity")
                {
                    Enabled = false;
                }
                field("Consumption Quantiry"; Rec."Consumption Quantiry")
                {
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        editableStatus := TRUE;
        Rec.CALCFIELDS(Approve);
        Rec.CALCFIELDS(Reject);
        IF ((Rec.Approve) OR (Rec.Reject)) THEN editableStatus := FALSE;
    end;

    var
        editableStatus: Boolean;
}

