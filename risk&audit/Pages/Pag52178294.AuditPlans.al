page 50190 "Audit Plans"
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
                field("No."; Rec."No.")
                {
                }
                field(Date; Rec.Date)
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Audit Period"; Rec."Audit Period")
                {
                }
                field(Archived; Rec.Archived)
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
        Rec.Type := Rec.Type::"Audit Plan";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Plan";
    end;
}

