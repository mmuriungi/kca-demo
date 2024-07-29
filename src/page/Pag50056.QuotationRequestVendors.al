page 50056 "Quotation Request Vendors"
{
    PageType = Card;
    SourceTable = "PROC-Quotation Request Vendors";

    layout
    {
        area(content)
        {
            repeater(______________)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Print/Preview")
            {
                Caption = '&Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    vends.RESET;
                    vends.SETRANGE("Document No.", Rec."Document No.");
                    vends.SetRange("Vendor No.", Rec."Vendor No.");
                    IF vends.FIND('-') THEN BEGIN
                        REPORT.RUN(50012, TRUE, FALSE, vends);
                    END;
                end;
            }
        }
    }

    var
        vends: Record "PROC-Quotation Request Vendors";
}