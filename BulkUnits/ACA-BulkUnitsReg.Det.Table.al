#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99256 "ACA-Bulk Units Reg. Det"
{

    fields
    {
        field(1;"Semester Code";Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(2;"Academic Year";Code[20])
        {
            CalcFormula = lookup("ACA-Semesters"."Academic Year" where (Code=field("Semester Code")));
            FieldClass = FlowField;
        }
        field(3;"Program Code";Code[20])
        {
            TableRelation = "ACA-Programme";
        }
        field(4;"Unit Code";Code[20])
        {
            TableRelation = "ACA-Units/Subjects".Code where ("Programme Code"=field("Program Code"));
        }
        field(5;Registered;Boolean)
        {
            CalcFormula = exist("ACA-Student Units" where ("Student No."=field("Student No."),
                                                           Programme=field("Program Code"),
                                                           Unit=field("Unit Code"),
                                                           "Reg. Reversed"=filter(false)));
            FieldClass = FlowField;
        }
        field(6;"Student No.";Code[20])
        {
            TableRelation = Customer."No." where ("Customer Posting Group"=filter('STUDENT'));
        }
        field(7;"Student Name";Text[250])
        {
            CalcFormula = lookup(Customer.Name where ("No."=field("Student No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Semester Code","Program Code","Unit Code","Student No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

