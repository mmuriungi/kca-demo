table 52038 "Std-Charger Reversal Lines"
{
    Caption = 'Std-Charger Reversal Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "ACA-Std Charges"."Student No.";
        }
        field(4; "Charge Code"; Code[20])
        {
            Caption = 'Charge Code';
            // TableRelation = "ACA-Std Charges".Code;
            trigger OnValidate()
            var
                Charges: Record "ACA-Charge";
            begin
                Charges.reset;
                Charges.SetRange(Charges.Code, Rec."Charge Code");
                if Charges.Find('-') then begin
                    Rec."Charge G/l Account" := Charges."G/L Account";
                end;

            end;
        }
        field(5; "Charge Description"; Text[250])
        {
            Caption = 'Charge Description';
        }
        field(6; "Charge G/l Account"; Code[20])
        {
            Caption = 'Charge G/l Account';
        }
        field(7; "Semester Code"; Code[20])
        {
            Caption = 'Semester Code';
            TableRelation = "ACA-Semesters".Code;
        }
        field(8; amount; Decimal)
        {
            Caption = 'amount';
        }
        field(9; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "ACA-Academic Year".Code;
        }
        field(10; processed; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Line No", "Document No.", "Semester Code", "Student No.")
        {
            Clustered = true;
        }




    }
}
