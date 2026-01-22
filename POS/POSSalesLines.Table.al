#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99407 "POS Sales Lines"
{
    DrillDownPageID = "POS Sales Lines LST";
    LookupPageID = "POS Sales Lines LST";

    fields
    {
        field(1; "Line No."; Integer)
        {
        }
        field(2; "Document No."; Code[10])
        {
        }
        field(3; "No."; Code[10])
        {
            TableRelation = "POS Items"."No.";

            trigger OnValidate()
            begin
                officeTemp.Get(UserId);
                qty := 0;
                itemledger.Reset();
                itemledger.SetRange("Item No.", "No.");
                itemledger.SetRange(Location, officeTemp."Default Direct Sales Location");
                if itemledger.Find('-') then begin
                    repeat
                        qty := qty + itemledger.Quantity;
                    until itemledger.Next() = 0;
                    if qty < 1 then
                        Error('You are Out of stock');
                end else if not itemledger.Find('-') then Error('Out of stock');
                posItems.Reset();
                posItems.SetRange("No.", Rec."No.");
                if posItems.Find('-') then begin
                    posItems.TestField("Unit Of measure");
                    Rec.Description := posItems.Description;
                    Rec."Unit Of Measure" := posItems."Unit Of measure";
                    PosUoM.Reset();
                    PosUoM.SetRange("Item Code", Rec."No.");
                    if PosUoM.Find('-') then begin
                        PosSalesheader.Reset();
                        PosSalesheader.SetRange("No.", Rec."Document No.");
                        if PosSalesheader.Find('-') then begin
                            if PosSalesheader."Customer Type" = PosSalesheader."customer type"::Student then begin
                                Rec.Price := PosUoM."Student Price";
                                Rec.Quantity := 1;
                                Rec."Line Total" := Rec.Price;
                            end else
                                if PosSalesheader."Customer Type" = PosSalesheader."customer type"::Staff then begin
                                    Rec.Price := PosUoM."Staff Price";
                                    Rec.Quantity := 1;
                                    Rec."Line Total" := Rec.Price;
                                end;
                        end;
                    end;
                    PosSalesheader.Get("Document No.");
                    Location := PosSalesheader.Location;
                end;
            end;
        }
        field(4; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                if Quantity > Inventory then
                    Error('The quantities Prepared have been depleted');
                CalculatePrice();
            end;
        }
        field(5; Description; Text[30])
        {
        }
        field(6; "Unit Of Measure"; Code[10])
        {
        }
        field(7; Price; Decimal)
        {
        }
        field(8; "Line Total"; Decimal)
        {
        }
        field(9; Inventory; Decimal)
        {
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No."),
                                                                Location = field(Location)));
            FieldClass = FlowField;
        }
        field(10; "Serving Category"; Option)
        {
            OptionCaption = 'Student,Staff';
            OptionMembers = Student,Staff;
        }
        field(11; "Posting date"; Date)
        {
        }
        field(12; Posted; Boolean)
        {
        }
        field(13; Location; Code[30])
        {
            TableRelation = Location;
        }
        field(14; "Sale exist"; Boolean)
        {
            CalcFormula = exist("POS Sales Header" where("No." = field("Document No.")));
            FieldClass = FlowField;
            TableRelation = "POS Sales Header"."No." where("No." = field("Document No."));
        }
        field(15; Batch_id; Integer)
        {
            CalcFormula = lookup("POS Sales Header".Batch_Id where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(16; User_Id; Code[20])
        {
            CalcFormula = lookup("POS Sales Header".Cashier where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(17; "Post Date"; Date)
        {
            CalcFormula = lookup("POS Sales Header"."Posting date" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Document No.", "Serving Category", "Posting date", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF USERID<> 'KUCSERVER\ASIMBA' THEN ERROR('Cancelled');
    end;

    trigger OnModify()
    begin
        Clear(SalesHeader);
        SalesHeader.Reset;
        SalesHeader.SetRange("No.", Rec."Document No.");
        if SalesHeader.Find('-') then begin
            if SalesHeader.Posted = true then Error('Posted receipts can not be edited!');
            SalesHeader."Posting date" := Today;
            if SalesHeader.Modify then;
        end;
    end;

    var
        itemledger: Record "POS Item Ledger";
        qty: Decimal;
        posItems: Record "POS Items";
        PosUoM: Record "Pos Unit of Measure";
        PosSalesheader: Record "POS Sales Header";
        officeTemp: Record "FIN-Cash Office User Template";
        SalesHeader: Record "POS Sales Header";


    procedure CalculatePrice()
    begin
        if ((Price <> 0) or (Quantity <> 0)) then begin
            "Line Total" := Price * Quantity;
        end;
    end;
}

