page 52178282 "Sent Audit Notifications"
{
    CardPageID = "Audit Notification";
    PageType = List;
    SourceTable = "Communication Header";
    SourceTableView = WHERE(Type = FILTER("Audit Notification"), Sent = FILTER(true));

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
                field("No. Series"; "No. Series")
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
                field("Sender Email"; "Sender Email")
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
        Type := Type::"Audit Notification";
        "Communication Type" := "Communication Type"::"E-Mail";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Notification";
        "Communication Type" := "Communication Type"::"E-Mail";
    end;

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(FALSE);
    end;
}

