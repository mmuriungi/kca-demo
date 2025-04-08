table 51318 "Risk Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {

            AutoIncrement = true;
        }
        field(2; "Risk No"; Code[10])
        {

        }
        field(3; "Risk Details Line"; Code[90])
        {
            Caption = 'Risk Details Line';
            TableRelation = "Risk Details";
        }
        field(4; "Risk Category"; Code[130])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Details";
        }
        field(5; "Risk Type"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories" where(Type = const(Type));
            trigger OnValidate()
            var
                RiskCategory: Record "Risk Categories";
            begin

                IF RiskCategory.GET("Risk Type") THEN
                    "Risk Type Description" := RiskCategory.Description;
            end;
        }
        field(6; "Risk Type Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No", "Risk Details Line", "Risk Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}