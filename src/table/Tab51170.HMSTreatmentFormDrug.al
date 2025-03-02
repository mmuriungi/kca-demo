table 51170 "HMS-Treatment Form Drug"
{
    DrillDownPageId = "HMS-Treatment Form Drug";
    LookupPageId = "HMS-Treatment Form Drug";
    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Drug No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                IF Itm.GET("Drug No.") THEN begin
                    "Drug Name" := Itm.Description;
                    "unit cost " := itm."Unit Cost";
                    "Unit Of Measure II" := itm."Unit of measure";
                    Itm.CalcFields(Inventory);


                end;

                "Quantity In Store" := itm.Inventory;

                /*Check if the drug has any drug within the prescription where it is not compatible*/
                Interaction.RESET;
                Interaction.SETRANGE(Interaction."Drug No.", "Drug No.");
                IF Interaction.FIND('-') THEN BEGIN
                    REPEAT
                        /*Get the lines of drugs that have been identified as being incompatible with the drug selected*/
                        Line.RESET;
                        Line.SETRANGE(Line."Treatment No.", "Treatment No.");
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
                        Line.SETRANGE(Line."Treatment No.", "Treatment No.");
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
        field(3; "Drug Name"; Text[150])
        {
        }
        field(4; Quantity; Integer)
        {
            trigger OnValidate()
            begin
                if Quantity > "Quantity In Store" then
                    error('Can not Prescribe more than what is in store');
                "Quantity to issue" := Quantity;


                rec.Modify();

            end;
        }
        field(5; "Unit Of Measure"; Code[20])
        {

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
        field(13; "Product Group"; Code[20])
        {

            TableRelation = "Item Category".Code;

        }
        field(14; "No stock Drugs"; Text[250])
        {
        }
        field(15; Price; Decimal)
        {

        }
        field(20; "Unit of Measure II"; Code[56])
        {
            //OptionMembers = ,Tablets;
        }
        field(21; "Pharmacy No."; code[20])
        {

        }
        field(22; "Quantity to issue"; Decimal)
        {

        }
        field(23; "Quantity In Store"; Decimal)
        {

        }
        field(115; "Route of Administration"; Option)
        {
            OptionMembers = "",oral,injection,"Enteral Routes of Medication","Sublingual and Buccal Routes","Rectal Route","Parenteral Routes of Medication","Intravenous Route","Intramuscular Route"
,"Subcutaneous Route";
            DataClassification = ToBeClassified;
        }
        field(134; " Total Number Of Tablets"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin

                //rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                rec." Total Cost" := "unit cost " * " Total Number Of Tablets";
                rec.Modify();


            end;
        }
        field(116; "Dosage Frequencies "; Integer)
        {
            //OptionMembers = " ",hourly,daily;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin

                //rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                rec." Total Cost" := "unit cost " * " Total Number Of Tablets";
                rec.Modify();


            end;
        }
        field(117; "Number Of Days"; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin

                //rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                rec." Total Cost" := "unit cost " * " Total Number Of Tablets";
                rec.Modify();


            end;

        }
        field(118; "unit cost "; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var

            begin

                rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                //rec." Total Cost" := "unit cost " * " Total Number Of Tablets";

            end;
        }
        field(119; " Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Treatment No.", "Drug No.", "Pharmacy No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Interaction: Record "HMS-Drug Interaction";
        Line: Record "HMS-Treatment Form Drug";
        Itm: Record Item;
        itemledger: Record "Pharmacy Item Ledger";
}

