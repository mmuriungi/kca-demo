table 50308 "HRM-Attachment Register"
{

    fields
    {
        field(1; "Serial No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; Names; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Institution; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Course/Level"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Attachement Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Attachment PeriodCodes"."Period Code" WHERE("Training Year" = FIELD("Training Year"));
        }
        field(6; "Contract No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Department Attached"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('DEPARTMENTS'));
        }
        field(8; "Department Name"; Text[100])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Department Attached"),
                                                               "Global Dimension No." = FILTER(2)));
            FieldClass = FlowField;
        }
        field(9; "Training Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Training Years"."Training Year Code";
        }
    }

    keys
    {
        key(Key1; "Serial No", "Training Year")
        {
        }
    }

    fieldgroups
    {
    }
}

