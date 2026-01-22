#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99409 "Cafeteria Sales Batches"
{

    fields
    {
        field(1; User_Id; Code[20])
        {
        }
        field(2; Batch_Date; Date)
        {
            TableRelation = Date;
        }
        field(3; Batch_Id; Integer)
        {
        }
        field(4; "Un-posted Receipts"; Integer)
        {
            CalcFormula = count("POS Sales Header" where("Posting date" = field(Batch_Date),
                                                          Cashier = field(User_Id),
                                                          Batch_Id = field(Batch_Id),
                                                          "Receipt Posted to Ledger" = filter(false),
                                                          Posted = filter(true),
                                                          "Receipt Amount" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(5; "Batch Status"; Option)
        {
            OptionCaption = 'New,Posted,Cancelled';
            OptionMembers = New,Posted,Cancelled;
        }
        field(6; "Posted By"; Code[20])
        {
        }
        field(7; "Date Posted"; Date)
        {
        }
        field(8; "Time Posted"; Time)
        {
        }
        field(9; "Batch Amount"; Decimal)
        {
            CalcFormula = sum("POS Sales Lines"."Line Total" where(Batch_id = field(Batch_Id),
                                                                    "Posting date" = field(Batch_Date),
                                                                    User_Id = field(User_Id)));
            FieldClass = FlowField;
        }
        field(10; "Exists Unposted"; Boolean)
        {
            CalcFormula = exist("POS Sales Header" where(Cashier = field(User_Id),
                                                          Batch_Id = field(Batch_Id),
                                                          "Posting date" = field(Batch_Date),
                                                          Posted = filter(true),
                                                          "Receipt Posted to Ledger" = filter(false)));
            FieldClass = FlowField;
        }
        field(11; "posted Receipts"; Integer)
        {
            CalcFormula = count("POS Sales Header" where("Posting date" = field(Batch_Date),
                                                          Cashier = field(User_Id),
                                                          Batch_Id = field(Batch_Id),
                                                          "Receipt Posted to Ledger" = filter(true),
                                                          Posted = filter(true),
                                                          "Receipt Amount" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(12; "Number of Recipts"; Integer)
        {
            CalcFormula = count("POS Sales Header" where("Posting date" = field(Batch_Date),
                                                          Cashier = field(User_Id),
                                                          Batch_Id = field(Batch_Id),
                                                          Posted = filter(true),
                                                          "Receipt Amount" = filter(<> 0)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; User_Id, Batch_Date, Batch_Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

