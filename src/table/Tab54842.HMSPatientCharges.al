table 54842 "HMS-Patient Charges"
{
    DrillDownPageID = "HMS-Patient Charges List";
    LookupPageID = "HMS-Patient Charges List";

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            //TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('HOSPITAL'));
            //TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('LOCAL'));
        }
        field(3; "Transaction Type"; Option)
        {
            Editable = true;
            OptionCaption = 'Charges,Item';
            OptionMembers = Charges,Item;
        }
        field(4; "Code"; Code[20])
        {
            Editable = true;
            TableRelation = IF ("Transaction Type" = CONST(Charges)) "HMS-Class Setups"."Class Code"
            ELSE
            IF ("Transaction Type" = CONST(Item)) Item."No.";

            trigger OnValidate()
            begin
                VALIDATE("Transacton ID");
                Date := TODAY;
                IF "Transaction Type" = "Transaction Type"::Charges THEN BEGIN
                    Charges.SetRange("Class Code", Code);
                    IF Charges.Find('-') THEN BEGIN
                        Description := Charges.Description;
                        Amount := Charges.Amount;
                    END;
                    Charge := TRUE;
                END
                ELSE
                    IF "Transaction Type" = "Transaction Type"::Item THEN begin
                        Item.SetRange("No.", Code);
                        if Item.Find('-') THEN begin
                            Description := Item.Description;
                            Amount := Item."Unit Price";
                        end;
                        Charge := TRUE;
                    end
                    ELSE
                        Charge := FALSE;
            end;
        }
        field(5; Description; Text[150])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Remarks; Text[200])
        {
        }
        field(8; Date; Date)
        {
            NotBlank = true;
        }
        field(9; "Amount Paid"; Decimal)
        {
        }
        field(11; "Applied Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
               TotalApplied:=0;

               StudentCharges.RESET;
               StudentCharges.SETRANGE(StudentCharges."Student No.","Student No.");
               IF StudentCharges.FIND('-') THEN BEGIN
               REPEAT
               TotalApplied:=TotalApplied+StudentCharges."Applied Amount";
               UNTIL StudentCharges.NEXT = 0;
               END;


               IF "Applied Amount" <> xRec."Applied Amount" THEN
               TotalApplied := TotalApplied + ("Applied Amount" - xRec."Applied Amount")
               ELSE
               TotalApplied := TotalApplied + "Applied Amount";


               StudentPayments.RESET;
               StudentPayments.SETRANGE(StudentPayments."Student No.","Student No.");
               IF StudentPayments.FIND('-') THEN BEGIN
               StudentPayments."Unapplied Amount":=StudentPayments."Amount to pay"-TotalApplied;
               StudentPayments.MODIFY;
               END;
               */

            end;
        }
        field(12; "Apply too"; Boolean)
        {
        }
        field(16; "Apply to"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Recovered First" = FALSE THEN BEGIN
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Customer No.", "Customer No.");
                    StudentCharges.SETRANGE(StudentCharges."Apply to", FALSE);
                    StudentCharges.SETRANGE(StudentCharges."Fully Paid", FALSE);
                    StudentCharges.SETRANGE(StudentCharges."Recovered First", TRUE);
                    IF StudentCharges.FIND('-') THEN
                        ERROR('Apply payment to the charges which should be recorvered first');

                END;


                TotalApplied := 0;
                "Applied Amount" := 0;

                IF "Apply to" = TRUE THEN BEGIN
                    StudentCharges.RESET;
                    StudentCharges.SETRANGE(StudentCharges."Customer No.", "Customer No.");
                    IF StudentCharges.FIND('-') THEN BEGIN
                                                         REPEAT
                                                             TotalApplied := TotalApplied + StudentCharges."Applied Amount";
                                                         UNTIL StudentCharges.NEXT = 0;

                    END;


                END;
            end;
        }
        field(17; Recognized; Boolean)
        {
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; Programme; Code[20])
        {
        }
        field(20; Stage; Code[20])
        {
        }
        field(21; Unit; Code[20])
        {
        }
        /* field(22; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        } */
        field(23; "Recovered First"; Boolean)
        {
        }
        field(24; Transfer; Boolean)
        {
        }
        field(25; "Transfer Amount"; Decimal)
        {
        }
        field(27; Transfered; Boolean)
        {
        }
        field(28; "Transacton ID"; Code[20])
        {

            /* trigger OnValidate()
            begin
                IF "Transacton ID" <> xRec."Transacton ID" THEN BEGIN
                    GenSetup.GET;
                    NoSeriesMgt.TestManual(GenSetup."Transaction Nos.");
                    "No. Series" := '';
                END;

                IF "Transacton ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Transaction Nos.");
                    NoSeriesMgt.InitSeries(GenSetup."Transaction Nos.", xRec."No. Series", 0D, "Transacton ID", "No. Series");
                END;
            end; */
        }
        field(29; "No. Series"; Code[20])
        {
        }
        field(30; "Fully Paid"; Boolean)
        {
        }
        field(31; "Tuition Fee"; Boolean)
        {
        }
        field(32; "Room Allocation"; Code[20])
        {
            Editable = true;
            Enabled = true;
            //TableRelation = "ACA-Hostel Rooms".Code;
        }
        field(33; Charge; Boolean)
        {
        }
        field(34; Reversed; Boolean)
        {

            trigger OnValidate()
            begin
                IF CONFIRM('Are you sure you want to mark the transaction as reversed?', TRUE) = FALSE THEN
                    Reversed := FALSE;
            end;
        }
        field(35; Distribution; Decimal)
        {
        }
        field(36; Quantity; Integer)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Quantity);
                IF "Transaction Type" = "Transaction Type"::Charges THEN BEGIN
                    IF Charges.GET(Code) THEN
                        Amount := Charges."Entry No" * Quantity;
                END;
            end;
        }
        field(37; Course; Code[20])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('COURSE'));
        }
        field(39; "Applied Payment"; Decimal)
        {
        }
        field(40; "Recovery Priority"; Integer)
        {
        }
        field(41; "Full Tuition Fee"; Decimal)
        {
        }
        field(42; "Distribution Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(43; Currency; Code[20])
        {
            TableRelation = Currency.Code;
        }
        field(44; "Over Charged"; Boolean)
        {
        }
        field(45; "Over Charged Amount"; Decimal)
        {
        }
        field(46; "System Created"; Boolean)
        {
        }
        field(48; "Charge Gender"; Option)
        {
            /* CalcFormula = Lookup("ACA-Charge".Gender WHERE(Code = FIELD(Code)));
            FieldClass = FlowField; */
            OptionMembers = " ",Male,Female;
        }
        field(49; "Patient No."; Code[20])
        {
            TableRelation = "HMS-Patient"."Patient No.";
        }
        field(50; "Bill Section"; Option)
        {
            /* CalcFormula = Lookup("ACA-Class Setups".Field21 WHERE("Class Code" = FIELD(Code)));
            FieldClass = FlowField; */
            OptionCaption = 'Standing Charge,Registration,Triage,Appointment,Observation Room,Consultation Fee,Laboratory,Radiology,Pharmacy';
            OptionMembers = "Standing Charge",Registration,Triage,Appointment,"Observation Room","Consultation Fee",Laboratory,Radiology,Pharmacy;
        }
        field(2; "No Series"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Transacton ID", "Customer No.", "Patient No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        IF Recognized = TRUE THEN
        ERROR('You can not delete recognized/billed transactions.');
        GenSetup.GET;
        
        IF Date <> 0D THEN BEGIN
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.')
        END;
        */

    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        IF "Transacton ID" = '' THEN BEGIN
            NoSeriesMgt.InitSeries('CHARGETRANS', xRec."No Series", 0D, "Transacton ID", "No Series");
        END;
    end;
    /* begin
        
       StudReg.RESET;
       StudReg.SETRANGE(StudReg."Student No.","Student No.");
       IF StudReg.FIND('+') THEN BEGIN
       "Reg. Transacton ID":=StudReg."Reg. Transacton ID";
       Semester:=StudReg.Semester;
       Date:=TODAY;
       StudReg.TESTFIELD(StudReg."Registration Date");
       StudReg.VALIDATE("Reg. Transacton ID");
       END ELSE BEGIN
       ERROR('Registration does not exist.');
       END;
       

    end; */

    trigger OnModify()
    begin
        /*
        IF Recognized = TRUE THEN
        ERROR('You can not modify recognized/billed transactions.');
        GenSetup.GET;
        IF Date <> 0D THEN BEGIN
        IF (Date > GenSetup."Allow Posting To") OR (Date < GenSetup."Allow Posting From") THEN
        ERROR('Modification or deletion out of the allowed range not allowed.')
        END;
        */

    end;

    var
        Charges: Record "HMS-Class Setups";
        TotalApplied: Decimal;
        StudentCharges: Record "HMS-Patient Charges";
        NoSeriesMgt: Codeunit 396;
        //GenSetup: Record "ACA-General Set-Up";
        Cust: Record 18;
        Item: Record Item;
}

