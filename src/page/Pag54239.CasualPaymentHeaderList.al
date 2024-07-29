page 54239 "Casual Payment Header List."
{
    CardPageID = "Casual Header Card.";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Casual Payment Header.";

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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ApplicationArea = All;
                }
                field("P.A.Y.E Acc"; Rec."P.A.Y.E Acc")
                {
                    ApplicationArea = All;
                }
                field("NSSF Account"; Rec."NSSF Account")
                {
                    ApplicationArea = All;
                }
                field(NHIFAccount; Rec.NHIFAccount)
                {
                    ApplicationArea = All;
                }
                field("Total PAYE"; Rec."Total PAYE")
                {
                    ApplicationArea = All;
                }
                field("Total NHIF"; Rec."Total NHIF")
                {
                    ApplicationArea = All;
                }
                field("Total NSSF"; Rec."Total NSSF")
                {
                    ApplicationArea = All;
                }
                field("Net Payable"; Rec."Net Payable")
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

