table 50063 "Tender Bidder Technical Reqs"
{
    fields
    {
        field(1; "Tender No."; code[30])
        {

        }
        field(2; "Code"; code[30])
        {

        }
        field(3; "Description"; Text[250])
        {

        }
        field(4; "Description 2"; Text[250])
        {

        }
        field(5; "Maximum Score"; Decimal)
        {

        }
        field(7; score; Decimal)
        {
            trigger OnValidate()
            begin
                if Score > "Maximum Score" then
                    Error('Score cannot be more than the maximum Score');
            end;
        }
        field(8; "Remarks"; Text[200])
        {

        }
        field(9; "Bid No."; code[50])
        {

        }
        field(10; "Bidder No."; code[50])
        {

        }
        field(11; "Employee no"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(12; "User Name"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
    }

    keys
    {
        key(Key1; "Tender No.", Code, "Bid No.", "Bidder No.", "Employee no", "User Name")
        {

        }
    }
}