page 52178290 "Audit Record Requisition Card"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(Group)
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
                field("No. Series"; "No. Series")
                {
                }
                field(Posted; Posted)
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Audit Period"; "Audit Period")
                {
                }
                field(Period; Period)
                {
                }
                field(Type; Type)
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
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
        Type := Type::"Audit Record Requisition";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::"Audit Record Requisition";
    end;
}

