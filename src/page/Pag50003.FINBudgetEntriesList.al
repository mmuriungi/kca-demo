page 50003 "FIN-Budget Entries List"
{
    Editable = false;
    PageType = List;
    SourceTable = "FIN-Budget Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field("Budget Name"; Rec."Budget Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Description"; Rec."Document Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No"; Rec."Document No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Paye; Rec.Paye)
                {
                    ApplicationArea = ALL;
                    Editable = FALSE;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                }
                field("Commitment Status"; Rec."Commitment Status")
                {
                    Editable = false;
                }
            }
        }
    }
}