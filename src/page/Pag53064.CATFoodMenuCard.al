page 53064 "CAT-Food Menu Card"
{
    PageType = Document;
    SourceTable = "CAT-Food Menu";

    layout
    {
        area(content)
        {
            group(weqtwr)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Items Cost"; Rec."Items Cost")
                {
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {

                    trigger OnValidate()
                    begin
                        Rec.Amount := (Rec."Unit Cost" * Rec.Quantity) + Rec."Items Cost";
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec.Amount := Rec."Unit Cost" + Rec."Items Cost";
                    end;
                }
                field(Quantity; Rec.Quantity)
                {

                    trigger OnValidate()
                    begin
                        Rec.Amount := (Rec."Unit Cost" * Rec.Quantity) + Rec."Items Cost";
                    end;
                }
                field("Units Of Measure"; Rec."Units Of Measure")
                {
                }
                field(Type; Rec.Type)
                {
                }
                part(Recipe; "CAT-Food Menu Line")
                {
                    Caption = 'Recipe';
                    SubPageLink = Menu = FIELD(Code),
                                  Type = FIELD(Type);
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec.Amount := Rec."Items Cost" + Rec."Unit Cost";
    end;

    local procedure AmountOnInputChange(var Text: Text[1024])
    begin
        Rec.Amount := Rec."Unit Cost" + Rec."Items Cost";
    end;
}

