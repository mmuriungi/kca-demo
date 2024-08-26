page 50484 "HRM-Asset Return Form"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Misc. Article Information";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Misc. Article Code"; Rec."Misc. Article Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("From Date"; Rec."From Date")
                {
                }
                field("To Date"; Rec."To Date")
                {
                }
                field("In Use"; Rec."In Use")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        EI: Record "PRL-Employee Motor Vehicles";

    procedure refresh()
    begin
        CurrPage.Update(false);
    end;
}

