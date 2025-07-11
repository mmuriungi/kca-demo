table 50049 "PesaFlow Integration"
{
    Caption = 'PesaFlow Integration';
    DataClassification = ToBeClassified;
    LookupPageId = "PesaFlow Integration";

    fields
    {
        field(1; "PaymentRefID"; Code[50])
        {
            Caption = 'Payment Reference ID';
            DataClassification = CustomerContent;
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
        field(2; "CustomerRefNo"; Code[50])
        {
            Caption = 'Customer Reference No.';
            DataClassification = CustomerContent;
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
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(4; "InvoiceNo"; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(5; "InvoiceAmount"; Decimal)
        {
            Caption = 'Invoice Amount';
            DataClassification = CustomerContent;
        }
        field(6; "PaidAmount"; Decimal)
        {
            Caption = 'Paid Amount';
            DataClassification = CustomerContent;
        }
        field(7; "ServiceID"; Code[50])
        {
            Caption = 'Service ID';
            DataClassification = CustomerContent;
        }
        field(8; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; "PaymentChannel"; Text[50])
        {
            Caption = 'Payment Channel';
            DataClassification = CustomerContent;
        }
        field(10; "PaymentDate"; Text[50])
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(11; "Status"; Text[50])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(12; "Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(13; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = CustomerContent;
        }
        field(14; "Selected And Posted"; Boolean)
        {
            Caption = 'Selected And Posted';
            DataClassification = CustomerContent;
        }
        field(15; "Phone Number"; Code[10])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; PaymentRefID)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
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