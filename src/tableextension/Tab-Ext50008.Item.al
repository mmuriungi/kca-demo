tableextension 50008 Item extends Item
{
    fields
    {
        field(56601; "Item G/L Budget Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(56602; "Is Controlled"; Boolean)
        {

        }
    }
}