page 52178287 "Audit Workplans"
{
    CardPageID = "Audit Workplan";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Audit WorkPlan"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Date; Date)
                {
                }
                field("Created By"; "Created By")
                {
                }
                field(Status; Status)
                {
                }
                field(Description; Description)
                {
                }
                field("No. Series"; "No. Series")
                {
                }
                field(Posted; Posted)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Audit Period"; "Audit Period")
                {
                }
                field(Period; Period)
                {
                }
                field(Type; Type)
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::"Audit WorkPlan";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit WorkPlan";
    end;
}

