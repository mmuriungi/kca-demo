page 52178575 "Proc-Demo Qualif.Qualify"
{
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Proc-Demo Qualif.Quote";
    SourceTableView = where("Quote Status" = filter(Demonstration));
    layout
    {
        area(Content)
        {
            repeater(General)
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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Scored field.';
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Score field.';
                }

                field(Evaluated; Rec.Evaluated)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Evaluated field.';
                }


            }


        }
    }
}