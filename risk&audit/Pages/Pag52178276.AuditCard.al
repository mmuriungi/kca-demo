page 50114 "Audit Card"
{
    PageType = Card;
    SourceTable = "Audit Header";

    layout
    {
        area(content)
        {
            group(General)
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
                field(Period; Period)
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
            }
            part(Control12; "Audit Subform")
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
        Type := Type::Audit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Audit;
    end;
}

