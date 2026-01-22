table 50163 "PesaFlow Intergration"
{
    Caption = 'PesaFlow Intergration';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PaymentRefID; Code[50])
        {
            Caption = 'Payment Reference ID';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CLEAR(NumberOfCharacters);
                CLEAR(CountedCharacters);
                IF STRLEN(CustomerRefNo) > 9 THEN BEGIN

                    NumberOfCharacters := COPYSTR(CustomerRefNo, (STRLEN(CustomerRefNo) - 9), 9);
                END;
                "Phone Number" := '0' + NumberOfCharacters;
            end;
        }
        field(2; CustomerRefNo; Code[50])
        {
            Caption = 'Customer Reference No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CLEAR(NumberOfCharacters);
                CLEAR(CountedCharacters);
                IF STRLEN(CustomerRefNo) > 9 THEN BEGIN

                    NumberOfCharacters := COPYSTR(CustomerRefNo, (STRLEN(CustomerRefNo) - 9), 9);
                END;
                "Phone Number" := '0' + NumberOfCharacters;
            end;
        }
        field(3; "Customer Name"; Text[150])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(4; InvoiceNo; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(5; InvoiceAmount; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = ToBeClassified;
        }
        field(6; PaidAmount; Decimal)
        {
            Caption = 'Paid Amount';
            DataClassification = ToBeClassified;
        }
        field(7; ServiceID; Code[50])
        {
            Caption = 'Service ID';
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(9; PaymentChannel; Text[50])
        {
            Caption = 'Payment Channel';
            DataClassification = ToBeClassified;
        }
        field(10; PaymentDate; Text[50])
        {
            Caption = 'Payment Date';
            DataClassification = ToBeClassified;
        }
        field(11; Status; Text[50])
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(12; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
        field(13; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = ToBeClassified;
        }
        field(14; "Selected And Posted"; Boolean)
        {
            Caption = 'Selected And Posted';
            DataClassification = ToBeClassified;
        }
        field(15; "Phone Number"; Code[10])
        {
            Caption = 'Phone Number';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; PaymentRefID)
        {
            Clustered = true;
        }
    }

    trigger oninsert()
    begin
        CLEAR(NumberOfCharacters);
        CLEAR(CountedCharacters);
        IF STRLEN(CustomerRefNo) > 9 THEN BEGIN

            NumberOfCharacters := COPYSTR(CustomerRefNo, (STRLEN(CustomerRefNo) - 9), 9);
        END;
        "Phone Number" := '0' + NumberOfCharacters;
    end;

    var
        NumberOfCharacters: Code[10];
        CountedCharacters: Code[10];
}
