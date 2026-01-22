page 52178588 "Proc-Evaluation Confirmation"
{
    Caption = 'Evaluation Confirmation';
    PageType = ListPart;
    SourceTable = "Proc-Confirm Recommended";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where(Confirmed = filter(false));
    layout
    {
        area(Content)
        {
            repeater(General)
            {


                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Bidder No"; Rec."Bidder No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bidder No field.';
                    DrillDownPageId = "Proc-Purchase Quote.Card";
                    Caption = 'Quote/Bid No.';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Pheader: Record "Purchase Header";
                    begin
                        Pheader.Reset();
                        Pheader.SetRange("No.", rec."Bidder No");
                        if Pheader.Find('-') then
                            page.run(page::"Proc-Purchase Quote.Card", Pheader)
                    end;
                }

                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(Email; Rec.Email)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }

                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommendation field.';
                }

                field("Date"; Rec."Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
            }
        }
    }
}