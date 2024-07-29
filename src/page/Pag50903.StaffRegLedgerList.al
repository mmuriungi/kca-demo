page 50903 "Staff Reg.Ledger List"
{
    CardPageID = "Staff Ledger Card";
    DeleteAllowed = false;
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Staff Attendance Ledger";
    SourceTableView = WHERE("Checked Out" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Visit No."; Rec."Visit No.")
                {
                }
                field("Staff No."; Rec."Staff No.")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field(Email; Rec.Email)
                {
                }
                field(Category; Rec.Category)
                {
                }
                field(Company; Rec.Company)
                {
                }
                field("Office Station/Department"; Rec."Office Station/Department")
                {
                }
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Signed in by"; Rec."Signed in by")
                {
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                }
                field("Time In"; Rec."Time In")
                {
                }
                field("Time Out"; Rec."Time Out")
                {
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                }
                field("Checked Out"; Rec."Checked Out")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Comment By"; Rec."Comment By")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Check-in By Category")
            {
                Caption = 'Check-in By Category';
                Image = CreditMemo;
                Promoted = true;
                PromotedIsBig = true;
                //  RunObject = Report "Staff Check-in Per Category";
            }
        }
    }
}

