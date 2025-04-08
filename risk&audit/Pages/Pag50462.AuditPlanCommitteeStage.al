page 50462 "Audit Plan Committee Stage"
{
    ApplicationArea = All;
    Caption = 'Audit Plan Committee Stage';
    CardPageID = "Audit Plan";
    PageType = List;
    SourceTable = "Audit Header";
    UsageCategory = Lists;
    SourceTableView = where("Audit Stage" = filter(Committee), Type = FILTER("Audit Program"));

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
                field(Description; Description)
                {
                }
                field("Document Status"; "Document Status")
                {
                    Caption = 'Audit Status';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Type := Type::"Audit Program";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Program";
    end;
}