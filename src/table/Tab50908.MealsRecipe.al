table 50908 "Meals Recipe"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Meal Code"; Code[20])
        {
            TableRelation = "CAT-Meals Setup".Code;
            DataClassification = ToBeClassified;
        }
        field(2; "Meal Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("CAT-Meals Setup".Discription WHERE(Code = FIELD("Meal Code")));
        }
        field(3; "Resource Type"; Option)
        {
            OptionMembers = Item,Human,Electricity,Gas,Other;
            OptionCaption = 'Item,Human,Electricity,Gas,Other';
        }
        field(4; Resource; Code[30])
        {
            TableRelation = IF ("Resource Type" = CONST(Item)) Item."No.";

            trigger OnValidate()
            VAR
                itemz: Record Item;
            BEGIN
                IF "Resource Type" = "Resource Type"::Item THEN BEGIN
                    IF itemz.GET(Resource) THEN BEGIN
                        "Resource Name" := itemz.Description;
                        "Unit Cost" := itemz."Unit Cost";
                        "Unit Price" := itemz."Unit Price";
                    END;
                END;
            END;
        }
        field(5; "Resource Name"; Text[150])
        {

        }
        field(6; Quantity; Decimal)
        {
            trigger OnValidate()
            BEGIN
                "Final Cost" := ROUND(("Unit Cost" * Quantity), 5, '=');
                "Final Price" := ROUND((("Unit Cost" * Quantity) + (("Markup %" / 100) * ("Unit Cost" * Quantity))), 5, '=');
            END;
        }
        field(7; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            BEGIN
                VALIDATE(Quantity);
            END;
        }
        field(8; "Markup %"; Decimal)
        {
            Trigger OnValidate()
            BEGIN
                IF "Unit Cost" = 0 THEN ERROR('Specify The Unit Cost first!');
                IF NOT ("Markup %" IN [1 .. 100]) THEN ERROR('The Mark-up should be between One (1%) and One Hundred Percent (100%)');
                "Unit Price" := "Unit Cost" + ("Markup %" / 100) * ("Unit Cost");
                VALIDATE(Quantity);
            END;
        }
        field(9; "Unit Price"; Decimal)
        {

            trigger OnValidate()
            BEGIN
                VALIDATE(Quantity);
            END;
        }
        field(10; "Final Cost"; Decimal)
        {

        }
        field(11; "Final Price"; Decimal)
        {

        }

    }

    keys
    {
        key(PK; "Meal Code", Resource)
        {
            Clustered = true;
        }
    }

}