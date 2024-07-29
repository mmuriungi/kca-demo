table 54264 "POS Sales Lines"
{
    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Document No."; code[20])
        {
        }
        field(3; "No."; code[20])
        {
            TableRelation = "POS Items"."No." where("Serving Category" = field("Serving Category"));
            trigger OnValidate()
            var
                itemledger: Record "POS Item Ledger";
                qty: decimal;
            begin
                qty := 0;
                itemledger.Reset();
                itemledger.SetRange("Item No.", "No.");
                if itemledger.Find('-') then begin
                    repeat
                        qty := qty + itemledger.Quantity;
                    until itemledger.Next() = 0;
                    if qty < 1 then
                        Error('You are Out of stock');
                end;
                posItems.Reset();
                posItems.SetRange("No.", Rec."No.");
                if posItems.Find('-') then begin
                    posItems.TestField("Unit of measure");
                    Rec.description := posItems.Description;
                    Rec."Unit of Measure" := posItems."Unit of measure";
                    PosUoM.Reset();
                    PosUoM.SetRange("Item Code", Rec."No.");
                    if PosUoM.Find('-') then begin
                        PosSalesheader.Reset();
                        PosSalesheader.SetRange("No.", Rec."Document No.");
                        if PosSalesheader.Find('-') then begin
                            if PosSalesheader."Customer Type" = PosSalesheader."Customer Type"::Student then begin
                                Rec.Price := PosUoM."Student Price";
                                Rec.Quantity := 1;
                                Rec."Line Total" := Rec.Price;
                            end else
                                if PosSalesheader."Customer Type" = PosSalesheader."Customer Type"::Staff then begin
                                    Rec.Price := PosUoM."Staff Price";
                                    Rec.Quantity := 1;
                                    Rec."Line Total" := Rec.Price;
                                end;
                        end;

                    end;

                end;
            end;
        }
        field(4; "Quantity"; Decimal)
        {
            trigger OnValidate()
            begin
                if Quantity > Inventory then
                    Error('The quantities Prepared have been depleted');
                CalculatePrice();
            end;
        }
        field(5; "Description"; Text[100])
        {
        }
        field(6; "Unit of Measure"; code[30])
        {
            TableRelation = "Pos Unit of Measure".Code;
        }
        field(7; "Price"; Decimal)
        {

        }
        field(8; "Line Total"; Decimal)
        {

        }
        field(10; "Inventory"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No.")));
        }
        field(11; "Serving Category"; Option)
        {
            OptionMembers = Student,staff,NonRevenue;
        }
        field(13; "Posting Date"; date)
        {

        }
        field(14; Posted; boolean)
        {

        }
    }

    keys
    {
        key(key1; "Line No.", "Document No.", "Serving Category", "Posting Date")
        {

        }
    }
    var
        posItems: Record "POS Items";
        PosUoM: Record "Pos Unit of Measure";
        PosSalesheader: Record "POS Sales Header";


    procedure CalculatePrice()
    begin
        if ((Price <> 0) or (Quantity <> 0)) then begin
            "Line Total" := Price * Quantity;
        end;
    end;
}