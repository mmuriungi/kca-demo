page 50405 "HRM-Committees (C)"
{
    PageType = Worksheet;
    SourceTable = "HRM-Committees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';
                action(Members)
                {
                    Caption = 'Members';
                    RunObject = Page "HRM-Committee Board Of Direc.";
                    RunPageLink = Committee = FIELD(Code);
                }
            }
        }
    }
}

