page 51094 "ACA-Grading Sys. Header"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "ACA-Exam Category";

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
            action("Transcript Comments")
            {
                Caption = 'Transcript Comments';
                Image = Category;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "ACA-Cat. Transc. Comments";
                RunPageLink = "Exam Category" = FIELD(Code);
                ApplicationArea = All;
            }
            action("Exam Setup")
            {
                Caption = 'Exam Setup';
                Image = ChangePaymentTolerance;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "ACA-Exam Setup";
                RunPageLink = Category = FIELD(Code);
                ApplicationArea = All;
            }
            action("Grading System")
            {
                Caption = 'Grading System';
                Image = Continue;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "ACA-Grading System";
                RunPageLink = Category = FIELD(Code);
                ApplicationArea = All;
            }
            action("Provisional Transcript Comments")
            {
                Caption = 'Provisional Transcript Comments';
                Image = CreateInventoryPickup;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "ACA Prov. Transcript Comments";
                RunPageLink = "Exam Category" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
}

