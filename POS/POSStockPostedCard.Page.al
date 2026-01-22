#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 99420 "POS Stock Posted Card"
{
    PageType = Card;
    SourceTable = "POS Stock Header";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                part(Control1000000012; "POS Stock Lines")
                {
                    Editable = false;
                    SubPageLink = "Document No." = field("No.");
                }
            }
        }
    }

}
