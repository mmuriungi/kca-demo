table 52178808 "Tender Bidder Demo Reqs"
{
    fields
    {
        field(1; "Tender No."; Code[30])
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
        field(6; "Score"; Decimal)
        {
            trigger OnValidate()
            begin
                if Score > "Maximum Score" then
                    Error('Score cannot be more than the maximum Score');
            end;
        }
        field(7; "Remarks"; Text[200])
        {

        }
        field(8; "Bid No."; code[50])
        {

        }
        field(9; "Bidder No."; code[50])
        {

        }
        field(10; "Employee no"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(11; "User Name"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
    }
    keys
    {
        key(key1; "Tender No.", Code, "Bid No.", "Bidder No.", "Employee no", "User Name")
        {

        }
    }
}