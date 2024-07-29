/// <summary>
/// Page Annual Workplan Header (ID 50003).
/// </summary>
page 51321 "Annual Workplan Header"
{
    Caption = 'Workplan Header';
    PageType = Card;
    SourceTable = "Annual Workplan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Financial Period"; Rec."Financial Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Financial Period field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
            part("Annual Workplan Listpart"; "Annual Workplan Listpart")
            {
                SubPageLink = "Financial Period" = field("Financial Period");
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Targets")
            {
                ApplicationArea = all;
                image = Process;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    rec.Reset();
                    rec.SetRange("Financial Period", rec."Financial Period");
                    rec.SendKras();

                end;
            }
        }
    }
    var
        wpheader: record "Annual Workplan Header";
}
