table 51139 "HMS-Pharmacy Header"
{
    LookupPageID = "HMS Pharmacy List";

    fields
    {
        field(1; "Pharmacy No."; Code[20])
        {
        }
        field(2; "Pharmacy Date"; Date)
        {
        }
        field(3; "Pharmacy Time"; Time)
        {
        }
        field(4; "Request Area"; Option)
        {
            OptionMembers = Doctor,Admissions;
        }
        field(5; "Patient No."; Code[20])
        {
        }
        field(6; "Student No."; Code[20])
        {
        }
        field(7; "Employee No."; Code[20])
        {
        }
        field(8; "Relative No."; Integer)
        {
        }
        field(9; "Bill To Customer No."; Code[20])
        {
        }
        field(10; "Issued By"; Code[20])
        {
        }
        field(12; "Link Type"; Code[20])
        {
        }
        field(13; "Link No."; Code[20])
        {
        }
        field(14; Status; Option)
        {
            OptionMembers = New,Completed,Cancelled;
        }
        field(15; "No. Series"; Code[20])
        {
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Surname WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = Lookup("HMS-Patient"."Middle Name" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = Lookup("HMS-Patient"."Last Name" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."ID Number" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient"."Correspondence Address 1" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = Lookup("HMS-Patient"."Telephone No. 1" WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = Lookup("HMS-Patient".Email WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = Lookup("HMS-Patient"."Patient Ref. No." WHERE("Patient No." = FIELD("Patient No.")));
            FieldClass = FlowField;
        }
        field(36; "Full Name"; text[100])
        {

        }
        field(37; "Treatment No."; code[20])
        {

        }
    }



    keys
    {
        key(Key1; "Pharmacy No.")
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Pharmacy No." = '' THEN BEGIN
            HMSSetup.GET;
            HMSSetup.TESTFIELD("Pharmacy Nos");
            NoSeriesMgt.InitSeries(HMSSetup."Pharmacy Nos", xRec."No. Series", 0D, "Pharmacy No.", "No. Series");
        END;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        Patient: Record "HMS-Patient";
        PharItems: Record Item;
        itemledger: Record "Pharmacy Item Ledger";
        PharHeader: Record "HMS-Pharmacy Header";

        drug: Record "HMS-Treatment Form Drug";
        Treatment: Record "HMS-Treatment Form Header";


    Procedure PostPharmacy()
    begin
        If Confirm('Are you sure you want to post ?', true) = false then Error('Cancelled');
        if Rec.Status = Rec.Status::Completed then Error('The order if already completed');
        MarkasComplete();
        PharHeader.Reset();
        PharHeader.SetRange("Pharmacy No.", "Pharmacy No.");
        if PharHeader.Find('-') then begin
            drug.Reset();
            drug.SetRange("Pharmacy No.", "Pharmacy No.");
            drug.SetRange(Issued, false);
            drug.SetFilter("Drug No.", '<>%1', '');
            if drug.Find('-') then begin
                repeat
                    itemledger.Init();
                    itemledger."Entry No." := GetLastEntryNo + 1;
                    itemledger."Item No." := Drug."Drug No.";
                    itemledger."Posting Date" := Today();
                    itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
                    itemledger."Document No." := Rec."Pharmacy No.";
                    itemledger.Description := drug."Drug Name";
                    itemledger.Quantity := -drug.Quantity;
                    itemledger.Insert(true);
                    drug.Issued := true;
                    drug.Modify(true);
                until drug.Next() = 0;
            end;
        end;
        Message('Posted Successifully');

    end;

    procedure PostPharmacyItems()
    var
        LineNo: Integer;
        ItemJnlLine: Record "Item Journal Line";
        Drug: Record "HMS-Treatment Form Drug";
        Location: Record Location;
        Item: Record Item;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        HMSSetup.GET;
        Location.Reset();
        Location.SetRange("Pharmacy Category", Location."Pharmacy Category"::"Dispensing Store");
        if Location.FindFirst() then;
        Drug.Reset();
        Drug.SetRange("Pharmacy No.", Rec."Pharmacy No.");
       // Drug.SetRange(Issued, true);
        Drug.SetFilter("Drug No.", '<>%1', '');
        if Drug.Find('-') then begin
            repeat
                Item.Reset;
                Item.SetRange("No.", Drug."Drug No.");
                if Item.FindFirst() then;
                LineNo := LineNo + 1000;
                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                ItemJnlLine."Line No." := LineNo;
                ItemJnlLine."Posting Date" := TODAY;
                ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Document No." := Rec."Pharmacy No." + ':' + Drug."Drug No.";
                ItemJnlLine."Item No." := Drug."Drug No.";
                ItemJnlLine.VALIDATE(ItemJnlLine."Item No.");
                ItemJnlLine."Location Code" := Location.Code;
                ItemJnlLine.VALIDATE(ItemJnlLine."Location Code");
                ItemJnlLine.Quantity := Drug.Quantity;
                ItemJnlLine.VALIDATE(ItemJnlLine.Quantity);
                ItemJnlLine."Unit of Measure Code" := Item."Base Unit of Measure";
                ItemJnlLine.VALIDATE(ItemJnlLine."Unit of Measure Code");
                ItemJnlLine."Unit Amount" := Item."Unit Price";
                ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                ItemJnlLine.INSERT(True);
                ItemJnlPostLine.RunWithCheck(ItemJnlLine);
                Drug.Issued:=true;
                Drug.Modify();
            until Drug.Next() = 0;
            Rec.Status := Rec.Status::Completed;
            Rec.Modify(true);
            Message('Posted Successifully');
        end else
            Message('No Items to Post!');
    end;

    procedure MarkasComplete()
    begin
        Treatment.Reset();
        Treatment.SetRange("Treatment No.", "Treatment No.");
        if Treatment.Find('-') then begin
            IF CONFIRM('Mark the Treatment as Completed and Post Dosage?', FALSE) = FALSE THEN BEGIN EXIT END;
            Treatment.Status := Rec.Status::Completed;
            Treatment.MODIFY;

            Rec.Status := Rec.Status::Completed;
            Rec.Modify(true);
            MESSAGE('Treatment Marked as Completed');
        end;

    end;

    procedure GetLastEntryNo(): Integer;
    begin
        itemledger.Reset();
        if itemledger.FindLast() then
            exit(itemledger."Entry No.")
        else
            exit(0);
    end;
}

