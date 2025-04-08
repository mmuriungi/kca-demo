page 52178294 "Audit Plans"
{
    Caption = 'Audit Programs';
    CardPageID = "Audit Program";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Audit Plan"), Archived = FILTER(false), Status = FILTER(<> Released));

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
                field("Department Name"; "Department Name")
                {
                }
                field("Audit Period"; "Audit Period")
                {
                }
                field(Archived; Archived)
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
        Type := Type::"Audit Plan";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Plan";
    end;
}

