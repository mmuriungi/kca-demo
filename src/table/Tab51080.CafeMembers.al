table 51080 "Cafe Members"
{
    Caption = 'Cafe Members';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            //TableRelation = Customer;
            TableRelation = IF ("Member Type" = CONST(staff)) Customer where("Customer Posting Group" = const('IMPREST')) else
            IF ("Member Type" = CONST(Student)) Customer where("Customer Posting Group" = const('STUDENT'));
            trigger OnValidate()
            begin
                cust.Get("No.");
                Names := cust.Name;
                "Card Serial" := posCod.GenerateHexadecimal("No.");
               


            end;
        }
        field(2; Names; Text[200])
        {
            Caption = 'Names';
        }
        field(3; "Member Type"; Option)
        {
            Caption = 'Member Type';
            OptionMembers = Staff,Student;
        }
        field(4; "Cafe Balance"; Decimal)
        {
            Caption = 'Cafe Balance';
        }
        field(5; "Card Serial"; Code[20])
        {
            Caption = 'Card Serial';
        }
        field(6; Pic; Blob)
        {
            Caption = 'Pic';
            SubType = Bitmap;
        }
        field(7; BarcodeImage; Blob)
        {
            Caption = 'Barcode';
        }
        field(8; Status; Option)
        {
            OptionMembers = Active,Blocked,Inactive;
        }
    }
    keys
    {
        key(PK; "No.", "Card Serial")
        {
            Clustered = true;
        }
    }
    var
        posCod: Codeunit "POS Management";
        cust: Record Customer;
        NoInteger: Integer;
}
