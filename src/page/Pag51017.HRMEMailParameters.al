page 51017 "HRM- EMail Parameters"
{
    PageType = Card;
    SourceTable = "HRM-EMail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With"; Rec."Associate With")
                {
                }
                field("Sender Name"; Rec."Sender Name")
                {
                }
                field("Sender Address"; Rec."Sender Address")
                {
                }
                field(Recipients; Rec.Recipients)
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field(Body; Rec.Body)
                {
                }
                field("Body 2"; Rec."Body 2")
                {
                }
                field("Body 3"; Rec."Body 3")
                {
                }
                field(HTMLFormatted; Rec.HTMLFormatted)
                {
                }
            }
        }
    }

    actions
    {
    }
}

