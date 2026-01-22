table 52178806 "Tender Bidder Prelim Reqs"
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

        field(5; "Requirements Met?"; Boolean)
        {

        }
        field(6; Remarks; Text[200])
        {

        }
        field(7; "Bid No."; code[50])
        {

        }
        field(8; "Bidder No."; code[50])
        {

        }
        field(9; "Employee no"; Code[30])
        {
            TableRelation = "HRM-Employee C"."No.";
        }
        field(10; "User Name"; Code[50])
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