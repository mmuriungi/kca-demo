page 50256 "Audit Plan Committee Stage"
{
    ApplicationArea = All;
    Caption = 'Audit Plan Committee Stage';
    CardPageID = "Audit Plan";
    PageType = List;
    SourceTable = "Audit Header";
    UsageCategory = Lists;
    SourceTableView = where("Audit Stage" = filter(Council), Type = FILTER("Audit Program"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Document Status"; Rec."Document Status")
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
        Rec.Type := Rec.Type::"Audit Program";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Program";
    end;
}