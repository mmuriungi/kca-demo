query 50005 FAQ
{
    Caption = 'FAQ';
    QueryType = Normal;

    elements
    {
        dataitem(FAQ; FAQ)
        {
            column(EntryNo; "Entry No")
            {
            }
            column(Question; Question)
            {
            }
            column(Answer; Answer)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
