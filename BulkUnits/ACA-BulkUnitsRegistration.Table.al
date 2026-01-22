#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 99255 "ACA-Bulk Units Registration"
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
        field(5;"User ID";Text[150])
        {
        }
        field(6;Created;DateTime)
        {
        }
    }

    keys
    {
        key(Key1;"Semester Code","Program Code","Unit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Rec."User ID":=UserId;
        Rec.Created:=CurrentDatetime;
    end;

    trigger OnModify()
    begin
        Rec."User ID":=UserId;
        Rec.Created:=CurrentDatetime;
    end;

    trigger OnRename()
    begin
        Rec."User ID":=UserId;
        Rec.Created:=CurrentDatetime;
    end;
}

