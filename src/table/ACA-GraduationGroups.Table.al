#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 66616 "ACA-Graduation Groups"
{

    fields
    {
        field(1;"Exam Category";Code[20])
        {
        }
        field(2;"Academic Year";Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(3;"Graduation Group";Code[20])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
    }

    keys
    {
        key(Key1;"Exam Category","Academic Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if ((UserId<>'KUCSERVER\FLUSESI') and (UserId<>'KUCSERVER\MKUYU')) then Error('Access Denied');
    end;

    trigger OnModify()
    begin
        if ((UserId<>'KUCSERVER\PGITHINJI') and (UserId<>'KUCSERVER\MKUYU')) then Error('Access Denied');
    end;

    trigger OnRename()
    begin
        if ((UserId<>'KUCSERVER\FLUSESI') and (UserId<>'KUCSERVER\MKUYU')) then Error('Access Denied');
    end;
}

