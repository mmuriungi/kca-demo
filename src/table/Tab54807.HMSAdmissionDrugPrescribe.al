table 54807 "HMS-Admission Drug Prescribe"
{

    fields
    {
        field(1; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Drug No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item."No." WHERE("Location Filter" = FIELD("Pharmacy Code"),
                                            "Inventory Posting Group" = CONST('MEDICAL'));

            trigger OnValidate()
            var
                Interaction: Record "HMS-Drug Interaction";
                Line: Record "HMS-Admission Drug Prescribe";
            begin

                /*Check if the drug has any drug within the prescription where it is not compatible*/
                Interaction.RESET;
                Interaction.SETRANGE(Interaction."Drug No.", "Drug No.");
                IF Interaction.FIND('-') THEN BEGIN
                                                  REPEAT
                                                      /*Get the lines of drugs that have been identified as being incompatible with the drug selected*/
                                                      Line.RESET;
                                                      Line.SETRANGE(Line."Admission No.", "Admission No.");
                                                      Line.SETRANGE(Line."Drug No.", Interaction."Drug No. 1");
                                                      IF Line.FIND('-') THEN BEGIN
                                                          Line.CALCFIELDS(Line."Drug Name");
                                                          IF CONFIRM('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?', FALSE) = TRUE THEN BEGIN
                                                              Line."Marked as Incompatible" := TRUE;
                                                              Line.MODIFY;
                                                          END
                                                          ELSE BEGIN
                                                              ERROR('Drug Incompatible.Operation Cancelled');
                                                          END;
                                                      END;
                                                      Line.RESET;
                                                      Line.SETRANGE(Line."Admission No.", "Admission No.");
                                                      Line.SETRANGE(Line."Drug No.", Interaction."Drug No.");
                                                      IF Line.FIND('-') THEN BEGIN
                                                          Line.CALCFIELDS(Line."Drug Name");
                                                          IF CONFIRM('Drug:' + Line."Drug Name" + '::' + Interaction."Alert Remarks" + '. CONTINUE?', FALSE) = TRUE THEN BEGIN
                                                              Line."Marked as Incompatible" := TRUE;
                                                              Line.MODIFY;
                                                          END
                                                          ELSE BEGIN
                                                              ERROR('Drug Incompatible.Operation Cancelled');
                                                          END;
                                                      END;

                                                  UNTIL Interaction.NEXT = 0;
                END;

            end;
        }
        field(3; "Drug Name"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Drug No.")));
            FieldClass = FlowField;
        }
        field(4; Quantity; Integer)
        {
        }
        field(5; "Unit Of Measure"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Drug No."));
        }
        field(6; Remarks; Text[100])
        {
        }
        field(7; "Pharmacy Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Location.Code;
        }
        field(8; "Actual Quantity"; Decimal)
        {
        }
        field(9; Inventory; Decimal)
        {
        }
        field(10; Issued; Boolean)
        {
        }
        field(11; Dosage; Text[200])
        {
            NotBlank = true;
        }
        field(12; "Marked as Incompatible"; Boolean)
        {
        }
        field(13; "Actual Quantity Issued"; Decimal)
        {
            CalcFormula = Lookup("HMS-Pharmacy Line"."Issued Quantity" WHERE("Link No." = FIELD("Admission No."),
                                                                              "Link Type" = CONST('ADMISSION'),
                                                                              "Drug No." = FIELD("Drug No.")));
            FieldClass = FlowField;
        }
        field(14; "Remaining Quantity"; Decimal)
        {
            CalcFormula = Lookup("HMS-Pharmacy Line".Remaining WHERE("Link No." = FIELD("Admission No."),
                                                                      "Link Type" = CONST('ADMISSION'),
                                                                      "Drug No." = FIELD("Drug No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Drug No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Interaction: Record "HMS-Drug Interaction";
        Line: Record "HMS-Admission Drug Prescribe";
}

