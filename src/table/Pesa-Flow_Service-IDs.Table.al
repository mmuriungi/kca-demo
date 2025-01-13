#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77392 "Pesa-Flow_Service-IDs"
{
    DrillDownPageID = "Pesaflow_Service-Ids";
    LookupPageID = "Pesaflow_Service-Ids";

    fields
    {
        field(1;Service_ID;Code[20])
        {
        }
        field(2;"Service ID Description";Text[150])
        {
        }
        field(3;Bank_Id;Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(4;"Bank Name";Text[150])
        {
            CalcFormula = lookup("Bank Account".Name where ("No."=field(Bank_Id)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;Service_ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

