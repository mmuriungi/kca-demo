#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 78013 "NFM Statement Entry"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Student No.";Code[25])
        {
        }
        field(3;Description;Text[250])
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;Semester;Code[25])
        {
        }
        field(6;Date;Date)
        {
        }
        field(7;"Debit amount";Decimal)
        {
        }
        field(8;"Credit amount";Decimal)
        {
        }
        field(9;Type;Option)
        {
            OptionCaption = 'Debit,Credit';
            OptionMembers = Debit,Credit;
        }
        field(10;Balance;Decimal)
        {
            CalcFormula = sum("NFM Statement Entry".Amount where ("Student No."=field("Student No.")));
            FieldClass = FlowField;
        }
        field(11;"Processing Fee Added";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Entry No",Semester,"Student No.",Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

