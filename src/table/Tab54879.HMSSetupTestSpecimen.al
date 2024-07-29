table 54879 "HMS-Setup Test Specimen"
{
    //LookupPageID = "HMS Setup Test Specimen List";

    fields
    {

        field(1; "specimen code"; Code[30])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMS-Setup Lab Test".Code;
            //TableRelation = AllSpecimentList."Laboratory Test Package Code";
        }
        field(2; "Lab Test"; Code[60])
        {
            DataClassification = ToBeClassified;
            //TableRelation = AllSpecimentList."Laboratory Test Package Code";

        }

        field(3; "Specimen Name"; Code[60])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Lab Test Description"; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Result"; Code[60])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                SpecimenChecker: Codeunit "Specimen Result Checker";
            begin
                SpecimenChecker.CheckSpecimenResult(Rec);
            end;
        }
        field(6; unit; Code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Minimum Value"; Decimal)
        {
        }
        field(7; "Maximum Value"; Decimal)
        {
        }
        field(8; Flag; code[60])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Patient No."; code[56])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS-Treatment Form Laboratory"."Patient No.";
        }
        field(20; "Treatment No."; code[56])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS-Treatment Form Laboratory"."Treatment No.";
        }
        field(21; "Laboratory Test Package Code"; code[56])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS-Treatment Form Laboratory"."Laboratory Test Package Code";
            //TableRelation = "HMS-Treatment Form Laboratory"."Laboratory Test Package Code";
        }
        field(22; "Non-Ranged Result"; code[45])
        {
            DataClassification = ToBeClassified;
            TableRelation = NonRangedResults."result Name";
        }
        field(23; "Line No"; Integer)
        {
            AutoIncrement = true;
        }

    }

    keys
    {
        key(Key1; "Treatment No.", "Laboratory Test Package Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

