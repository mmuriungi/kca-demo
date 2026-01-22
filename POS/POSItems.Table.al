#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99404 "POS Items"
{

    fields
    {
        field(1; "No."; Code[30])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Unit Of measure"; Code[10])
        {
            TableRelation = "Pos Unit of Measure".Code where("Item Code" = field("No."));
        }
        field(4; Inventory; Decimal)
        {
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No.")));
            FieldClass = FlowField;
        }
        field(6; "Date Filter"; Date)
        {
        }
        field(7; "Sales Amount"; Decimal)
        {
            CalcFormula = sum("POS Sales Lines"."Line Total" where("No." = field("No."),
                                                                    "Posting date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(8; "Sold Units"; Decimal)
        {
            CalcFormula = sum("POS Item Ledger".Quantity where("Item No." = field("No."),
                                                                "Entry Type" = filter(Consumption)));
            FieldClass = FlowField;
        }
        field(9; "No. Series"; Code[30])
        {
        }
        field(10; Active; Boolean)
        {
        }
        field(11; "Student Price"; Decimal)
        {
            CalcFormula = lookup("Pos Unit of Measure"."Student Price" where("Item Code" = field("No."),
                                                                              Code = field("Unit Of measure")));
            FieldClass = FlowField;
        }
        field(12; "Staff Price"; Decimal)
        {
            CalcFormula = lookup("Pos Unit of Measure"."Staff Price" where("Item Code" = field("No."),
                                                                            Code = field("Unit Of measure")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PosSetup.Get;
            PosSetup.TestField(PosSetup."Pos Items Series");
            NoSeriesMgt.InitSeries(PosSetup."Pos Items Series", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

