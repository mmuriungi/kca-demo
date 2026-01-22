table 50109 "FIN-Collection  Header Buffer"
{
    Caption = 'FIN-Collection  Header Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Payee Name"; Text[250])
        {
            Caption = 'Payee Name';
        }
        field(4; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
        }
        field(5; "TIME"; Time)
        {
            Caption = 'TIME';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "PV No"; Code[20])
        {
            Caption = 'PV No';
        }
        field(8; "Received By"; Text[100])
        {

        }
        field(9; "Remarks"; Text[250])
        {

        }
        field(10; "Posted By"; code[20])
        {

        }
        field(11; "Line No"; Integer)
        {
            AutoIncrement = true;

        }
    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
        key(key1; No) { }
    }
}
