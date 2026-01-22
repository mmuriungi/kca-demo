page 51936 "Audit Risk Caues Lines"
{
    PageType = List;
    SourceTable = "Audit-Risk Causes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    HideValue = true;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Risk Code"; Rec."Risk Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

