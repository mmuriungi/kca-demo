#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 77361 "ACA-New Stud. Doc. Setup"
{
    //DrillDownPageID = UnknownPage77361;
    //LookupPageID = UnknownPage77361;

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
        }
        field(2; "Document Code"; Code[50])
        {
            NotBlank = true;
        }
        field(3; Mandatory; Boolean)
        {
        }
        field(4; Approvers; Integer)
        {
            CalcFormula = count("Admission Document Approvers" where("Academic Year" = field("Academic Year"),
                                                                      "Document Code" = field("Document Code")));
            FieldClass = FlowField;
        }
        field(5; "Final Stage"; Boolean)
        {
        }
        field(6; Sequence; Integer)
        {
        }
        field(7; "Next Sequence"; Integer)
        {
        }
        field(8; "First Stage"; Boolean)
        {
        }
        field(9; "Is Hostel"; Boolean)
        {
        }
        field(10; "Report Caption"; Text[150])
        {
        }
        field(11; "Signoff Caption"; Text[150])
        {
        }
        field(12; "Hide in Report"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Academic Year", "Document Code")
        {
            Clustered = true;
        }
        key(Key2; "Academic Year", Sequence)
        {
        }
    }

    fieldgroups
    {
    }
}

