page 50359 "Casual Attendance (Current)"
{
    CardPageID = "Staff Ledger Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Casuals Attendance Ledger";
    SourceTableView = WHERE("Checked Out" = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Caption = 'Attendance Date';
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
                field("Department Name"; Rec."Department Name")
                {
                }
                field("Signed in by"; Rec."Signed in by")
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
    }
}

