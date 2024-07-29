table 52041 "Aca-Charge Addition Lines"
{
    LookupPageId = "Aca-Charge Addition Lines";
    DrillDownPageId = "Aca-Charge Addition Lines";
    fields
    {
        field(1; "Document No."; code[30])
        {

        }
        field(2; "Academic Year"; code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(3; "Semester"; code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(4; "Student No."; code[20])
        {
            TableRelation = Customer."No." where("Customer Type" = filter(student));
            trigger OnValidate()
            var
                cheader: Record "Aca-Charge Addition";
                cust: Record Customer;
            begin
                cheader.Reset();
                cheader.SetRange("No.", "Document No.");
                if cheader.Find('-') then begin
                    cheader.TestField("Academic Year");
                    cheader.TestField(Semester);
                    "Academic Year" := cheader."Academic Year";
                    Semester := cheader.Semester;
                end;

                cust.Reset();
                cust.SetRange("No.", "Student No.");
                if cust.find('-') then
                    "Student Name" := cust.Name;
            end;
        }
        field(5; "Stage"; code[20])
        {
            TableRelation = "ACA-Course Registration".Stage where("Student No." = field("Student No."), "Academic Year" = field("Academic Year"), Semester = field(Semester));
            trigger OnValidate()
            var
                Reg: Record "ACA-Course Registration";
            begin
                Reg.Reset();
                Reg.SetRange("Student No.", "Student No.");
                Rec.SetRange("Academic Year", "Academic Year");
                Reg.SetRange(Semester, Semester);
                Reg.SetRange(Stage, Stage);
                if Reg.Find('-') then begin
                    Rec."Reg. Transacton ID" := Reg."Reg. Transacton ID";
                    Rec.Programme := Reg.Programmes;
                end;

            end;
        }
        field(6; "Reg. Transacton ID"; Code[30])
        {

        }
        field(7; "Charge Code"; Code[30])
        {
            TableRelation = "ACA-Charge"."Code";
            trigger OnValidate()
            var
                chrge: Record "ACA-Charge";
            begin
                chrge.Reset();
                chrge.SetRange("Code", "Charge Code");
                if chrge.Find('-') then begin
                    chrge.TestField("G/L Account");
                    // chrge.TestField("Recovery Priority");
                    "Income Account" := chrge."G/L Account";
                    // Priority := chrge."Recovery Priority";
                    "Charge Description" := chrge.Description;
                    Validate("Transaction ID");
                end;


            end;
        }
        field(8; "Income Account"; code[30])
        {
            TableRelation = "G/L Account"."No." where("Account Type" = filter(Posting));
        }
        field(9; "Priority"; Integer)
        {

        }
        field(10; "Student Name"; Text[100])
        {

        }
        field(11; "Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Student No.")));
        }
        field(12; "Student Prepaid"; Decimal)
        {
            Editable = false;
            //CalcFormula = Sum("ACA-Std Receipts Prepayments".Amount WHERE("Student No." = FIELD("Student No.")));
            //FieldClass = FlowField;
        }
        field(13; "Transaction ID"; code[20])
        {
            trigger OnValidate()
            begin
                IF "Transaction ID" = '' THEN BEGIN
                    GenSetup.GET;
                    GenSetup.TESTFIELD(GenSetup."Transaction Nos.");
                    "Transaction ID" := NoSeriesMgt.GetNextNo(GenSetup."Transaction Nos.", 0D, true);
                END;
            end;
        }
        field(14; Amount; Decimal)
        {

        }
        field(15; "Charge Description"; Text[100])
        {

        }
        field(16; "Programme"; code[30])
        {
            TableRelation = "ACA-Programme"."Code";
        }
        field(17; "Posted"; Boolean)
        {

        }

    }

    keys
    {
        key(pk; "Student No.", "Document No.", "Charge Code")
        {

        }
    }

    var
        GenSetup: Record "ACA-General Set-Up";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}