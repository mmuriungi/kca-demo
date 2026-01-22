page 50419 "HRM-Position Supervised"
{
    PageType = ListPart;
    SourceTable = "HRM-Position Supervised";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Position Supervised"; Rec."Position Supervised")
                {
                    Caption = 'Job ID';
                }
                field(Description; Rec.Description)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

