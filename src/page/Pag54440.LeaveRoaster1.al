page 54440 "Leave Roaster1"
{
    Caption = 'Leave Roaster list';
    CardPageID = "Leave Roaster";
    Editable = true;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Leave Roaster";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Roaster No."; Rec."Leave Roaster No.")
                {
                    Applicationarea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    Applicationarea = all;
                }
                field("Full Name"; Rec."Full Name")
                {
                    Applicationarea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Applicationarea = all;
                }
                field(Email; Rec.Email)
                {
                    Applicationarea = all;
                }
                field(Category; Rec.Category)
                {
                    Applicationarea = all;
                }

                field("Office Station/Department"; Rec."Office Station/Department")
                {
                    Applicationarea = all;
                }
                field("Department Name"; Rec."Department Name")
                {
                    Applicationarea = all;
                }

                field(Comment; Rec.Comment)
                {
                    Applicationarea = all;
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
                Applicationarea = all;
                Caption = 'Check-in By Category';
                Image = CreditMemo;
                Promoted = true;
                PromotedIsBig = true;
                // RunObject = Report "Staff Check-in Per Category";
            }
        }
    }
}
