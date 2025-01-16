table 50987 "POS Sales Header"
{
    DrillDownPageId = "POS Sales Header List";
    LookupPageId = "POS Sales Header List";
    fields
    {
        field(1; "No."; code[30])
        {
            Editable = false;
            Caption = 'Ref. No.';
        }
        field(2; "Posting Description"; Text[50])
        {
            Editable = false;
        }
        field(3; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = sum("POS Sales Lines"."Line Total" where("Document No." = field("No.")));
        }
        field(5; "Posting Date"; date)
        {
            Editable = false;
        }
        field(6; "Cashier"; code[20])
        {
            TableRelation = "User Setup";
            Editable = false;
        }
        field(7; "Customer Type"; Option)
        {
            OptionMembers = Student,Staff,NonRevenue;
            //Editable = false;
            trigger OnValidate()
            begin
                PosSetup.GET;
                PosSetup.TestField("Students Cashbook");
                PosSetup.TestField("Students Sales Account");
                PosSetup.TestField("Staff Sales Account");
                PosSetup.TestField("Staff Cashbook");
                if "Customer Type" = "Customer Type"::Student then begin
                    Rec."Bank Account" := PosSetup."Students Cashbook";
                    Rec."Income Account" := PosSetup."Students Sales Account";
                end else
                    if "Customer Type" = "Customer Type"::Staff then begin
                        Rec."Bank Account" := PosSetup."Staff Cashbook";
                        Rec."Income Account" := PosSetup."Staff Sales Account";
                    end;
                // clearLines();
            end;
        }
        field(8; "Bank Account"; code[20])
        {
        }
        field(9; "Income Account"; code[20])
        {
        }
        field(10; "Amount Paid"; Decimal)
        {

            trigger OnValidate()
            var
                posLines: Record "POS Sales Lines";
                totamount: Decimal;
            begin
                totamount := 0;
                posLines.Reset();
                posLines.SetRange("Document No.", Rec."No.");
                if posLines.Find('-') then begin
                    repeat
                        totamount := totamount + posLines."Line Total";
                    until posLines.Next() = 0;
                    if "Amount Paid" >= totamount then begin
                        Balance := "Amount Paid" - totamount;
                    end else
                        error('The Amount Paid is Less');
                end;

            end;
        }
        field(11; Balance; Decimal)
        {
            Editable = false;
        }
        field(50; "No. Series"; code[30])
        {

        }
        field(51; "Posted"; Boolean)
        {
            Editable = false;
        }
        field(52; "Current Date Time"; DateTime)
        {
        }
        field(53; "Institute Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(54; "Customer No."; code[20])
        {
            TableRelation = IF ("Customer Type" = const(Staff)) "Cafe Members"."Card Serial" where("Member Type" = const(Staff)) else if ("Customer Type" = const(Student)) "Cafe Members"."Card Serial" where("Member Type" = const(Student));
        }
    }
    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            PosSetup.GET;
            PosSetup.TESTFIELD(PosSetup."Sales No.");
            NoSeriesMgt.InitSeries(PosSetup."Sales No.", xRec."No. Series", 0D, "No.", "No. Series");
            "Posting Description" := 'Cafe Food sales on ' + format(Today());
            "Posting Date" := Today();
            Cashier := UserId;
            "Current Date Time" := System.CurrentDateTime();
            Rec."Bank Account" := PosSetup."Students Cashbook";
            Rec."Income Account" := PosSetup."Students Sales Account";
        END;

    end;

    trigger OnDelete()
    var
        PosLine: Record "POS Sales Lines";
    begin
        UserSetup.Reset();
        if UserSetup.Get(UserId) and UserSetup."Approval Administrator" then
            If Confirm('Delete This Record ?', true) = false then
                error('Cancelled') else
                error('Permission Denied !');
        PosLine.Reset();
        PosLine.SetRange("Document No.", Rec."No.");
        PosLine.DeleteAll();

    end;

    var
        UserSetup: Record "User Setup";
        PosSetup: Record "POS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        posLines: record "POS Sales Lines";
        GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        LineNo: Integer;
        itemledger: Record "POS Item Ledger";
        posItems: Record "POS Items";
        Err: Label 'You cannot post a cash sale with amount less that 0';


    procedure clearLines()
    begin
        posLines.Reset();
        posLines.SetRange("Document No.", "No.");
        posLines.DeleteAll();
    end;

    procedure PostSale()
    begin

        // Delete Lines Present on the General Journal Line
        PosSetup.Get();
        GenJnLine.RESET;
        GenJnLine.SETRANGE(GenJnLine."Journal Template Name", PosSetup."Journal Template Name");
        GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", "No.");
        GenJnLine.DELETEALL;

        Batch.INIT;
        Batch."Journal Template Name" := PosSetup."Journal Template Name";
        Batch.Name := "No.";
        IF NOT Batch.GET(Batch."Journal Template Name", Batch.Name) THEN
            Batch.INSERT;
        //Debit Post acquisition
        LineNo := LineNo + 1000;
        GenJnLine.INIT;
        GenJnLine."Journal Template Name" := PosSetup."Journal Template Name";
        GenJnLine."Journal Batch Name" := "No.";
        GenJnLine."Line No." := LineNo;
        GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
        GenJnLine."Shortcut Dimension 1 Code" := PosSetup."Department Code";
        GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
        GenJnLine."Account No." := "Bank Account";
        GenJnLine."Posting Date" := "Posting Date";
        GenJnLine."Document No." := "No.";
        GenJnLine.Description := 'Food sales for ' + format("Customer Type") + 'at ' + Format(CurrentDateTime);
        CalcFields("Total Amount");
        if "Total Amount" < 1 then
            Error(Err);
        GenJnLine.Amount := "Total Amount";
        GenJnLine.VALIDATE(GenJnLine.Amount);
        GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::"G/L Account";
        GenJnLine."Bal. Account No." := "Income Account";
        IF GenJnLine.Amount <> 0 THEN
            GenJnLine.INSERT(True);
        // CODEUNIT.RUN(CODEUNIT::"Modified Gen. Jnl.-Post2", GenJnLine);
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJnLine);
        Batch.setrange("Journal Template Name", PosSetup."Journal Template Name");
        Batch.setrange(Name, "No.");
        Batch.Delete();

        PosSetup.Get();
        posLines.Reset();
        posLines.SetRange("Document No.", "No.");
        if posLines.Find('-') then begin
            repeat
                itemledger.Init();
                itemledger."Entry No." := GetLastEntryNo + 1;
                itemledger."Item No." := posLines."No.";
                itemledger."Document No." := posLines."No." + posLines."Document No.";
                itemledger."Entry Type" := itemledger."Entry Type"::"Negative Adjmt.";
                itemledger."Posting Date" := "Posting Date";
                itemledger.Quantity := -posLines.Quantity;
                itemledger.Description := posLines.Description;
                itemledger.Insert(true);
                posLines.Posted := true;
                posLines.Modify();
            until posLines.Next() = 0;
        end;

        //modify posted
        Posted := True;
        Modify(true);

    end;

    procedure GetLastEntryNo(): Integer;
    var
        PosLedger: Record "POS Item Ledger";
    begin
        PosLedger.Reset();
        if PosLedger.FindLast() then
            exit(PosLedger."Entry No.")
        else
            exit(0);
    end;
}