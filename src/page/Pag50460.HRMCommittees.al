page 50460 "HRM-Committees"
{
    PageType = List;
    SourceTable = "HRM-Committees (B)";

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
                field(Roles; Rec.Roles)
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
                    Image = Loaners;
                    Promoted = true;
                    RunObject = Page "HRM-Commitee Members";
                    RunPageLink = Committee = FIELD(Code);
                }
            }
        }
    }
}

