page 50118 "Audit Notifications"
{
    CardPageID = "Audit Notification";
    PageType = List;
    SourceTable = "Communication Header";
    SourceTableView = WHERE(Type = FILTER("Audit Notification"), Sent = FILTER(false), Status = FILTER(<> Sent));

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Communication Type"; Rec."Communication Type")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Body"; Rec."E-Mail Body")
                {
                    ApplicationArea = All;
                }
                field("SMS Text"; Rec."SMS Text")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Subject"; Rec."E-Mail Subject")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Sender Email"; Rec."Sender Email")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Notification";
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Notification";
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;

    trigger OnOpenPage()
    begin
        Rec."Communication Type" := Rec."Communication Type"::"E-Mail";
    end;
}

