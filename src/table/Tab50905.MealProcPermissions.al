table 50905 "Meal-Proc. Permissions"
{

    fields
    {
        field(1; "User Id"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(2; "Create Batch"; Boolean)
        {
        }
        field(3; "Edit Batch"; Boolean)
        {
        }
        field(4; "Create Meal-Proc. plan"; Boolean)
        {
        }
        field(5; "Edit Meal-Proc. plan"; Boolean)
        {
        }
        field(6; "Create BOM Det."; Boolean)
        {
        }
        field(7; "Edit BOM Det."; Boolean)
        {
        }
        field(8; "Approve Orders"; Boolean)
        {
        }
        field(11; "Modify After Approval"; Boolean)
        {
        }
        field(12; "Delete After Approval"; Boolean)
        {
        }
        field(13; "Insert After Approval"; Boolean)
        {
        }
        field(14; "Production  Area"; Option)
        {
            OptionCaption = ' ,Kitchen,Location a,Location b';
            OptionMembers = " ",Kitchen,"Location a","Location b";
        }
        field(15; "Default Raw Material Location"; Code[20])
        {
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                IF "Default Raw Material Location" <> '' THEN BEGIN
                    IF "Default Raw Material Location" = "Default Product Location" THEN
                        ERROR('Error in locations Mapping')
                END;
            end;
        }
        field(16; "Default Product Location"; Code[20])
        {
            TableRelation = Location.Code;

            trigger OnValidate()
            begin
                IF "Default Product Location" <> '' THEN BEGIN
                    IF "Default Raw Material Location" = "Default Product Location" THEN
                        ERROR('Error in locations Mapping')
                END;
            end;
        }
        field(17; "Default Meal-Proc. Template"; Code[20])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(18; "Default Meal-Proc. Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Default Meal-Proc. Template"));
        }
    }

    keys
    {
        key(Key1; "User Id")
        {
        }
    }

    fieldgroups
    {
    }
}

