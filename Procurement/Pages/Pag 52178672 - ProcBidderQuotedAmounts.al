page 52178672 "Proc Bidder Quoted Amounts"
{
    Caption = 'Recommended Bidder(s)';
    PageType = ListPart;
    SourceTable = "Proc Bidder Quoted Amounts";
    //DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Select field.', Comment = '%';
                }
                field("Bid No"; Rec."Bid No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bid No field.', Comment = '%';
                    DrillDownPageId = "Proc-Purchase Quote.Card";
                    Caption = 'Quote/Bid No.';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Pheader: Record "Purchase Header";
                    begin
                        Pheader.Reset();
                        Pheader.SetRange("No.", rec."Bid No");
                        if Pheader.Find('-') then
                            page.run(page::"Proc-Purchase Quote.Card", Pheader)
                    end;
                }
                field("Supplier No"; Rec."Supplier No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier No field.', Comment = '%';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Name field.', Comment = '%';
                }
                field("Item No"; Rec."Item No")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No field.', Comment = '%';
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Cost field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order No field.', Comment = '%';
                    DrillDownPageId = "Purchase Order";

                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Pheader: Record "Purchase Header";
                    begin
                        Pheader.Reset();
                        Pheader.SetRange("No.", rec."Order No");
                        if Pheader.Find('-') then
                            page.run(page::"Purchase Order", Pheader)
                    end;
                }
            }
        }
    }
}
