page 52178278 "Audit Communications"
{
    CardPageID = "Audit Communication";
    PageType = List;
    SourceTable = "Communication Header";
    SourceTableView = WHERE(Type = FILTER(Audit));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Created By"; "Created By")
                {
                }
                field("Last Modified By"; "Last Modified By")
                {
                }
                field(Status; Status)
                {
                }
                field("Communication Type"; "Communication Type")
                {
                }
                field("E-Mail Body"; "E-Mail Body")
                {
                }
                field("SMS Text"; "SMS Text")
                {
                }
                field("E-Mail Subject"; "E-Mail Subject")
                {
                }
                field(Attachment; Attachment)
                {
                }
                field(Type; Type)
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

