page 50113 "Audit List"
{
    CardPageID = "Audit Card";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE (Type = FILTER (Audit));

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
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
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
        Type := Type::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Audit;
    end;
}

