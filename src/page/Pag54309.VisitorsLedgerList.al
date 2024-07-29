page 54309 "Visitors Ledger List"
{
    CardPageID = "Visitors Ledger Card";
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Visitors Ledger";
    SourceTableView = WHERE("Checked Out" = FILTER(true));
    Caption = 'Visitors Ledger List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Visit No."; Rec."Visit No.")
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Office Station/Department"; Rec."Office Station/Department")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Signed in by"; Rec."Signed in by")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Signed Out By"; Rec."Signed Out By")
                {
                    ApplicationArea = All;
                }
                field("Checked Out"; Rec."Checked Out")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Comment By"; Rec."Comment By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Visitor Register")
            {
                Caption = 'Visitor Register';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Visitors Register";
                ApplicationArea = All;
            }
            action("Visitors By Department")
            {
                Caption = 'Visitors By Department';
                Image = "Report";
                Promoted = true;
                PromotedOnly = true;
                RunObject = Report "Visitors Per Department";
                ApplicationArea = All;
            }
            action("Visitors Register Detailed")
            {
                Caption = 'Visitors Register Detailed';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Visitors Register Detailed";
                ApplicationArea = All;
            }
        }
    }
}

