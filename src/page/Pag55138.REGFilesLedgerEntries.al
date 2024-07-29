page 55138 "REG- Files Ledger Entries"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "REG-Files Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("File No./Folio No."; Rec."File No./Folio No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Source Department"; Rec."Source Department")
                {
                    ApplicationArea = All;
                }
                field("Destination Department"; Rec."Destination Department")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Officer Code"; Rec."Dispatch Officer Code")
                {
                    ApplicationArea = All;
                }
                field("Receiving Officer Code"; Rec."Receiving Officer Code")
                {
                    ApplicationArea = All;
                }
                field("Expected Return Date"; Rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

