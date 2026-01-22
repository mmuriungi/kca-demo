#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99401 "POS Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Receipt No."; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(3; "Students Cashbook"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(4; "Students Sales Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(5; "Pos Items Series"; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Sales No."; Code[30])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Staff Cashbook"; Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(8; "Staff Sales Account"; Code[30])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(9; "Stock Adjustment"; Code[30])
        {
            TableRelation = "No. Series";
        }
        field(10; "Cash Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(11; "Ecitizen Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }


    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Cancelled');
    end;

    trigger OnInsert()
    begin
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Cancelled');
    end;

    trigger OnModify()
    begin
        if UserId <> 'KUCSERVER\ASIMBA' then Error('Cancelled');
    end;
}

