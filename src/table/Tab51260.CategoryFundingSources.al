#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51260 "Category Funding Sources"
{
    //DrillDownPageID = UnknownPage77388;
    //LookupPageID = UnknownPage77388;

    fields
    {
        field(1; "Category Code"; Code[20])
        {
        }
        field(2; "Funding Source Code"; Code[50])
        {
            TableRelation = Student_Funding_Sources."Source Code";
        }
        field(3; "Funding %"; Decimal)
        {
            Caption = '% Funding';
            MaxValue = 100;
            MinValue = 0.1;
        }
    }

    keys
    {
        key(Key1; "Category Code", "Funding Source Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

