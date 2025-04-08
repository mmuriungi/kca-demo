page 52178314 "Risk Surveys"
{
    CardPageID = "Risk Survey";
    PageType = List;
    SourceTable = "Audit Header";
    SourceTableView = WHERE(Type = FILTER("Risk Survey"), "Notification Sent" = FILTER(false));

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
                field("Employee No."; "Employee No.")
                {
                    Enabled = false;
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
        Type := Type::"Risk Survey";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Risk Survey";
    end;
}

