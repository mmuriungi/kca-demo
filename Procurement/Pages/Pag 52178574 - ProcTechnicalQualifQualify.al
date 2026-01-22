page 52178574 "Proc-Technical Qualif.Qualify"
{
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Proc-Technical Qualif.Quote";
    SourceTableView = where("Quote Status" = filter(Technical));
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quote No."; Rec."Quote No.")
                {
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
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Scored; Rec.Scored)
                {
                    Caption = 'Score';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scored field.';
                }

                field("Maximum Score"; Rec."Maximum Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Score field.';
                }
                field(Evaluated; rec.Evaluated)
                {
                    Editable = false;
                    ApplicationArea = All;
                }


            }
        }
    }
}