page 51238 "CAT-Menu Sales SetUp"
{
    PageType = Card;
    SourceTable = "CAT-Catering SetUp";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Receipt No"; Rec."Receipt No")
                {
                }
                field("Sales Template"; Rec."Sales Template")
                {
                }
                field("Sales Batch"; Rec."Sales Batch")
                {
                }
                field("Menu No. Series"; Rec."Menu No. Series")
                {
                }
                field("Catering Income Account"; Rec."Catering Income Account")
                {
                }
                field("Catering Control Account"; Rec."Catering Control Account")
                {
                }
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        EXIT(FALSE);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        EXIT(FALSE);
    end;
}

