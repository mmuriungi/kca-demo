page 50199 "Proc-Preliminary Qualif.Quote"
{
    PageType = ListPart;
    SourceTable = "Proc-Preliminary Qualif.Quote";
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("Quote No."; Rec."Quote No.")
                {
                    DrillDownPageId = "Proc-Purchase Quote.Card";
                    Caption = 'Quote/Bid No.';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quote No. field.';
                    trigger OnDrillDown()
                    var
                        Pheader: Record "Purchase Header";
                    begin
                        Pheader.Reset();
                        Pheader.SetRange("No.", rec."Quote No.");
                        if Pheader.Find('-') then
                            page.run(page::"Proc-Purchase Quote.Card", Pheader)
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Scored; Rec.Scored)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scored field.';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = all;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
            }
        }
    }
}