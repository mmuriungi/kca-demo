table 52037 "Std-Charges Reversal Header"
{
    Caption = 'Std-Charges Reversal Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Std-Charges Reversal List";
    LookupPageId = "Std-Charges Reversal List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Open,"Pending Approval",Approved,Cancelled,Released,Posted;

        }
        field(5; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Std-Charger Reversal Lines".amount where("Student No." = field("Student No"), "Semester Code" = field(Semester), "Document No." = field("No.")));
        }
        field(6; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(7; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(9; Semester; Code[20])
        {
            Caption = 'Semester';
            TableRelation = "ACA-Semesters".Code;
            trigger OnValidate()
            begin
                if Confirm('To you want to Populate charges for ' + Format("Student No") + ':' + Format(Semester), true) then begin
                    Creg.reset;
                    Creg.SetRange("Student No.", Rec."Student No");
                    Creg.SetRange(Semester, Rec.Semester);
                    Creg.SetFilter(Posted, '=%1', true);
                    if Creg.Find('-') then begin
                        ReversalLines.reset;
                        ReversalLines.SetRange("Document No.", Rec."No.");
                        ReversalLines.SetRange("Student No.", rec."Student No");
                        ReversalLines.SetRange("Semester Code", Rec.Semester);
                        IF ReversalLines.Find('-') THEN begin
                            ReversalLines.DeleteAll();
                        end ELSE
                            if not ReversalLines.Find('-') then begin
                                StdCharges.reset;
                                StdCharges.SetRange("Student No.", Creg."Student No.");
                                StdCharges.SetRange(Semester, Creg.Semester);
                                StdCharges.SetFilter(Reversed, '=%1', false);
                                // StdCharges.SetFilter("Reversal Created",);
                                if StdCharges.Find('-') then begin
                                    repeat
                                    begin
                                        ReversalLines.Init();
                                        ReversalLines."Line No" := LastNo() + 1;
                                        ReversalLines."Document No." := rec."No.";
                                        ReversalLines."Semester Code" := Rec.Semester;
                                        ReversalLines."Student No." := Rec."Student No";
                                        ReversalLines."Charge Code" := StdCharges."Code";
                                        ReversalLines.Validate("Charge Code");

                                        //ReversalLines."Charge G/l Account" := StdCharges."Distribution Account";
                                        if ReversalLines."Charge G/l Account" = ' ' then
                                            ReversalLines."Charge G/l Account" := '60002';
                                        ReversalLines."Charge Description" := 'Reversal for ' + Format(Semester) + ':' + Format(StdCharges.Code);
                                        ReversalLines.amount := StdCharges.Amount;
                                        ReversalLines."Academic Year" := rec."Academic Year";

                                        ReversalLines.Insert();
                                        ReversalLines.processed := True;
                                        ReversalLines.Modify(true)

                                    end;
                                    until StdCharges.Next() = 0;
                                    StdCharges.Reversed := true;
                                    StdCharges.Modify(true)
                                end;

                            end;

                    end;
                end;
            end;
        }
        field(10; "Student No"; Code[20])
        {
            Caption = 'Student No';
            TableRelation = Customer."No." where(Blocked = filter(" "), "Customer Posting Group" = filter('Student'));
        }
        field(11; "No. Series"; code[20])
        {

        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    begin
        IF rec."No." = '' THEN BEGIN
            GenLedgerSetup.Get();

            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Std charge Reversal Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Std charge Reversal Nos", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        Rec."Document Date" := Today;
        Rec."Created By" := UserId;

    end;


    var
        GenLedgerSetup: record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        StdCharges: Record "ACA-Std Charges";
        Creg: record "ACA-Course Registration";
        ReversalLines: record "Std-Charger Reversal Lines";
        GenLine: Record 81;
        lineNo: integer;


    procedure LastNo(): Integer;
    begin
        ReversalLines.reset;
        if ReversalLines.FindLast() then
            exit(ReversalLines."Line No")
        else
            exit(0)
    end;


}
