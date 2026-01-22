table 52178813 "Tender Professional Opinion"
{
    fields
    {
        field(1; "Tender No"; Code[50])
        {

        }
        field(2; "Opinion One"; Text[250])
        {

        }
        field(3; "Opinion Two"; Text[250])
        {

        }
        field(4; "Opinion Three"; Text[250])
        {

        }
        field(5; "Opinion Four"; Text[250])
        {

        }
        field(6; "Recommended Biddder"; Code[50])
        {
            TableRelation = "Tender Submission Header"."Bidder No" where("Bid Status" = filter("Fin Qualif"), "Tender No." = field("Tender No"));

            trigger OnValidate()
            var
                tsheader: Record "Tender Submission Header";
            begin
                tsheader.Reset();
                tsheader.SetRange("Bidder No", "Recommended Biddder");
                tsheader.SetRange("Tender No.", "Tender No");
                if tsheader.Find('-') then begin
                    "Bid No." := tsheader."No.";
                    "Quoted Amount" := tsheader."Financial Quoted Amount2";
                end;
            end;
        }
        field(7; "Bid No."; Code[50])
        {

        }
        field(8; "Quoted Amount"; Decimal)
        {

        }
        field(9; "Awarded"; Boolean)
        {

        }

    }
}