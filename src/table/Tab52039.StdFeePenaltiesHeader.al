table 52039 "Std-Fee Penalties Header"
{
    Caption = 'Std-Fee Penalties Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; Semester; Code[20])
        {
            Caption = 'Semester';
            trigger OnValidate()
            begin
                if Confirm('Do You want to Populate Fee Penalties for ' + Format(Rec.Semester), true) then begin
                    Semesters.Reset;
                    Semesters.SetRange(Code, Rec.Semester);
                    Semesters.SetFilter("Current Semester", '=%1', true);
                    if Semesters.Find('-') then begin
                        Semesters.TestField("Penaly %");
                        Semesters.TestField("To");
                        Semesters.TestField(From);
                        PenaltyFactor := (Semesters."Penaly %" / 100);
                        AdminstrativeFactor := (Semesters."Adminstrative Fee %" / 100);
                        Stardate := Semesters.from;
                        Enddate := Semesters."To";
                        Creg.Reset;
                        Creg.SetRange(Semester, Semesters.Code);
                        Creg.SetFilter(Reversed, '=%1', false);
                        Creg.SetFilter(Posted, '=%1', true);
                        if Creg.Find('-') then begin

                        end;



                    end;



                end;

            end;

        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Open,"Pending Approval",Approved,Cancelled,Released,Posted;
        }
        field(6; Posted; Boolean)
        {
            Caption = 'Posted';
        }
        field(7; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(8; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
        }
        field(9; "No Of Students"; Integer)
        {
            Caption = 'No Of Students';
            FieldClass = FlowField;
            CalcFormula = count("std Fee penalties Line" where("Document No." = field("Document No."), "Semester Code" = field(Semester)));
        }
        field(10; "No. Series"; code[20])
        {

        }
    }

    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        IF rec."Document No." = '' THEN BEGIN
            GenLedgerSetup.Get();

            GenLedgerSetup.TESTFIELD(GenLedgerSetup."Fee Penalty Nos");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Fee Penalty Nos", xRec."No. Series", 0D, "Document No.", "No. Series");
        END;
        Rec."Posting Date" := Today;
        Rec."Created By" := UserId;

    end;

    var
        GenLedgerSetup: record "ACA-General Set-Up";
        NoSeriesMgt: codeunit NoSeriesManagement;
        FeePenaltyLines: Record "std Fee penalties Line";
        Cust: record Customer;
        Semesters: Record "ACA-Semesters";
        Balance: decimal;
        PenaltyFactor: Decimal;
        AdminstrativeFactor: decimal;
        Creg: Record "ACA-Course Registration";
        Stardate: date;
        Enddate: date;

}
