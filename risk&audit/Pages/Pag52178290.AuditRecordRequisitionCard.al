page 50185 "Audit Record Requisition Card"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(Group)
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
                field("No. Series"; Rec."No. Series")
                {
                }
                field(Posted; Rec.Posted)
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Audit Period"; Rec."Audit Period")
                {
                }
                field(Period; Rec.Period)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
            }
            part(Control16; "Audit Record Requisition Line")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::"Audit Record Requisition";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::"Audit Record Requisition";
    end;
}

